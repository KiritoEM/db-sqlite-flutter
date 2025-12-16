import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyTask extends StatelessWidget {
  final Function() onAddClick;

  const EmptyTask({super.key, required this.onAddClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        SvgPicture.asset('assets/icons/empty.svg', height: 145),
        SizedBox(height: 16),
        Text(
          'Aucune tâche pour le moment',
          style: TextStyle(color: Colors.grey, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: onAddClick,
          label: Text('Ajouter une tâche'),
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
