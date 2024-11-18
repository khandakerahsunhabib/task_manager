import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/controllers/password_reset_controller.dart';
import 'package:task_manager/ui/screens/reset_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  const ForgotPasswordOtpScreen({super.key});

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
  static const String name = '/forgot_password_otp_screen';
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  final TextEditingController _pinFieldTEController = TextEditingController();
  String email = Get.arguments.toString();
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
                const SizedBox(
                  height: 60,
                ),
                Text(
                  'PIN Verification',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'A 6 digits verification otp has been sent to your email address',
                  style: textTheme.titleSmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildVerifyPinField(),
                const SizedBox(
                  height: 24,
                ),
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

  Widget _buildVerifyPinField() {
    return Column(
      children: [
        PinCodeTextField(
          controller: _pinFieldTEController,
          length: 6,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
          ),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          appContext: context,
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
            style: TextStyle(
              color: AppColors.themeColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    _verifyByOtp(email);
  }

  Future<void> _verifyByOtp(String email) async {
    int otp = int.parse(_pinFieldTEController.text);
    final bool result = await _passwordResetController.verifyByOtp(
        email, int.parse(_pinFieldTEController.text));
    if (result) {
      Get.toNamed(ResetPasswordScreen.name,
          arguments: {"email": email, "otp": otp});
    } else {
      showSnackBarMessage(
          context, _passwordResetController.errorMessage!, true);
    }
  }

  void _onTapSignIn() {
    Get.offAllNamed(SignInScreen.name);
  }
}
