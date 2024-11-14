import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class AddNewTaskController extends GetxController {
  bool _inProgress = false;
  bool _shouldRefreshPreviousPage = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  bool get shouldRefreshPreviousPage => _shouldRefreshPreviousPage;

  set shouldRefreshPreviousPage(bool value) {
    _shouldRefreshPreviousPage = value;
  }

  String? get errorMessage => _errorMessage;

  Future<bool> addNewTask(
      String title, String description, String status) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      'title': title,
      'description': description,
      'status': status,
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.addNewTask, body: requestBody);
    if (response.isSuccess) {
      isSuccess = true;
      _inProgress = false;
      update();
    } else {
      _errorMessage = response.errorMessage;
    }
    return isSuccess;
  }
}
