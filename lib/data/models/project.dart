import 'package:equatable/equatable.dart';

enum ProjectStatus {
  production,
  live,
  beta,
  pilot,
  maintenance,
  ongoing,
}

/// Project model for portfolio projects
class Project extends Equatable {
  final String name;
  final String subtitle;
  final String description;
  final String keyFeature;
  final ProjectStatus status;
  final List<String> technologies;

  const Project({
    required this.name,
    required this.subtitle,
    required this.description,
    required this.keyFeature,
    required this.status,
    this.technologies = const [],
  });

  String get statusLabel {
    switch (status) {
      case ProjectStatus.production:
        return 'In Production';
      case ProjectStatus.live:
        return 'Live';
      case ProjectStatus.beta:
        return 'Beta';
      case ProjectStatus.pilot:
        return 'Pilot';
      case ProjectStatus.maintenance:
        return 'Active Maintenance';
      case ProjectStatus.ongoing:
        return 'Ongoing Updates';
    }
  }

  @override
  List<Object?> get props => [name, subtitle, description, keyFeature, status, technologies];

  static List<Project> get allProjects => [
        const Project(
          name: 'Sage',
          subtitle: 'TimeSlip & Payroll Management App',
          description: 'Easy employee time tracking with automated payroll calculation, deductions, and reporting.',
          keyFeature: 'Centralized Payroll & TimeSlip Tracking',
          status: ProjectStatus.production,
          technologies: ['Flutter', 'REST API', 'SQL'],
        ),
        const Project(
          name: 'Farm 7 Days',
          subtitle: 'ERP for Livestock & Meat Sales',
          description: 'End-to-end ERP built with Flutter and custom framework for livestock, sales, and billing.',
          keyFeature: 'Dynamic pricing, KOT printing, offline-first sync',
          status: ProjectStatus.production,
          technologies: ['Flutter', 'Custom Framework', 'Offline Sync'],
        ),
        const Project(
          name: 'Meatproteins',
          subtitle: 'Meat Shop POS',
          description: 'Cross-platform POS for meat shops with real-time inventory and weight-based billing.',
          keyFeature: 'Multi-unit pricing, reusable UI, printing integration',
          status: ProjectStatus.maintenance,
          technologies: ['Flutter', 'POS', 'Printing'],
        ),
        const Project(
          name: 'Rupos',
          subtitle: 'Retail POS System',
          description: 'Flutter-based POS with back-office admin, offline sync, and multi-platform support.',
          keyFeature: 'Dynamic discounts, user management, DevOps deployment',
          status: ProjectStatus.live,
          technologies: ['Flutter', 'DevOps', 'Multi-platform'],
        ),
        const Project(
          name: 'Spaid',
          subtitle: 'Ice Hockey Score Streaming App',
          description: 'Sports management app for live match tracking and streaming.',
          keyFeature: 'Real-time scores, Firebase sync, WebSocket integration',
          status: ProjectStatus.ongoing,
          technologies: ['Flutter', 'Firebase', 'WebSocket'],
        ),
        const Project(
          name: 'Customer Order Entry',
          subtitle: 'Bulk Order App',
          description: 'Cross-platform bulk order app for distributors.',
          keyFeature: 'Offline storage, auto sync, responsive UI',
          status: ProjectStatus.production,
          technologies: ['Flutter', 'Offline First', 'Sync'],
        ),
        const Project(
          name: 'Teapioca',
          subtitle: 'Coffee Shop Kiosk App',
          description: 'Self-service kiosk app with payment gateway integration.',
          keyFeature: 'Modern kiosk UI, admin setup, smooth tablet UX',
          status: ProjectStatus.production,
          technologies: ['Flutter', 'Payment Gateway', 'Kiosk'],
        ),
        const Project(
          name: 'Pitch Matters',
          subtitle: 'Investor Matchmaking App',
          description: 'Startup–investor connection app using location and interest matching.',
          keyFeature: 'Matching algorithm, geolocation, responsive UI',
          status: ProjectStatus.beta,
          technologies: ['Flutter', 'Geolocation', 'Algorithm'],
        ),
        const Project(
          name: 'Tucker',
          subtitle: 'EV Charging App',
          description: 'EV charging and monitoring app with maps and payments.',
          keyFeature: 'Navigation, real-time status, secure payments',
          status: ProjectStatus.beta,
          technologies: ['Flutter', 'Maps', 'Payments'],
        ),
        const Project(
          name: 'Fatafat',
          subtitle: 'Utility & Reward App',
          description: 'Smart utility reading app with reward system.',
          keyFeature: 'IoT data, real-time sync, usage insights',
          status: ProjectStatus.pilot,
          technologies: ['Flutter', 'IoT', 'Rewards'],
        ),
      ];
}
