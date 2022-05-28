import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class TaskModel extends Equatable {
  @primaryKey
  final String? id;
  final String? des;
  final bool? completed;
  final int? time;

  const TaskModel({this.id, this.des, this.completed, this.time});

  @override
  List<Object?> get props => [id];
}
