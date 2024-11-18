import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller_binder.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager/ui/screens/completed_task_screen.dart';
import 'package:task_manager/ui/screens/forgot_password_email_screen.dart';
import 'package:task_manager/ui/screens/forgot_password_otp_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_navbar_screen.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';
import 'package:task_manager/ui/screens/profile_screen.dart';
import 'package:task_manager/ui/screens/progress_task_screen.dart';
import 'package:task_manager/ui/screens/reset_password_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        textTheme: const TextTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinder(),
      initialRoute: SplashScreen.name,
      routes: {
        SplashScreen.name: (context) => const SplashScreen(),
        SignInScreen.name: (context) => SignInScreen(),
        MainBottomNavbarScreen.name: (context) =>
            const MainBottomNavbarScreen(),
        ProfileScreen.name: (context) => ProfileScreen(),
        SignUpScreen.name: (context) => SignUpScreen(),
        AddNewTaskScreen.name: (context) => AddNewTaskScreen(),
        NewTaskScreen.name: (context) => NewTaskScreen(),
        CompletedTaskScreen.name: (context) => CompletedTaskScreen(),
        CancelledTaskScreen.name: (context) => CancelledTaskScreen(),
        ProgressTaskScreen.name: (context) => ProgressTaskScreen(),
        ForgotPasswordEmailScreen.name: (context) =>
            ForgotPasswordEmailScreen(),
        ForgotPasswordOtpScreen.name: (context) => ForgotPasswordOtpScreen(),
        ResetPasswordScreen.name: (context) => ResetPasswordScreen(),
      },
    );
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        fixedSize: const Size.fromWidth(
          double.maxFinite,
        ),
      ),
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w300,
      ),
      border: _underLineInputBorder(),
      enabledBorder: _underLineInputBorder(),
      errorBorder: _underLineInputBorder(),
      focusedBorder: _underLineInputBorder(),
    );
  }

  UnderlineInputBorder _underLineInputBorder() {
    return UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 2));
  }
}
