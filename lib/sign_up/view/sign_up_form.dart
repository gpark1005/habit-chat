import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:agent_app/sign_up/cubit/sign_up_cubit.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});
  final double _logoSize = 75.0;


  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                   SvgPicture.asset(
                'assets/savrr_full_logo_2colors.svg',
                height: _logoSize,
                width: _logoSize,
                semanticsLabel: 'Savrr Logo',
                colorFilter: ColorFilter.mode(
                  const Color(0xFF7E49FF),
                  BlendMode.srcIn,
                ),
              ),
              const Gap(72),
              _EmailInput(),
              Gap(8),
              _PasswordInput(),
              Gap(8),
              _ConfirmPasswordInput(),
              Gap(8),
              _SignUpButton(),
              Gap(8),
              _LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  final double widthFactor;

  const _EmailInput({this.widthFactor = 0.85});

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpCubit cubit) => cubit.state.email.displayError,
    );

    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: TextField(
        key: const Key('signUpForm_emailInput_textField'),
        onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
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
              color: Theme.of(context).colorScheme.primaryContainer
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

class _PasswordInput extends StatefulWidget {
  final double widthFactor;

  const _PasswordInput({this.widthFactor = 0.85});

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpCubit cubit) => cubit.state.password.displayError,
    );

    return FractionallySizedBox(
      widthFactor: widget.widthFactor,
      child: TextField(
        key: const Key('signUpForm_passwordInput_textField'),
        onChanged: (password) =>
            context.read<SignUpCubit>().passwordChanged(password),
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: 'Password',
          helperText: '',
          errorText: displayError != null ? 'invalid password' : null,
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
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
      ),
    );
  }
}

class _ConfirmPasswordInput extends StatefulWidget {
  final double widthFactor;

  const _ConfirmPasswordInput({this.widthFactor = 0.85});

  @override
  State<_ConfirmPasswordInput> createState() => _ConfirmPasswordInputState();
}

class _ConfirmPasswordInputState extends State<_ConfirmPasswordInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpCubit cubit) => cubit.state.confirmedPassword.displayError,
    );

    return FractionallySizedBox(
      widthFactor: widget.widthFactor,
      child: TextField(
        key: const Key('signUpForm_confirmedPasswordInput_textField'),
        onChanged: (confirmPassword) =>
            context.read<SignUpCubit>().confirmedPasswordChanged(confirmPassword),
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: 'Confirm Password',
          helperText: '',
          errorText: displayError != null ? 'passwords do not match' : null,
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
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
      ),
    );
  }
}


class _SignUpButton extends StatelessWidget {
  final double widthFactor;

  const _SignUpButton({this.widthFactor = 0.85});

  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (SignUpCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (SignUpCubit cubit) => cubit.state.isValid,
    );

    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: ElevatedButton(
        key: const Key('signUpForm_continue_raisedButton'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        onPressed: isValid
            ? () => context.read<SignUpCubit>().signUpFormSubmitted()
            : null,
        child: const Text('SIGN UP',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// LOGIN BUTTON
class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => Navigator.of(context).pop(),
      child: Text(
        'I already have an account',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}