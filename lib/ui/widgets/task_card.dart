import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/ui/controllers/task_card_controller.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.onRefreshList,
  });

  final TaskModel taskModel;
  final VoidCallback onRefreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String _selectedStatus = '';
  final TaskCardController _taskCardController = Get.find<TaskCardController>();

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title ?? '',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              widget.taskModel.description ?? '',
            ),
            Text(
              widget.taskModel.createdDate ?? '',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTaskStatusChip(),
                const SizedBox(
                  height: 8,
                ),
                Wrap(
                  children: [
                    GetBuilder<TaskCardController>(builder: (controller) {
                      return Visibility(
                        visible: !controller.changeStatusInProgress,
                        replacement: CenteredCircularProgressIndicator(),
                        child: IconButton(
                          onPressed: _onTapEditButton,
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                      );
                    }),
                    GetBuilder<TaskCardController>(builder: (controller) {
                      return Visibility(
                        visible: !controller.inProgress,
                        replacement: CenteredCircularProgressIndicator(),
                        child: IconButton(
                          onPressed: () {
                            _onTapDeleteButton();
                          },
                          icon: const Icon(
                            Icons.delete,
                          ),
                        ),
                      );
                    }),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onTapEditButton() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['New', 'Completed', 'Cancelled', 'Progress'].map((e) {
              return ListTile(
                onTap: () {
                  _changeStatus(e);
                  Navigator.pop(context);
                },
                title: Text(e),
                selected: _selectedStatus == e,
                trailing: _selectedStatus == e ? Icon(Icons.check) : null,
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onTapDeleteButton() async {
    final result = await _taskCardController.deleteTask(widget.taskModel.sId!);
    if (result) {
      widget.onRefreshList();
    } else {
      showSnackBarMessage(context, _taskCardController.errorMessage!, true);
    }
  }

  Widget _buildTaskStatusChip() {
    return Chip(
      label: Text(
        _selectedStatus,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: AppColors.themeColor,
        ),
      ),
    );
  }

  Future<void> _changeStatus(String newStatus) async {
    final result = await _taskCardController.changeStatus(
        widget.taskModel.sId!, newStatus);
    if (result) {
      widget.onRefreshList();
    } else {
      showSnackBarMessage(
        context,
        _taskCardController.errorMessage!,
        true,
      );
    }
  }
}
