part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object?> get props => [];
}

/// Navigate to a specific section
class NavigateToSection extends NavigationEvent {
  final String sectionId;

  const NavigateToSection(this.sectionId);

  @override
  List<Object?> get props => [sectionId];
}

/// Update current section based on scroll position
class UpdateCurrentSection extends NavigationEvent {
  final String sectionId;

  const UpdateCurrentSection(this.sectionId);

  @override
  List<Object?> get props => [sectionId];
}
