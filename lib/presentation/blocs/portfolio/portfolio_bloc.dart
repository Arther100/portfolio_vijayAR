import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/models.dart';

part 'portfolio_event.dart';
part 'portfolio_state.dart';

/// BLoC for managing portfolio data
class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc() : super(const PortfolioInitial()) {
    on<LoadPortfolio>(_onLoadPortfolio);
  }

  Future<void> _onLoadPortfolio(
    LoadPortfolio event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(const PortfolioLoading());

    // Simulate loading delay for smooth animation
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      emit(PortfolioLoaded(
        skills: Skill.allSkills,
        experiences: Experience.allExperiences,
        projects: Project.allProjects,
        education: Education.education,
        accomplishments: Accomplishment.allAccomplishments,
      ));
    } catch (e) {
      emit(PortfolioError(e.toString()));
    }
  }
}
