import 'package:flutter/material.dart';
import 'package:quotesapp/services/database.dart';
import 'package:quotesapp/widgets/dart/dialog_box.dart';
import 'package:quotesapp/widgets/dart/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../services/database.dart';
import '../widgets/dart/achieve_widget.dart';
import '../widgets/dart/dialog_box.dart';
import '../widgets/dart/todo2.dart';
class Achievementpage extends StatefulWidget {
  const Achievementpage({Key? key}) : super(key: key);

  @override
  State<Achievementpage> createState() => _AchievementpageState();
}

class _AchievementpageState extends State<Achievementpage> {
  //reference hive box
  final _mybox3 = Hive.box('mybox3');
  ToDoDataBase3 db3 = ToDoDataBase3();
  @override
  void initState() {
    // TODO: implement initState

    //if this is the first time ever opening the app, then create default data
    if(_mybox3.get('TODOLIST3')==null){
      db3.createInitialData2();
    }else{
      //if open te app after once
      db3.loadData2();
    }
    super.initState();
  }
  //text controller
  final _controller = TextEditingController();
  //list todo

  void checkBoxChanged(bool? value, int index){
    setState(() {
      db3.todoList3[index][1]= !db3.todoList3[index][1];
    });
    db3.updateDataBase2();
  }
  //delete task
  void deleteTask(int index) async{
    // Navigate to the BurningEffect screen
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WinEffect(),
      ),
    );
    setState(() {
      db3.todoList3.removeAt(index);
    });
    db3.updateDataBase2();
  }
  // save task
  void saveNewTask(){
    setState(() {
      db3.todoList3.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }
  //create new task
  void createNewTask(){
    showDialog(
      context: context,
      builder: (context){
        return DialogBox(
          controller:_controller ,
          onSave: saveNewTask,
          onCancel: ()=>Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade400,
        title:const Text('Achievements',
          style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0
          ),
        ),
        centerTitle: true,
        elevation: 0.0,

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.deepPurple.shade400,
        child: const Icon(
            Icons.add
        ),
      ),
      body: ListView.builder(
          itemCount: db3.todoList3.length,
          itemBuilder: (context, index){
            return Todo_tiles2(
              taskName: db3.todoList3[index][0],
              taskCompleted: db3.todoList3[index][1],
              onChanged: (value)=> checkBoxChanged(value,index),
              deleteFunction: (context)=>deleteTask(index),
            );
          }
      ),

    );
  }
}
