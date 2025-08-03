import 'package:todo_bloc/domain/models/todo.dart';

abstract class TodoRepo {
  // get list of todos
  Future<List<Todo>> getTodo();

  // add a new list
  Future<void> addTodo(Todo newTodo);

  // delete a new list
  Future<void> deleteTodo(Todo todo);

  // update a new list
  Future<void> updateTodo(Todo todo);
}
