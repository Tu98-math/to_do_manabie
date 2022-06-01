import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class TaskModel extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? des;
  final bool? completed;
  final int? time;

  const TaskModel({this.id, this.des, this.completed, this.time});

  @override
  String toString() =>
      "TaskModel(id: $id, des:$des, completed: $completed, time:${DateTime.fromMillisecondsSinceEpoch(time ?? 0)})";

  @override
  List<Object?> get props => [id];
}
