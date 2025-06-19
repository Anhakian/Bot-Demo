import 'package:bot_demo/components/bot_avatar_box.dart';
import 'package:bot_demo/models/bot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/bots.dart';
import 'bot_detail_page.dart';

class BotPage extends StatelessWidget {
  const BotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212323),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'MCAT Bots',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.white),
        actions: const [Icon(Icons.search, color: Colors.white)],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14.w,
            mainAxisSpacing: 14.w,
            childAspectRatio: 1.0,
          ),
          itemCount: bots.length,
          itemBuilder: (context, index) {
            final bot = bots[index];
            final botModel = Bot.fromMap(bot);
            return BotAvatarBox(
              bot: botModel,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BotDetailPage(
                      bot: botModel,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF3F3D3D),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: 4,
        onTap: (index) {
          print("Selected Index: $index");
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.note_add), label: 'Study'),
          BottomNavigationBarItem(
              icon: Icon(Icons.line_weight), label: 'Training'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Review'),
          BottomNavigationBarItem(icon: Icon(Icons.stadium), label: 'Compete'),
        ],
      ),
    );
  }
}
