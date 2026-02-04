import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/project.dart';
import 'glass_card.dart';

/// Project card widget with hover effects - Compact version
class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  Color _getStatusColor() {
    switch (widget.project.status) {
      case ProjectStatus.production:
        return AppColors.accentGreen;
      case ProjectStatus.live:
        return AppColors.accentCyan;
      case ProjectStatus.beta:
        return AppColors.accentPurple;
      case ProjectStatus.pilot:
        return AppColors.accentBlue;
      case ProjectStatus.maintenance:
        return AppColors.warning;
      case ProjectStatus.ongoing:
        return AppColors.accentPink;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: _isHovered
            ? (Matrix4.identity()..setTranslationRaw(0.0, -4.0, 0.0))
            : Matrix4.identity(),
        child: GlassCard(
          padding: const EdgeInsets.all(16),
          backgroundColor: _isHovered
              ? AppColors.glassWhite.withValues(alpha: 0.15)
              : AppColors.glassWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with status badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.project.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: _isHovered ? 0.3 : 0.2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: statusColor.withValues(alpha: _isHovered ? 0.8 : 0.5),
                      ),
                    ),
                    child: Text(
                      widget.project.statusLabel,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Subtitle
              Text(
                widget.project.subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.accentCyan,
                      fontWeight: FontWeight.w500,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // Key feature - compact
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.key,
                      size: 14,
                      color: AppColors.accentPurple,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        widget.project.keyFeature,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Description
              Expanded(
                child: Text(
                  widget.project.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              // Technologies - compact
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: widget.project.technologies.map((tech) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.accentBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.accentBlue.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      tech,
                      style: const TextStyle(
                        color: AppColors.accentBlue,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
