class Task {
  final int id;
  String title;
  final String date;
  bool isDone;
  String description;

  Task({
    required this.id,
    required this.title,
    required this.date,
    required this.isDone,
    required this.description,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      isDone: json['isDone'],
      description: json['description'],
    );
  }

  factory Task.fromMap(Map map) {
    return Task(
      id: map['id'],
      title: map['title'],
      date: map['create_at'],
      isDone: map['done'] == 1 ? true : false,
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'date': date, 'isDone': isDone};
  }

  @override
  String toString() {
    return "Task(id: $id, title: $title, date: $date, isDone: $isDone)";
  }
}