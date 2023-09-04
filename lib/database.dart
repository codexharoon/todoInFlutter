import 'package:hive_flutter/hive_flutter.dart';

class TodoListDatabase{
    // list of todo tasks
    List todoList = [];

    // reference the hive box
    final _myBox = Hive.box('myBox');

    // load initial data whenever app first time run
    void loadInitialData(){
        todoList = [
          ['Visit codexharoon.com',false],
          ['Do Code',true],
          ['Do Exercise',false],
        ];
    }

    // load data from dataabse
    void loadData(){
      todoList = _myBox.get('todolist');
    }


    //update the database
    void updateDatabase(){
      _myBox.put('todolist', todoList);
    }

}