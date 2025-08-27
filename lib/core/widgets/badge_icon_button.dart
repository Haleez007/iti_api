import 'package:flutter/material.dart';
import 'package:iti_api/core/theme/app_colors.dart';

class BadgeIconButton extends StatelessWidget {
  const BadgeIconButton({
    super.key,
    required this.icon,
    this.badgeCount = 0,
    this.onPressed,
    this.iconColor,
    this.size = 24,
  });

  final IconData icon;
  final int badgeCount;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: iconColor, size: size),
        ),
        if (badgeCount > 0)
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              height: 16,
              width: 16,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$badgeCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
