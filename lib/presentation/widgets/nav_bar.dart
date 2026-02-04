import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../blocs/navigation/navigation_bloc.dart';

/// Responsive navigation bar
class NavBar extends StatelessWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;

  const NavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 48,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryDark.withValues(alpha: 0.9),
        border: const Border(
          bottom: BorderSide(color: AppColors.glassBorder),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          GestureDetector(
            onTap: () => _scrollToSection(context, AppConstants.heroSection),
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => AppColors.primaryGradient
                  .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
              child: Text(
                'VA',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          // Navigation items
          if (!isMobile) _buildNavItems(context),
          // Mobile menu button
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => _showMobileMenu(context),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItems(BuildContext context) {
    final items = [
      ('About', AppConstants.aboutSection),
      ('Skills', AppConstants.skillsSection),
      ('Experience', AppConstants.experienceSection),
      ('Projects', AppConstants.projectsSection),
      ('Contact', AppConstants.contactSection),
    ];

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Row(
          children: items.map((item) {
            final isActive = state.currentSection == item.$2;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _NavItem(
                label: item.$1,
                isActive: isActive,
                onTap: () => _scrollToSection(context, item.$2),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _scrollToSection(BuildContext context, String sectionId) {
    context.read<NavigationBloc>().add(NavigateToSection(sectionId));
    final key = sectionKeys[sectionId];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.primaryDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _MobileMenu(
        scrollController: scrollController,
        sectionKeys: sectionKeys,
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isActive || _isHovered
                ? AppColors.accentPurple.withValues(alpha: 0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.isActive || _isHovered
                  ? AppColors.accentPurple
                  : AppColors.textSecondary,
              fontWeight:
                  widget.isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;

  const _MobileMenu({
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      ('About', AppConstants.aboutSection, Icons.person_outline),
      ('Skills', AppConstants.skillsSection, Icons.code),
      ('Experience', AppConstants.experienceSection, Icons.work_outline),
      ('Projects', AppConstants.projectsSection, Icons.folder_outlined),
      ('Contact', AppConstants.contactSection, Icons.mail_outline),
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.glassBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          ...items.map((item) => ListTile(
                leading: Icon(item.$3, color: AppColors.accentPurple),
                title: Text(item.$1),
                onTap: () {
                  Navigator.pop(context);
                  context.read<NavigationBloc>().add(NavigateToSection(item.$2));
                  final key = sectionKeys[item.$2];
                  if (key?.currentContext != null) {
                    Scrollable.ensureVisible(
                      key!.currentContext!,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOutCubic,
                    );
                  }
                },
              )),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
