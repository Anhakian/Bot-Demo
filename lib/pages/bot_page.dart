import 'package:bot_demo/components/bot_avatar_box.dart';
import 'package:flutter/material.dart';
import 'bot_detail_page.dart';

const bots = [
  {
    'image': 'assets/images/heath_image.png',
    'name': 'Beat the Heath',
    'description': 'The Student defeats the Master!',
    'backstory': 'Heath founded the company with a vision to help students conquer the MCAT.'
        ' Known for his mastery of logic and test strategy, he is the benchmark every challenger'
        'hopes to beat. Think you can outscore the creator?',
    'score': '522',
  },
  {
    'image': 'assets/images/dr_shepherd_image.png',
    'name': 'Dr. Shepherd',
    'description': 'Your favourite illogical neurosurgeon',
    'backstory': 'Survived 7 MCAT retakes by pure instinct and caffeine.',
    'score': '525',
  },
  {
    'image': 'assets/images/aamc_image.png',
    'name': 'Sinister AAMC',
    'description': 'Did you just beat the system!',
    'backstory': 'The ultimate gatekeeper of your medical future. Beware.',
    'score': '528',
  },
  {
    'image': 'assets/images/chatgpt_ai_image.png',
    'name': 'ChatGPT-530',
    'description': 'Hold-on... you got to be hacking!',
    'backstory': 'A neural net trained on 10,000 exams. Probably cheating.',
    'score': '530?',
  },
];

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
        padding: const EdgeInsets.all(24.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.0,
          ),
          itemCount: bots.length,
          itemBuilder: (context, index) {
            final bot = bots[index];
            return BotAvatarBox(
              image: bot['image'] as String,
              name: bot['name'] as String,
              description: bot['description'] as String,
              score: bot['score'] as String,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BotDetailPage(
                      image: bot['image']!,
                      name: bot['name']!,
                      description: bot['description']!,
                      slogan: bot['description']!,
                      backstory: bot['backstory']!,
                      mcatScore: bot['score']!,
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
          BottomNavigationBarItem(icon: Icon(Icons.line_weight), label: 'Training'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Review'),
          BottomNavigationBarItem(icon: Icon(Icons.stadium), label: 'Compete'),
        ],
      ),
    );
  }
}
