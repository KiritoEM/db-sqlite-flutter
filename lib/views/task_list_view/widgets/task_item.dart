import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskItem extends StatelessWidget {
  bool isDone = false;
  Function(bool? value) onCheck;
  Function()? onDelete;
  String title;
  String date;
  String? description;

  TaskItem({
    super.key,
    required this.isDone,
    required this.onCheck,
    this.onDelete,
    required this.title,
    required this.date,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Checkbox(
                value: isDone,
                activeColor: Colors.blue,
                onChanged: (bool? value) => onCheck(value),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 19,
                              decoration: isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (isDone)
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(3),
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 13,
                            ),
                          ),
                      ],
                    ),

                    Text(
                      date,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),

                    if (description != null && description!.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Text(
                        description!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 8),

              if (onDelete != null)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirmer la suppression'),
                          content: const Text(
                            'Voulez-vous vraiment supprimer cette tâche ?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Annuler'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                onDelete!();
                              },
                              child: const Text(
                                'Supprimer',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
