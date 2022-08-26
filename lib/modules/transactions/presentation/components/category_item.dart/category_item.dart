import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Color? backgroundColor;
  final Widget? icon;
  final String? title;
  final String? emojiTitle;
  const CategoryItem({
    super.key,
    this.icon,
    this.title,
    this.backgroundColor,
    this.emojiTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon ?? Container(),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                title ?? '',
                style: TextStyle(
                  fontFamily: 'San Francisco',
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
