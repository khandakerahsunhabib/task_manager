import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class ProgressTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<TaskModel> _progressTaskList = [];

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  List get progressTaskList => _progressTaskList;

  Future<bool> getProgressTaskList() async {
    _progressTaskList.clear();
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.progressTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _progressTaskList = taskListModel.taskList ?? [];
      isSuccess = true;
      _inProgress = false;
      update();
    } else {
      _errorMessage = response.errorMessage;
    }
    return isSuccess;
  }
}
