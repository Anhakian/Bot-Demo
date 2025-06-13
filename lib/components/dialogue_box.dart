import 'package:flutter/material.dart';

class DialogueBox extends StatelessWidget {
  const DialogueBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        child: ClipPath(
          child: Container(
            color: Colors.grey[300],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Dialogue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
