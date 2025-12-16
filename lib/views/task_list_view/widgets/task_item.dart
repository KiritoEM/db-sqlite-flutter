// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskItem extends StatelessWidget {
  int id;
  bool isDone = false;
  Function(bool? value) onCheck;
  Function()? onDelete;
  String title;
  String date;
  String? description;

  TaskItem({
    super.key,
    required this.id,
    required this.isDone,
    required this.onCheck,
    this.onDelete,
    required this.title,
    required this.date,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id.toString()),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart && onDelete != null) {
          final bool? result = await showDialog<bool>(
            context: context,
            builder: (context) => _buildDeleteDialog(context, onDelete!),
          );
          return result ?? false;
        }
        return false;
      },
      background: _buildSlideRight(),
      child: SizedBox(
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
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
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
                IconButton(
                  icon: const Icon(Icons.edit_note_sharp),
                  color: Colors.lime,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteDialog(BuildContext context, Function onDelete) {
    return AlertDialog(
      title: const Text('Confirmer la suppression'),
      content: const Text('Voulez-vous vraiment supprimer cette tâche ?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            onDelete();
          },
          child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }

  Widget _buildSlideRight() {
    return Container(
      color: Colors.red,

      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 20),
            Icon(Icons.delete, color: Colors.white),
            Text(
              " Supprimer",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
