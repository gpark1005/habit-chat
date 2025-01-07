part of 'email_verification_cubit.dart';

enum EmailVerificationStatus { initial, emailSent, verified, unverified, failure }

class EmailVerificationState extends Equatable {
  const EmailVerificationState({
    this.status = EmailVerificationStatus.initial,
  });

  final EmailVerificationStatus status;

  EmailVerificationState copyWith({
    EmailVerificationStatus? status,
  }) {
    return EmailVerificationState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}