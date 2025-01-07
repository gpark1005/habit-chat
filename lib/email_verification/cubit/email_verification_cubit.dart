import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/bloc/app_bloc.dart';

part 'email_verification_state.dart';


class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  final AuthenticationRepository _authenticationRepository;
  final AppBloc _appBloc;

  Timer? _verificationTimer;

  EmailVerificationCubit(this._authenticationRepository, this._appBloc)
      : super(const EmailVerificationState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    bool isVerified = await _authenticationRepository.checkEmailVerified();
    if (!isVerified) {
      sendVerificationEmail();
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      await _authenticationRepository.sendEmailVerification();
      emit(state.copyWith(status: EmailVerificationStatus.emailSent));
      _startVerificationTimer();
    } catch (e) {
      emit(state.copyWith(status: EmailVerificationStatus.failure));
    }
  }

  Future<void> checkEmailVerificationStatus() async {
    try {
      bool isVerified = await _authenticationRepository.checkEmailVerified();
      if (isVerified) {
        _verificationTimer?.cancel();
        _appBloc.add(const AppEmailVerified());
        emit(state.copyWith(status: EmailVerificationStatus.verified));
      } else {
        emit(state.copyWith(status: EmailVerificationStatus.emailSent));
      }
    } catch (e) {
      emit(state.copyWith(status: EmailVerificationStatus.failure));
    }
  }

  void _startVerificationTimer() {
    _verificationTimer?.cancel();
    _verificationTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerificationStatus();
    });
  }

  @override
  Future<void> close() {
    _verificationTimer?.cancel();
    return super.close();
  }
}
// class EmailVerificationCubit extends Cubit<EmailVerificationState> {
//   EmailVerificationCubit(this._authenticationRepository)
//       : super(const EmailVerificationState());
//
//   final AuthenticationRepository _authenticationRepository;
//   Timer? _verificationTimer;
//
//   Future<void> sendEmailVerification() async {
//     try {
//       await _authenticationRepository.sendEmailVerification();
//       emit(state.copyWith(status: EmailVerificationStatus.emailSent));
//     } catch (_) {
//       emit(state.copyWith(status: EmailVerificationStatus.failure));
//     }
//   }
//
//   Future<void> checkEmailVerified() async {
//     try {
//       final user = await _authenticationRepository.refreshUser();
//       if (user.emailVerified) {
//         emit(state.copyWith(status: EmailVerificationStatus.verified));
//       } else {
//         emit(state.copyWith(status: EmailVerificationStatus.unverified));
//       }
//     } catch (_) {
//       emit(state.copyWith(status: EmailVerificationStatus.failure));
//     }
//   }
//
//
//   void _startVerificationTimer() {
//     _verificationTimer?.cancel();
//     _verificationTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       add(CheckEmailVerificationStatus());
//     });
//   }
//
//   @override
//   Future<void> close() {
//     _verificationTimer?.cancel();
//     return super.close();
//   }
// }
