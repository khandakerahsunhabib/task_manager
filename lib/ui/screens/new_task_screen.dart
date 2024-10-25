import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/task_card.dart';
import 'package:task_manager/ui/widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        children: [
          _buildSummarySection(themeData),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const TaskCard();
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 8,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(),
        onPressed: _onTapAddFAB,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Padding _buildSummarySection(TextTheme themeData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TaskSummaryCard(
              themeData: themeData,
              title: 'New',
              count: 09,
            ),
            TaskSummaryCard(
              themeData: themeData,
              title: 'Completed',
              count: 09,
            ),
            TaskSummaryCard(
              themeData: themeData,
              title: 'Cancelled',
              count: 09,
            ),
            TaskSummaryCard(
              themeData: themeData,
              title: 'Progress',
              count: 09,
            ),
          ],
        ),
      ),
    );
  }

  void _onTapAddFAB() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
  }
}
