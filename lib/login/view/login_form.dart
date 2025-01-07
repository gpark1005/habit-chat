import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:agent_app/sign_up/view/sign_up_page.dart';
import 'package:agent_app/login/cubit/login_cubit.dart';

import '../../forgot_password/view/forgot_password_page.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});
  final double _logoSize = 75.0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
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
              const Gap(8),
              _PasswordInput(),
              const Gap(8),
              _LoginButton(),
              const Gap(12),
              _GoogleLoginButton(),
              const Gap(4),
              _SignUpButton(),
              const Gap(4),
              _ForgotPasswordButton(),
            ],
          ),
        ),
      ),
    );
  }
}

// EMAIL INPUT FIELD
class _EmailInput extends StatelessWidget {
  final double widthFactor;

  const _EmailInput({this.widthFactor = 0.85});

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginCubit cubit) => cubit.state.email.displayError,
    );

    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: TextField(
        key: const Key('loginForm_emailInput_textField'),
        onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
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

// PASSWORD INPUT FIELD
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
      (LoginCubit cubit) => cubit.state.password.displayError,
    );

    return FractionallySizedBox(
      widthFactor: widget.widthFactor,
      child: TextField(
        key: const Key('loginForm_passwordInput_textField'),
        onChanged: (password) =>
            context.read<LoginCubit>().passwordChanged(password),
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


// LOGIN BUTTON
class _LoginButton extends StatelessWidget {
  final double widthFactor;

  const _LoginButton({this.widthFactor = 0.85});

  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (LoginCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (LoginCubit cubit) => cubit.state.isValid,
    );

    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: ElevatedButton(
        key: const Key('loginForm_continue_raisedButton'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        onPressed: isValid
            ? () => context.read<LoginCubit>().logInWithCredentials()
            : null,
        child: Text('LOGIN',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: const Text(
        'SIGN IN WITH GOOGLE',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: theme.colorScheme.secondary,
      ),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    );
  }
}

// SIGNUP TEXT BUTTON
class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      child: Text(
        'Don\'t have an account?',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_forgotPassword_flatButton'),
      onPressed: () => Navigator.of(context).push<void>(ForgotPasswordPage.route()),
      child: Text(
        'Forgot Password?',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}