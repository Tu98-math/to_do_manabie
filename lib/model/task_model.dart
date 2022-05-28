import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String? id;
  final String? des;
  final bool? completed;

  const TaskModel(
    this.id,
    this.des,
    this.completed,
  );

  @override
  List<Object?> get props => throw UnimplementedError();
}
