import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final String message;
  final String timeLabel;
  final bool isNew;
  final VoidCallback? onDelete;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
    required this.message,
    required this.timeLabel,
    this.isNew = false,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.strokePrimary,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: iconColor,
                ),
              ),

              const Spacer(),

              _DeleteButton(
                onTap: onDelete,
              ),
            ],
          ),

          const SizedBox(height: 22),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.contentPrimary,
                    height: 1.15,
                  ),
                ),
              ),

              if (isNew) ...[
                const SizedBox(width: 8),
                const _NewBadge(),
              ],
            ],
          ),

          const SizedBox(height: 5),

          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.contentSecondary,
              height: 1.25,
            ),
          ),

          if (timeLabel.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              timeLabel,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.contentSecondary,
                height: 1,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NewBadge extends StatelessWidget {
  const _NewBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Baru',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xFF2563EB),
          height: 1,
        ),
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _DeleteButton({
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.strokePrimary,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.025),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.delete_outline_rounded,
          size: 18,
          color: Color(0xFFFF2D2D),
        ),
      ),
    );
  }
}