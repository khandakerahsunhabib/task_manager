import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class ProgressTaskScreen extends StatelessWidget {
  const ProgressTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return const TaskCard();
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 8,
        );
      },
      itemCount: 10,
    );
  }
}
