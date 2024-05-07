import 'package:flutter/material.dart';
import 'package:max_4_u/app/screens/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 41),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Set up your profile',
                style: AppTextStyles.font20,
              ),
              verticalSpace(12),
              Text(
                'Input your details to complete your registration',
                style: AppTextStyles.font14
                    .copyWith(color: const Color(0xff475569)),
              ),
              verticalSpace(24),
              TextInputField(
                controller: _firstNameController,
                labelText: 'First name',
              ),
              verticalSpace(24),
              TextInputField(
                controller: _lastNameController,
                labelText: 'Last name',
              ),
              verticalSpace(24),
              TextInputField(
                controller: _emailController,
                labelText: 'Email',
              ),
              verticalSpace(24),
              TextInputField(
                controller: _passwordController,
                labelText: 'Password',
                suffixIcon: Icons.visibility_outlined,
              ),
              verticalSpace(24),
              TextInputField(
                controller: _confirmPasswordController,
                labelText: 'Confirm password',
                suffixIcon: Icons.visibility_outlined,
              ),
              verticalSpace(28),
              RichText(
                text: TextSpan(
                    text: 'By signing up you agree with our ',
                    style: AppTextStyles.font14
                        .copyWith(color: AppColors.blackColor),
                    children: [
                      TextSpan(
                        text: 'Terms of Service ',
                        style: AppTextStyles.font14.copyWith(
                            color: AppColors.secondaryColor,
                            decoration: TextDecoration.underline),
                      ),
                      TextSpan(
                        text: '& ',
                        style: AppTextStyles.font14
                            .copyWith(color: AppColors.blackColor),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: AppTextStyles.font14.copyWith(
                            color: AppColors.secondaryColor,
                            decoration: TextDecoration.underline),
                      ),
                    ]),
              ),
              verticalSpace(32),
               ButtonWidget(
                onTap: () => nextScreen(context, const DashBoardScreen()),
                text: 'Sign up',
              ),
            ],
          ),
        ),
      )),
    );
  }
}
