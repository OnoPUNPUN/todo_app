import 'dart:ui';
import 'package:flutter/material.dart';

class TopCards extends StatelessWidget {
  final String titleName;
  final IconData titleIcon;
  final Color iconColor;
  final int taskCount;

  const TopCards({
    super.key,
    required this.titleName,
    required this.titleIcon,
    required this.iconColor,
    required this.taskCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(titleIcon, color: iconColor, size: 36),
                  SizedBox(height: 12),
                  Text(
                    titleName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    taskCount.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
