import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/password_reset_controller.dart';
import 'package:task_manager/ui/screens/forgot_password_otp_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  static const String name = '/forgot_password_email_screen';

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final PasswordResetController _passwordResetController =
      Get.find<PasswordResetController>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Text(
                  'Your Email Address',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'A 6 digits verification otp will be sent to your email address',
                  style: textTheme.titleSmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                _buildVerifyEmailForm(),
                const SizedBox(height: 48),
                Center(
                  child: _buildHaveAccountSection(),
                ),
                SizedBox(
                  height: viewInsets > 0 ? viewInsets : 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyEmailForm() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter your email';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          GetBuilder<PasswordResetController>(
            builder: (controller) {
              return Visibility(
                visible: !controller.inProgress,
                replacement: CenteredCircularProgressIndicator(),
                child: ElevatedButton(
                  onPressed: _onTapNextButton,
                  child: const Icon(
                    Icons.arrow_circle_right_outlined,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        text: "Have an account? ",
        children: [
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(
              color: AppColors.themeColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if (_formkey.currentState!.validate()) {
      _getOtpByEmail();
    }
  }

  Future<void> _getOtpByEmail() async {
    final result = await _passwordResetController
        .getOtpByEmail(_emailTEController.text.trim());
    if (result) {
      showSnackBarMessage(context, _passwordResetController.successMessage!);
      Get.toNamed(ForgotPasswordOtpScreen.name,
          arguments: _emailTEController.text.trim());
    } else {
      showSnackBarMessage(
          context, _passwordResetController.errorMessage!, true);
    }
  }

  void _onTapSignIn() {
    Get.back();
  }
}
