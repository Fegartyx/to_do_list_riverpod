class Task {
  final int id;
  final String title;
  final String description;
  final bool isCompleted;

  Task(
    this.id, {
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}
