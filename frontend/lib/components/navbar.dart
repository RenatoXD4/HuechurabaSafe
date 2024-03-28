import 'package:flutter/material.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: Colors.amber.shade600),
      child: Row(
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.black,),
              tooltip: 'Menú de navegación',
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Image(
              image: AssetImage('assets/huechuraba.png'),
              height: 36,
              width: 196,
              alignment: Alignment.topLeft,
            ),
          ),
        ],
      ),
    );
  }
}

