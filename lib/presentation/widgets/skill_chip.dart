import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Animated skill chip widget
class SkillChip extends StatefulWidget {
  final String label;
  final String? category;
  final int index;

  const SkillChip({
    super.key,
    required this.label,
    this.category,
    this.index = 0,
  });

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getCategoryColor() {
    switch (widget.category) {
      case 'Core':
        return AppColors.accentPurple;
      case 'Backend':
        return AppColors.accentBlue;
      case 'DevOps':
        return AppColors.accentCyan;
      case 'Technical':
        return AppColors.accentGreen;
      case 'Soft Skills':
        return AppColors.accentPink;
      default:
        return AppColors.accentPurple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getCategoryColor();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: _isHovered
              ? LinearGradient(
                  colors: [color.withValues(alpha: 0.3), color.withValues(alpha: 0.1)])
              : null,
          color: _isHovered ? null : color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: _isHovered ? color : color.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 12,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: _isHovered ? Colors.white : color,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
