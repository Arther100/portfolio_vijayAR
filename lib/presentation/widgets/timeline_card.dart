import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/experience.dart';
import 'glass_card.dart';

/// Timeline card for experience section
class TimelineCard extends StatefulWidget {
  final Experience experience;
  final bool isLast;

  const TimelineCard({
    super.key,
    required this.experience,
    this.isLast = false,
  });

  @override
  State<TimelineCard> createState() => _TimelineCardState();
}

class _TimelineCardState extends State<TimelineCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline indicator
            _buildTimelineIndicator(),
            const SizedBox(width: 24),
            // Content
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineIndicator() {
    return Column(
      children: [
        // Dot
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: widget.experience.isCurrent || _isHovered
                ? AppColors.primaryGradient
                : null,
            color: widget.experience.isCurrent || _isHovered
                ? null
                : AppColors.primaryLight,
            border: Border.all(
              color: widget.experience.isCurrent
                  ? AppColors.accentPurple
                  : AppColors.glassBorder,
              width: 2,
            ),
            boxShadow: widget.experience.isCurrent || _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.accentPurple.withValues(alpha: 0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
        ),
        // Line
        if (!widget.isLast)
          Expanded(
            child: Container(
              width: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.accentPurple.withValues(alpha: 0.5),
                    AppColors.accentPurple.withValues(alpha: 0.1),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContent() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 32),
      child: GlassCard(
        backgroundColor: _isHovered
            ? AppColors.glassWhite.withValues(alpha: 0.15)
            : AppColors.glassWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.experience.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.experience.company,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.accentPurple,
                            ),
                      ),
                    ],
                  ),
                ),
                if (widget.experience.isCurrent)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Current',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            // Location & Duration
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 4),
                Text(
                  widget.experience.location,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 4),
                Text(
                  widget.experience.duration,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: AppColors.glassBorder),
            const SizedBox(height: 16),
            // Responsibilities
            ...widget.experience.responsibilities.map((responsibility) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.accentCyan,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        responsibility,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
