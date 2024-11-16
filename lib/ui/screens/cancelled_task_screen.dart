import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/cancelled_task_controller.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  static const String name = '/cancelled_task_screen';

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final CancelledTaskController _cancelledTaskController =
      Get.find<CancelledTaskController>();

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CancelledTaskController>(builder: (controller) {
      return Visibility(
        visible: !_cancelledTaskController.inProgress,
        replacement: CenteredCircularProgressIndicator(),
        child: RefreshIndicator(
          onRefresh: () async {
            _getCancelledTaskList();
          },
          child: ListView.separated(
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: _cancelledTaskController.cancelledTaskList[index],
                onRefreshList: _getCancelledTaskList,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 8,
              );
            },
            itemCount: controller.cancelledTaskList.length,
          ),
        ),
      );
    });
  }

  Future<void> _getCancelledTaskList() async {
    final bool result = await _cancelledTaskController.getCancelledTaskList();
    if (result == false) {
      showSnackBarMessage(
          context, _cancelledTaskController.errorMessage!, true);
    }
  }
}
