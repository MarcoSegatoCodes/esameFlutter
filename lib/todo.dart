class Todo {
  Todo({
    required this.createdAt,
    required this.title,
    required this.description,
    this.isDone = false,
  });
  bool isDone;
  String title;
  String description;
  DateTime createdAt;
}

void f() {
  final todo = Todo(
    createdAt: DateTime.now(),
    title: "",
    description: "",
    isDone: true,
  );
  print(todo.isDone); // false
}
