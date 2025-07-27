import 'package:flutter/material.dart';
import 'package:iti_project/utils/app_colors.dart';
import 'package:iti_project/features/auth/login_screen_conent.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteApp,

      body: Align(
        alignment: Alignment.bottomCenter,

        child: Container(
          height: 400,
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: LoginScreenContent(),
        ),
      ),
    );
  }
}
