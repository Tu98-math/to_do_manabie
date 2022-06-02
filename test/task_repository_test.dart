import 'package:test/test.dart';
import 'package:to_do_manabie/model/task_model.dart';
import 'package:to_do_manabie/repository/task_repository.dart';

main() {
  TaskRepository taskRes = TaskRepository();

  TaskModel testTask = TaskModel(
    des: "Test",
    completed: false,
    time: DateTime.now().millisecondsSinceEpoch,
  );

  TaskModel insertTestTask = TaskModel(
    des: "insertTask test",
    completed: false,
    time: DateTime.now().millisecondsSinceEpoch,
  );

  test("empty return getAllTask", () async {
    await taskRes.initDatabase();
    await taskRes.taskDao.deleteTable();

    // check
    expect(taskRes.getAllTask(), emitsInOrder([[]]));
  });

  test("none-empty returns getAllTask", () async {
    // save id Task Model
    var result = await taskRes.taskDao.insertTask(testTask);

    // add id to Task Model
    testTask = TaskModel(
      id: result,
      des: testTask.des,
      completed: testTask.completed,
      time: testTask.time,
    );

    // check
    expect(
        taskRes.getAllTask(),
        emitsInOrder([
          [testTask]
        ]));
  });

  test("none insertTask Test", () async {
    // setup
    TaskModel insertTestTask = TaskModel(
      des: "insertTask test",
      completed: false,
      time: DateTime.now().millisecondsSinceEpoch,
    );

    // none run

    // check
    expect(
        taskRes.getAllTask(),
        emitsInOrder([
          [testTask]
        ]));
  });

  test("insertTask Test", () async {
    // setup

    // save id Task Model
    var result = await taskRes.taskDao.insertTask(insertTestTask);

    // add id to Task Model
    insertTestTask = TaskModel(
      id: result,
      des: insertTestTask.des,
      completed: insertTestTask.completed,
      time: insertTestTask.time,
    );

    // check
    expect(
        taskRes.getAllTask(),
        emitsInOrder([
          [testTask, insertTestTask]
        ]));
  });

  test("updateTask completed Test", () async {
    // setup completed = !completed
    testTask = TaskModel(
      id: testTask.id,
      des: testTask.des,
      completed: !testTask.completed!,
      time: DateTime.now().millisecondsSinceEpoch,
    );

    // update testTask
    await taskRes.taskDao.updateTask(testTask);

    // check
    expect(
        taskRes.getAllTask(),
        emitsInOrder([
          [testTask, insertTestTask]
        ]));
  });

  test("updateTask description Test", () async {
    // setup des += 'er'
    testTask = TaskModel(
      id: testTask.id,
      des: testTask.des! + 'er',
      completed: !testTask.completed!,
      time: DateTime.now().millisecondsSinceEpoch,
    );

    // update testTask
    await taskRes.taskDao.updateTask(testTask);

    // check
    expect(
        taskRes.getAllTask(),
        emitsInOrder([
          [testTask, insertTestTask]
        ]));
  });

  test("deleteTask-0 Test", () async {
    // remove testTask
    await taskRes.taskDao.deleteTask(testTask);

    // check
    expect(
        taskRes.getAllTask(),
        emitsInOrder([
          [insertTestTask]
        ]));
  });

  test("deleteTask-1 Test", () async {
    // testTask deleted
    // delete again testTask
    await taskRes.taskDao.deleteTask(testTask);

    // check
    expect(
        taskRes.getAllTask(),
        emitsInOrder([
          [insertTestTask]
        ]));
  });

  test("deleteTask-2 Test", () async {
    // delete insertTestTask
    await taskRes.taskDao.deleteTask(insertTestTask);

    // check
    expect(taskRes.getAllTask(), emitsInOrder([[]]));
  });

  test("empty-0 return getAllTask Test", () {
    // check
    expect(taskRes.getAllCompletedTask(true), emitsInOrder([[]]));
    expect(taskRes.getAllCompletedTask(true), emitsInOrder([[]]));
  });

  test("return getAllCompletedTask Test", () async {
    // add task completed = false
    testTask = TaskModel(
      des: testTask.des,
      completed: false,
      time: DateTime.now().millisecondsSinceEpoch,
    );

    var result = await taskRes.taskDao.insertTask(testTask);

    testTask = TaskModel(
      id: result,
      des: testTask.des,
      completed: testTask.completed,
      time: DateTime.now().millisecondsSinceEpoch,
    );

    // check
    expect(taskRes.getAllCompletedTask(true), emitsInOrder([[]]));
    expect(
        taskRes.getAllCompletedTask(false),
        emitsInOrder([
          [testTask]
        ]));
  });
}
