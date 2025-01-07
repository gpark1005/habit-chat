// lib/forgot_password/view/forgot_password_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agent_app/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:agent_app/forgot_password/view/forgot_password_form.dart';
import 'package:authentication_repository/authentication_repository.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (context) => const ForgotPasswordPage());
  }

  static Page<void> page() => const MaterialPage<void>(child: ForgotPasswordPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => ForgotPasswordCubit(context.read<AuthenticationRepository>()),
          child: const ForgotPasswordForm(),
        ),
      ),
    );
  }
}