// lib/forgot_password/cubit/forgot_password_state.dart
part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.email = const Email.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
  });

  final Email email;
  final FormzSubmissionStatus status;
  final bool isValid;

  @override
  List<Object> get props => [email, status, isValid];

  ForgotPasswordState copyWith({
    Email? email,
    FormzSubmissionStatus? status,
    bool? isValid,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }
}