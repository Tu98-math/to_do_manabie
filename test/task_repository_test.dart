import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_manabie/model/task_model.dart';
import 'package:to_do_manabie/repository/task_repository.dart';

main() async {
  TaskRepository taskRes = TaskRepository();

  List<TaskModel>? tasks = [];

  TaskModel testTask = TaskModel(
    des: "Hihi",
    completed: false,
    time: DateTime.now().millisecondsSinceEpoch,
  );

  test("insert Task Test", () async {
    await taskRes.initDatabase();
    await taskRes.taskDao.deleteTable();

    // stream getAllTask to tasks
    taskRes.getAllTask().listen((event) {
      tasks = event;
    });

    // await stream builder listen test
    await Future.delayed(const Duration(milliseconds: 100));

    // check
    expect((tasks ?? []).length, 0);
  });

  test("insert Task Test", () async {
    // save id Task Model
    var result = await taskRes.taskDao.insertTask(testTask);

    // add id to Task Model
    testTask = TaskModel(
      id: result,
      des: testTask.des,
      completed: testTask.completed,
      time: testTask.time,
    );

    // await stream builder listen test
    await Future.delayed(const Duration(milliseconds: 100));

    // check
    expect((tasks ?? []).length, 1);
  });

  test("remove Task Test", () async {
    // delete task
    await taskRes.taskDao.deleteTask(testTask);

    // await stream builder listen test
    await Future.delayed(const Duration(milliseconds: 100));

    // check
    expect((tasks ?? []).length, 0);
  });

  test("get All Task Test", () async {
    // clear id Task
    testTask = TaskModel(
      des: "Hihi",
      completed: false,
      time: DateTime.now().millisecondsSinceEpoch,
    );

    // add 10 task model
    for (int i = 0; i < 10; i++) {
      await taskRes.taskDao.insertTask(testTask);
    }

    // await stream builder listen
    await Future.delayed(const Duration(milliseconds: 100));

    // check
    expect((tasks ?? []).length, 10);
  });

  test("get All Task by Completed Test", () async {
    // add 10 task model
    for (int i = 0; i < 5; i++) {
      testTask = TaskModel(
        des: "Hihi",
        completed: true,
        time: DateTime.now().millisecondsSinceEpoch,
      );
      await taskRes.taskDao.insertTask(testTask);
    }

    List<TaskModel>? tasksComplete = [];
    taskRes.getAllCompletedTask(true).listen((event) {
      tasksComplete = event;
    });

    // await stream builder listen
    await Future.delayed(const Duration(milliseconds: 100));

    // check
    expect(5, (tasksComplete ?? []).length);
  });
}
