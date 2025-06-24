import 'package:flutter/material.dart';

class BotAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  const BotAppBar({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
      ),
      actions: const [Icon(Icons.search, color: Colors.white)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
