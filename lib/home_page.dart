import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/database.dart';
import 'package:todo/dialog.dart';
import 'package:todo/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _todoDB = TodoListDatabase();

  // reference the hive box
  final _myBox = Hive.box('myBox');

  // text controller
  final _controller = TextEditingController();


  @override
  void initState() {

    //first time open the app
    if(_myBox.get('todolist') == null){
      _todoDB.loadInitialData();
    }
    else{
      _todoDB.loadData();
    }

    super.initState();

  }


  // check box changed
  void checkBoxChanged(bool? value,int index){
    setState(() {
      _todoDB.todoList[index][1] = ! _todoDB.todoList[index][1];
    });
    _todoDB.updateDatabase();
  }


  // create new task

  void createNewTask(){

    showDialog(
      context: context,
      builder: (_) =>  CustomDialog(
        controller: _controller,
        onCancel: () => Navigator.of(context).pop(),
        onSave: saveNewTask,
      ),
    );

  }

  // save the task

  void saveNewTask(){
    setState(() {
    _todoDB.todoList.add([_controller.text,false]);
    _controller.clear();
    _todoDB.updateDatabase();
    });

    Navigator.of(context).pop();
  }

  // delete task

  void deleteTask(int index){
    setState(() {
      _todoDB.todoList.removeAt(index);
      _todoDB.updateDatabase();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(  
        title: const Text('To Do'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: _todoDB.todoList.length,
        itemBuilder: (context,index){
          return TodoTile(
            taskName: _todoDB.todoList[index][0],
            taskCompleted: _todoDB.todoList[index][1],
            onChanged: (value) => checkBoxChanged(value,index),
            onPressed: (context) => deleteTask(index),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(  
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}