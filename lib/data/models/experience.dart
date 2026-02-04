import 'package:equatable/equatable.dart';

/// Experience model for work history
class Experience extends Equatable {
  final String title;
  final String company;
  final String location;
  final String duration;
  final List<String> responsibilities;
  final bool isCurrent;

  const Experience({
    required this.title,
    required this.company,
    required this.location,
    required this.duration,
    required this.responsibilities,
    this.isCurrent = false,
  });

  @override
  List<Object?> get props => [title, company, location, duration, responsibilities, isCurrent];

  static List<Experience> get allExperiences => [
        const Experience(
          title: 'Software Engineer',
          company: 'CI Global Technologies',
          location: 'Chennai',
          duration: '08/2023 - Current',
          isCurrent: true,
          responsibilities: [
            'Developed and implemented responsive mobile applications using Flutter, enhancing user experience and engagement.',
            'Integrated RESTful APIs and third-party libraries, optimizing application performance and functionality.',
            'Evaluated functionality and performance of existing software to best target new releases.',
            'Kept detailed records of releases and software fixes for optimum traceability.',
          ],
        ),
        const Experience(
          title: 'Junior Software Engineer',
          company: 'Techno Jaws',
          location: 'Madurai',
          duration: '02/2022 - 06/2023',
          responsibilities: [
            'Conducted thorough testing and debugging of applications to identify and resolve issues prior to deployment.',
            'Documented application processes and technical specifications to facilitate knowledge sharing among team members.',
            'Worked closely with other team members to identify and remove software bugs.',
          ],
        ),
      ];
}
