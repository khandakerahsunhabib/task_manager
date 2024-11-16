import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name = '/add_new_task_screen';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final AddNewTaskController _addNewTaskController =
      Get.find<AddNewTaskController>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        Get.back(result: _addNewTaskController.shouldRefreshPreviousPage);
      },
      child: Scaffold(
        appBar: const TMAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 42,
                  ),
                  Text(
                    'Add New Task',
                    style: themeData.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _titleTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                    validator: (String? value) {
                      if (value!.trim().isEmpty ?? true) {
                        return 'Enter a value';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _descriptionTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                    validator: (String? value) {
                      if (value!.trim().isEmpty ?? true) {
                        return 'Enter a value';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<AddNewTaskController>(builder: (controller) {
                    return Visibility(
                      visible: !controller.inProgress,
                      replacement: CenteredCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: _onTapSubmitButton,
                        child: const Icon(
                          Icons.arrow_circle_right_outlined,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formkey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    final bool result = await _addNewTaskController.addNewTask(
      _titleTEController.text.trim(),
      _descriptionTEController.text.trim(),
      'New',
    );
    if (result) {
      _addNewTaskController.shouldRefreshPreviousPage = true;
      showSnackBarMessage(context, 'New task added');
      _clearTextFields();
    } else {
      showSnackBarMessage(context, _addNewTaskController.errorMessage!, true);
    }
  }

  void _clearTextFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
