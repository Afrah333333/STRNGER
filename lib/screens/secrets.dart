import 'package:flutter/material.dart';
import 'package:quotesapp/services/database.dart';
import 'package:quotesapp/widgets/dart/dialog_box.dart';
import 'package:quotesapp/widgets/dart/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';


import '../widgets/dart/burn_widget.dart';
class SecretPage extends StatefulWidget {
  const SecretPage({Key? key}) : super(key: key);

  @override
  State<SecretPage> createState() => _SecretPageState();
}

class _SecretPageState extends State<SecretPage> {
  //reference hive box
  final _mybox = Hive.box('mybox');

  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // TODO: implement initState

    //if this is the first time ever opening the app, then create default data
    if(_mybox.get('TODOLIST')==null){
      db.createInitialData();
    }else{
      //if open te app after once
      db.loadData();
    }
    super.initState();
  }
  //text controller
  final _controller = TextEditingController();
  //list todo

  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.todoList[index][1]= !db.todoList[index][1];
    });
    db.updateDataBase();
  }
  //delete task
  void deleteTask(BuildContext context ,int index) async {
    // Get the task name to display on the BurningEffect screen
    String taskName = db.todoList[index][0];

    // Navigate to the BurningEffect screen
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BurningEffect(text: taskName),
      ),
    );

    // After the animation is done, remove the task
    setState(() {
      db.todoList.removeAt(index);
    });

    // Update the database
    db.updateDataBase();
  }

  // save task
  void saveNewTask(){
    setState(() {
      db.todoList.add([_controller.text, false]);
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
        title:const Text('Secrets',
          style: TextStyle(
              color: Colors.white,
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
          itemCount: db.todoList.length,
          itemBuilder: (context, index){
            return Todo_tiles(
              taskName: db.todoList[index][0],
              taskCompleted: db.todoList[index][1],
              onChanged: (value)=> checkBoxChanged(value,index),
              deleteFunction: (context)=>deleteTask(context,index),
            );
          }
      ),

    );
  }
}
