import 'package:flutter/material.dart';

import 'package:task_manager/auth/sapCopinAccount.dart';
import 'package:task_manager/data/copinTaskController.dart';
import 'package:task_manager/widgets/taskTile.dart';
import 'package:task_manager/models/taskList.dart';
import 'package:task_manager/util/utils.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  bool _hasLoaded = false;
  TaskList _taskList = null;
  List<TaskTile> _taskTiles = [];

  @override
  void initState() {
    super.initState();

    // Initialize and login to COPIN
    final future = SAPCopinAccount().init(this.context);

    // Read tasks from COPIN, once Copin login was successfully executed
    future.then((_) {
      CopinTaskController taskCtrl = new CopinTaskController();

      // read COPIN tasks
      Future<TaskList> f_taskList = taskCtrl.getTaskList(SAPCopinAccount().getToken());

      // once the tasks are read process them.
      f_taskList.then((taskList) {
        _taskList = taskList;
        Utils.logC("Task Count: " + _taskList.count.toString());
        _taskTiles = TaskTileList.getTaskListTiles(_taskList);
      },
          onError: (e) => Utils.logEx(e, "CopinTaskController.getTask() failed "));
    },
    onError: (e) => Utils.logEx(e, "SAPCopinAccount().init() failed "));
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Utils.logC("Widget build ...");
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("Task Manager"),
      ),
      body: new Center(
          child: ListView(
            children: _taskTiles,
          ),

      ),
      /// floatingActionButton: new FloatingActionButton(
      ///   //onPressed: _incrementCounter,
      ///   tooltip: 'Increment',
      ///   child: new Icon(Icons.add),
      /// ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

