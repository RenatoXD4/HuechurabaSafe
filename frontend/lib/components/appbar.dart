import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget  {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'assets/huechuraba.png',
        height: 56,
        width: 196,
      ),
      backgroundColor: Colors.amber.shade600,
    );
  }
}