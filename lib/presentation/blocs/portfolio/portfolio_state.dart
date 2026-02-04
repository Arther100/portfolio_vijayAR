part of 'portfolio_bloc.dart';

abstract class PortfolioState extends Equatable {
  const PortfolioState();

  @override
  List<Object?> get props => [];
}

class PortfolioInitial extends PortfolioState {
  const PortfolioInitial();
}

class PortfolioLoading extends PortfolioState {
  const PortfolioLoading();
}

class PortfolioLoaded extends PortfolioState {
  final List<Skill> skills;
  final List<Experience> experiences;
  final List<Project> projects;
  final Education education;
  final List<Accomplishment> accomplishments;

  const PortfolioLoaded({
    required this.skills,
    required this.experiences,
    required this.projects,
    required this.education,
    required this.accomplishments,
  });

  @override
  List<Object?> get props => [skills, experiences, projects, education, accomplishments];
}

class PortfolioError extends PortfolioState {
  final String message;

  const PortfolioError(this.message);

  @override
  List<Object?> get props => [message];
}
