import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

/// BLoC for handling navigation between sections
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState()) {
    on<NavigateToSection>(_onNavigateToSection);
    on<UpdateCurrentSection>(_onUpdateCurrentSection);
  }

  void _onNavigateToSection(
    NavigateToSection event,
    Emitter<NavigationState> emit,
  ) {
    emit(state.copyWith(
      currentSection: event.sectionId,
      isScrolling: true,
    ));
  }

  void _onUpdateCurrentSection(
    UpdateCurrentSection event,
    Emitter<NavigationState> emit,
  ) {
    if (!state.isScrolling) {
      emit(state.copyWith(currentSection: event.sectionId));
    } else {
      emit(state.copyWith(isScrolling: false));
    }
  }
}
