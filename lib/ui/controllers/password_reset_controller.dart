import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class PasswordResetController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  String? _successMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  String? get successMessage => _successMessage;

  Future<bool> getOtpByEmail(String email) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.verifyByEmail(email));
    if (response.isSuccess) {
      _successMessage = response.responseData['data'];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> verifyByOtp(String email, int otp) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.verifyByOtp(email, otp));
    if (response.isSuccess) {
      _successMessage = response.responseData['data'];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> setPassword(String email, int otp, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final Map<String, String> requestBody = {
      "email": email,
      "OTP": otp.toString(),
      "password": password,
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.resetPassword,
      body: requestBody,
    );
    if (response.isSuccess) {
      _successMessage = response.responseData['data'];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
