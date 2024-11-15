import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/progress_task_controller.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  static const String name = '/progress_task_screen';

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final ProgressTaskController _progressTaskController =
      Get.find<ProgressTaskController>();

  @override
  void initState() {
    super.initState();
    _getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressTaskController>(builder: (controller) {
      return Visibility(
        visible: !controller.inProgress,
        replacement: CenteredCircularProgressIndicator(),
        child: RefreshIndicator(
          onRefresh: () async {
            _getProgressTaskList();
          },
          child: ListView.separated(
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: controller.progressTaskList[index],
                onRefreshList: _getProgressTaskList,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 8,
              );
            },
            itemCount: controller.progressTaskList.length,
          ),
        ),
      );
    });
  }

  Future<void> _getProgressTaskList() async {
    final result = await _progressTaskController.getProgressTaskList();
    if (!result) {
      showSnackBarMessage(context, _progressTaskController.errorMessage!, true);
    }
  }
}
