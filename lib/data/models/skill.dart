import 'package:equatable/equatable.dart';

/// Skill model with category
class Skill extends Equatable {
  final String name;
  final String category;

  const Skill({
    required this.name,
    required this.category,
  });

  @override
  List<Object?> get props => [name, category];

  static List<Skill> get allSkills => [
        const Skill(name: 'Flutter development', category: 'Core'),
        const Skill(name: 'Mobile application development', category: 'Core'),
        const Skill(name: 'API integration', category: 'Core'),
        const Skill(name: 'API development', category: 'Core'),
        const Skill(name: 'SQL database management', category: 'Backend'),
        const Skill(name: 'Git version control', category: 'DevOps'),
        const Skill(name: 'Version Control', category: 'DevOps'),
        const Skill(name: 'Problem solving', category: 'Soft Skills'),
        const Skill(name: 'Team collaboration', category: 'Soft Skills'),
        const Skill(name: 'Creative thinking', category: 'Soft Skills'),
        const Skill(name: 'Decision making', category: 'Soft Skills'),
        const Skill(name: 'Critical-thinking', category: 'Soft Skills'),
        const Skill(name: 'Code debugging', category: 'Technical'),
        const Skill(name: 'Technical troubleshooting', category: 'Technical'),
        const Skill(name: 'Quality Assurance', category: 'Technical'),
        const Skill(name: 'Code review proficiency', category: 'Technical'),
      ];
}
