import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{

  List todoList = [];
  //reference our box
  final _mybox = Hive.box('mybox');
  // run this method wenever this is the first time user opens the app
  void createInitialData(){
    todoList=[
      ['I wish i....',false],
      ['Forget....',false]
    ];
  }
  //load the data from database
void loadData(){
todoList = _mybox.get('TODOLIST');
}
//update the database
void updateDataBase(){
_mybox.put('TODOLIST', todoList);
}
}
class ToDoDataBase2{

  List todoList2 = [];
  //reference our box
  final _mybox2 = Hive.box('mybox2');
  // run this method whenever this is the first time user opens the app
  void createInitialData(){
    todoList2=[
      ['Go with friends',false],
      ['Travel',false]
    ];
  }
  //load the data from database
  void loadData(){
    todoList2 = _mybox2.get('TODOLIST2');
  }
//update the database
  void updateDataBase(){
    _mybox2.put('TODOLIST2', todoList2);
  }
}
class ToDoDataBase3{
  List todoList3 = [];
  //reference our box
  final _mybox3 = Hive.box('mybox3');
  // run this method whenever this is the first time user opens the app
  void createInitialData2(){
    todoList3=[
      ['Finish assignment',false],
      ['Finish resume',false]
    ];
  }
  //load the data from database
  void loadData2(){
    todoList3 = _mybox3.get('TODOLIST3');
  }
//update the database
  void updateDataBase2(){
    _mybox3.put('TODOLIST3', todoList3);
  }
}
