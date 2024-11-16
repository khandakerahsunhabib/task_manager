import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager/ui/controllers/cancelled_task_controller.dart';
import 'package:task_manager/ui/controllers/completed_task_controller.dart';
import 'package:task_manager/ui/controllers/new_task_list_controller.dart';
import 'package:task_manager/ui/controllers/password_reset_controller.dart';
import 'package:task_manager/ui/controllers/profile_controller.dart';
import 'package:task_manager/ui/controllers/progress_task_controller.dart';
import 'package:task_manager/ui/controllers/sign_in_controller.dart';
import 'package:task_manager/ui/controllers/sign_up_controller.dart';
import 'package:task_manager/ui/controllers/task_card_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(TaskCardController());
    Get.put(NewTaskListController());
    Get.put(AddNewTaskController());
    Get.put(CompletedTaskController());
    Get.put(CancelledTaskController());
    Get.put(ProgressTaskController());
    Get.put(PasswordResetController());
    Get.put(ProfileController());
  }
}
