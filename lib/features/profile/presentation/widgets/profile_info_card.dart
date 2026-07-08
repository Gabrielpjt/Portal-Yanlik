import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class ProfileInfoCard extends StatelessWidget {
  final String name;
  final String joinDate;
  final String avatarUrl;

  const ProfileInfoCard({
    super.key,
    required this.name,
    required this.joinDate,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Row(
        children: [
          // Avatar with verified badge
          Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(avatarUrl),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: AppColors.strokePrimary,
                    width: 1,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(1.5),
                  child: const Icon(
                    Icons.verified,
                    color: AppColors.guide600,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),

          // Name + join date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.contentPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  joinDate,
                  style: const TextStyle(
                    color: AppColors.contentSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
