import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class TaskCardController extends GetxController {
  bool _inProgress = false;
  bool _changeStatusInProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  bool get changeStatusInProgress => _changeStatusInProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> deleteTask(String id) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.deleteTask(id));
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> changeStatus(String id, String newStatus) async {
    bool isSuccess = false;
    _changeStatusInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.changeStatus(
        id,
        newStatus,
      ),
    );
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _changeStatusInProgress = false;
    update();
    return isSuccess;
  }
}
