import 'package:bot_demo/components/bot_app_bar.dart';
import 'package:bot_demo/components/router.dart';
import 'package:bot_demo/lib/services/flask_service.dart';
import 'package:bot_demo/models/bot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BotDetailPage extends StatefulWidget {
  final Bot bot;

  const BotDetailPage({
    super.key,
    required this.bot,
  });

  @override
  State<BotDetailPage> createState() => _BotDetailPageState();
}

class _BotDetailPageState extends State<BotDetailPage> {
  bool _isLoading = false;

  Future<void> _handlePlay() async {
    setState(() {
      _isLoading = true;
    });

    final flaskService = FlaskService();
    final response =
        await flaskService.startGame(widget.bot.name, "player_123");
    final sessionId = response["session_id"];
    print(sessionId);

    if (!mounted) return; // check before using context

    setState(() {
      _isLoading = false;
    });

    if (sessionId != null) {
      Navigator.pushNamed(context, AppRouter.botQuizRoute, arguments: {
        "bot": widget.bot,
        "sessionId": sessionId,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to start game")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212323),
      appBar: BotAppBar(
        name: widget.bot.name,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 25.h,
              left: 20.w,
              right: 20.w,
              bottom: 100.h, // spacing for button
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(widget.bot.image, height: 150.h),

                SizedBox(height: 8.h),

                // Head-to-head placeholder
                Text(
                  'Head-to-Head: 0 - 0',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),

                SizedBox(height: 10.h),
                Text(
                  widget.bot.description,
                  style: TextStyle(color: Colors.grey, fontSize: 18.sp),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10.h),
                Text(
                  'MCAT Score: ${widget.bot.score}',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
                SizedBox(height: 10.h),

                // Scrollable Backstory Box
                Expanded(
                  child: Container(
                    height: 5.h,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        widget.bot.backstory,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                // Achievements Button (placeholder)
                SizedBox(
                  width: 55.w,
                  height: 55.h,
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Navigate to achievements page
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                      backgroundColor: const Color(0xFF3F3D3D),
                      padding: EdgeInsets.zero,
                    ),
                    child: Icon(Icons.emoji_events,
                        color: Colors.amber, size: 30.sp),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 20.w,
            right: 20.w,
            bottom: 25.h,
            child: SizedBox(
              width: double.infinity,
              height: 40.h,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handlePlay,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F3D3D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        'Play',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
