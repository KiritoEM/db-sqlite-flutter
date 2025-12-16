import 'package:counter_mvc/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final Function() onLogout;

  const HomeAppbar({super.key, required this.username, required this.onLogout});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: 'Bonjour '),
            TextSpan(
              text: ' $username',
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.surface,
      scrolledUnderElevation: 0,
      actions: [
        PopupMenuItem<String>(
          onTap: () => onLogout(),
          value: 'logout',
          child: const Icon(Icons.logout, color: Colors.red),
        ),
      ],
    );
  }
}
