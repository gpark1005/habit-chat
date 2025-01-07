import 'package:flutter/widgets.dart';
import 'package:agent_app/app/bloc/app_bloc.dart';
import 'package:agent_app/home/view/home_page.dart';
import 'package:agent_app/login/view/login_page.dart';

import '../../email_verification/view/email_verification_page.dart';


List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    case AppStatus.unverified:
      return [EmailVerificationPage.page()];
  }
}
