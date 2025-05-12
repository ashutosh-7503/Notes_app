import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoItem extends StatelessWidget {
  final bool isChecked;
  final String todoText;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? onPressed;
  const TodoItem({
    super.key,
    required this.isChecked,
    required this.todoText,
    required this.onChanged,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: onPressed,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.deepPurple[400],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              value: isChecked,
              onChanged: onChanged,
              activeColor: Colors.deepPurple[300],
              checkColor: Colors.white,
              // activeColor: Colors.white,
            ),
            Text(
              todoText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                decoration:
                    isChecked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                decorationColor: Colors.white,
                decorationThickness: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
