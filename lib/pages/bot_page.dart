import 'package:bot_demo/components/bot_avatar_box.dart';
import 'package:flutter/material.dart';

const bots = [
  {
    'image': 'assets/images/heath_image.png',
    'name': 'Beat the Heath',
    'description': 'The Student defeats the Master!',
  },
  {
    'image': 'assets/images/dr_shepherd_image.png',
    'name': 'Dr. Shepherd',
    'description': 'Your favourite illogical neurosurgeon',
  },
  {
    'image': 'assets/images/aamc_image.png',
    'name': 'Sinister AAMC',
    'description': 'Did you just beat the system!',
  },
  {
    'image': 'assets/images/chatgpt_ai_image.png',
    'name': 'ChatGPT-530',
    'description': 'Hold-on... you got to be hacking!',
  },
];

class BotPage extends StatelessWidget {
  const BotPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF212323),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'MCAT Bots',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        actions: const [
          Icon(
            Icons.search,
            color: Colors.white,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 16.0, // Space between columns
                  mainAxisSpacing: 16.0, // Space between rows
                  childAspectRatio: 1.0, // Keep squares (1:1 ratio)
                ),
                itemCount: bots.length,
                itemBuilder: (context, index) {
                  final bot = bots[index];
                  return BotAvatarBox(
                    image: bot['image'] as String,
                    name: bot['name'] as String,
                    description: bot['description'] as String,
                    onTap: () {
                      print('${bot['name']} selected!');
                      // Add your navigation or action here
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: (screenWidth / 2 - 16) * 2,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/botmcr');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F3D3D), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Play',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
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
          // Handle item taps here
          print("Selected Index: $index");
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add),
            label: 'Study',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.line_weight),
            label: 'Training',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Review',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stadium),
            label: 'Compete',
          )
        ],
      ),
    );
  }
}
