part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  final String currentSection;
  final bool isScrolling;

  const NavigationState({
    this.currentSection = 'hero',
    this.isScrolling = false,
  });

  NavigationState copyWith({
    String? currentSection,
    bool? isScrolling,
  }) {
    return NavigationState(
      currentSection: currentSection ?? this.currentSection,
      isScrolling: isScrolling ?? this.isScrolling,
    );
  }

  @override
  List<Object?> get props => [currentSection, isScrolling];
}
