class CreateTaskSchema {
  String title = '';
  String? description;

  CreateTaskSchema({required this.title, this.description});
}
