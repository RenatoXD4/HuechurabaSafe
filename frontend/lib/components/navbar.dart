import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber.shade600,
            ),
            child: const Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Add your onTap action here
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Add your onTap action here
            },
          ),
          ListTile(
            title: const Text('Item 3'),
            onTap: () {
              // Add your onTap action here
            },
          ),
        ],
      ),
    );
  }
}