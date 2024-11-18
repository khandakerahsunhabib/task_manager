import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/controllers/sign_in_controller.dart';
import 'package:task_manager/ui/screens/forgot_password_email_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_navbar_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/widgets/app_button.dart';
import 'package:task_manager/ui/widgets/app_gradient_container.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';

void main() {
  runApp(MaterialApp(home: SignInScreen()));
}

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final SignInController signInController = Get.find<SignInController>();
  static const String name = '/sign_in';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          AppGradientContainer(),
          // Main Content
          Column(
            children: [
              const SizedBox(height: 80),
              // Icon and Titles
              _buildLoginScreenHeader(),
              const SizedBox(height: 20),
              _buildLoginForm(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 60),
                  // Email TextField
                  TextFormField(
                    controller: _emailTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password TextField
                  TextFormField(
                    controller: _passwordTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter password';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.visibility_off),
                        onPressed: _onTapPasswordFieldSuffixIcon,
                      ),
                    ),
                  ),
                  TextButton(
                      style: ButtonStyle(
                        alignment: Alignment.topRight,
                        visualDensity: VisualDensity.comfortable,
                      ),
                      onPressed: _onTapForgotPasswordTextButton,
                      child: Text('Forgot password?')),
                  const SizedBox(height: 20),
                  // Buttons
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GetBuilder<SignInController>(builder: (controller) {
                          return Visibility(
                            visible: !controller.inProgress,
                            replacement: CenteredCircularProgressIndicator(),
                            child: AppButton(
                              buttonText: 'Log in',
                              onTap: _onTapLoginButton,
                            ),
                          );
                        }),
                        SizedBox(height: 15),
                        AppButton(
                          buttonText: 'Sign Up',
                          onTap: _onTapSignupButton,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginScreenHeader() {
    return Column(
      children: const [
        CircleAvatar(
          backgroundColor: Colors.white12,
          radius: 60,
          child: Icon(
            Icons.description, // Example icon
            size: 40,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Log in",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Log in with email and password",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  void _onTapPasswordFieldSuffixIcon() {
    //TODO: implement password field suffix icon
  }

  void _onTapForgotPasswordTextButton() {
    Get.toNamed(ForgotPasswordEmailScreen.name);
  }

  Future<void> _signIn() async {
    final bool result = await signInController.signIn(
      _emailTEController.text.trim(),
      _passwordTEController.text,
    );
    if (result) {
      Get.offAllNamed(MainBottomNavbarScreen.name);
    } else {
      // showSnackBarMessage(context, signInController.errorMessage!, true);
    }
  }

  void _onTapLoginButton() {
    if (_formkey.currentState!.validate()) {
      _signIn();
    }
  }

  void _onTapSignupButton() {
    Get.toNamed(SignUpScreen.name);
  }
}
