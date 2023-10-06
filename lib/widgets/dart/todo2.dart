import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Todo_tiles2 extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  Todo_tiles2({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0,25.0,25.0,0.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.celebration,
              backgroundColor: Colors.red.shade900,
              borderRadius: BorderRadius.circular(5.0),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.deepPurple.shade200,
              borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: <Widget>[
              //task check
              Checkbox(value: taskCompleted, onChanged: onChanged,
                activeColor: Colors.black,
              ),
              //task name
              Text(
                taskName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    decoration: taskCompleted
                        ?TextDecoration.lineThrough
                        :TextDecoration.none

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


