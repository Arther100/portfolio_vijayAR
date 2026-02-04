import 'package:equatable/equatable.dart';

/// Education model
class Education extends Equatable {
  final String degree;
  final String field;
  final String institution;
  final String location;
  final String year;

  const Education({
    required this.degree,
    required this.field,
    required this.institution,
    required this.location,
    required this.year,
  });

  @override
  List<Object?> get props => [degree, field, institution, location, year];

  static Education get education => const Education(
        degree: 'Bachelor of Arts',
        field: 'Commerce',
        institution: 'The American College',
        location: 'Madurai, TN',
        year: '2020',
      );
}
