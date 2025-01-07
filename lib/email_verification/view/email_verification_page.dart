import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:agent_app/email_verification/cubit/email_verification_cubit.dart';

import '../../app/bloc/app_bloc.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  static Page<void> page() =>
      const MaterialPage<void>(child: EmailVerificationPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Your Email')),
      body: BlocProvider(
        create: (_) => EmailVerificationCubit(
          context.read<AuthenticationRepository>(),
          context.read<AppBloc>(),
        ),
        child: const EmailVerificationView(),
      ),
    );
  }
}

class EmailVerificationView extends StatelessWidget {
  const EmailVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailVerificationCubit, EmailVerificationState>(
      listener: (context, state) {
        if (state.status == EmailVerificationStatus.verified) {
          Navigator.of(context).pop();
        } else if (state.status == EmailVerificationStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Failed to verify email')),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'A verification link has been sent to your email. Click the link to verify your email.',
              textAlign: TextAlign.center,
            ),
            Gap(24),
            _ResendEmailButton(),
          ],
        ),
      ),
    );
  }
}


class _ResendEmailButton extends StatelessWidget {
  final double widthFactor;

  const _ResendEmailButton({this.widthFactor = 0.85});

  @override
  Widget build(BuildContext context) {
    // final isInProgress = context.select(
    //       (LoginCubit cubit) => cubit.state.status.isInProgress,
    // );
    //
    // if (isInProgress) return const CircularProgressIndicator();
    //
    // final isValid = context.select(
    //       (LoginCubit cubit) => cubit.state.isValid,
    // );

    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: ElevatedButton(
        key: const Key('resend_email_raisedButton'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () => context
            .read<EmailVerificationCubit>()
            .sendVerificationEmail(),
        child: Text('RESEND EMAIL',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
