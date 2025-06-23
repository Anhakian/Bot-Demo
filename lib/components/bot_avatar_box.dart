import 'package:bot_demo/models/bot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BotAvatarBox extends StatelessWidget {
  final Bot bot;
  final Color borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const BotAvatarBox({
    super.key,
    required this.bot,
    this.borderColor = const Color(0xFF433F3B),
    this.borderWidth,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveBorderWidth = borderWidth ?? 4.w;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2D2D),
          border: Border.all(color: borderColor, width: effectiveBorderWidth),
          borderRadius: borderRadius ?? BorderRadius.circular(12.sp),
        ),
        child: Padding(
          padding: EdgeInsets.all(7.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                bot.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.sp),

              // Image
              Expanded(
                flex: 3,
                child: SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(8.sp),
                    child: Image.asset(
                      bot.image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[800],
                          child: Icon(
                            Icons.smart_toy,
                            color: Colors.grey[400],
                            size: 35.w,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 2.sp),

              // Description (slogan)
              Text(
                bot.description,
                style: TextStyle(fontSize: 10.sp, color: Colors.grey[400]),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 2.sp),

              // MCAT Score (bold)
              Text(
                'MCAT: ${bot.score}',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
