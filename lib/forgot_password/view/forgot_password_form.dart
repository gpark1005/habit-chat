// lib/forgot_password/view/forgot_password_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:agent_app/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:gap/gap.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Password Reset Failure')),
            );
        } else if (state.status.isSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Password Reset Email Sent')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _EmailInput(),
              const Gap(8),
              _SendButton(),
              const Gap(48),
              _LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
          (ForgotPasswordCubit cubit) => cubit.state.email.displayError,
    );

    return FractionallySizedBox(
      widthFactor: 0.85,
      child: TextField(
        key: const Key('forgotPasswordForm_emailInput_textField'),
        onChanged: (email) => context.read<ForgotPasswordCubit>().emailChanged(email),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          helperText: '',
          errorText: displayError != null ? 'invalid email' : null,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
          (ForgotPasswordCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
          (ForgotPasswordCubit cubit) => cubit.state.isValid,
    );

    return FractionallySizedBox(
      widthFactor: 0.85,
      child: ElevatedButton(
        key: const Key('forgotPasswordForm_send_raisedButton'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        onPressed: isValid
            ? () => context.read<ForgotPasswordCubit>().sendPasswordResetEmail()
            : null,
        child: const Text('SEND PASSWORD RESET EMAIL', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => Navigator.of(context).pop(),
      child: Text(
        'Just kidding, I remember it',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}