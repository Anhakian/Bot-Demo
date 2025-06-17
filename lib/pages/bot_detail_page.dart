import 'package:bot_demo/components/router.dart';
import 'package:bot_demo/models/bot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BotDetailPage extends StatelessWidget {
  final Bot bot;

  const BotDetailPage({
    super.key,
    required this.bot,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212323),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(bot.name, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 25.h,
              left: 20.w,
              right: 20.w,
              bottom: 80.h, // spacing for button
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(bot.image, height: 180),

                const SizedBox(height: 8),

                // Head-to-head placeholder
                const Text(
                  'Head-to-Head: 0 - 0',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),

                SizedBox(height: 10.h),
                Text(
                  bot.description,
                  style: TextStyle(color: Colors.grey, fontSize: 18.sp),
                ),
                SizedBox(height: 10.h),
                Text(
                  'MCAT Score: ${bot.score}',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
                SizedBox(height: 10.h),

                // Scrollable Backstory Box
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        bot.backstory,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

                // Achievements Button (placeholder)
                SizedBox(
                  width: 60,
                  height: 60,
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Navigate to achievements page
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      backgroundColor: const Color(0xFF3F3D3D),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Icon(Icons.emoji_events,
                        color: Colors.amber, size: 32),
                  ),
                ),
              ],
            ),
          ),

          /// Fixed Play Button
          Positioned(
            left: 20.w,
            right: 20.w,
            bottom: 25.h,
            child: SizedBox(
              width: double.infinity,
              height: 40.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouter.botQuizRoute,
                    arguments: bot,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F3D3D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  'Play',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
