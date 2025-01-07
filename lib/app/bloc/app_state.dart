part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated, unverified }

final class AppState extends Equatable {
  const AppState._({required this.status, this.user = User.empty});

  factory AppState({User user = User.empty}) {
    return AppState._(
      status: user == User.empty
          ? AppStatus.unauthenticated
          : (user.emailVerified ?? false) ? AppStatus.authenticated : AppStatus.unverified,
      user: user,
    );
  }

  final AppStatus status;
  final User user;


  AppState copyWith({
    AppStatus? status,
  }) {
    return AppState._(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status, user];
}