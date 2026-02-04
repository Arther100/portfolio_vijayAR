import 'package:equatable/equatable.dart';

/// Accomplishment model
class Accomplishment extends Equatable {
  final String title;
  final String description;

  const Accomplishment({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];

  static List<Accomplishment> get allAccomplishments => [
        const Accomplishment(
          title: 'AI Training & Chatbot Development',
          description:
              'Conducted AI training sessions and developed custom conversational bots, leading end-to-end project implementation from design to deployment.',
        ),
        const Accomplishment(
          title: 'n8n Automation Solutions',
          description:
              'Developed fully functional chatbots using n8n and AI automation, implementing real-world solutions for data extraction, workflow automation, and customer support systems.',
        ),
      ];
}
