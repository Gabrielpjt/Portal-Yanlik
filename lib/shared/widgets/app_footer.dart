import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../core/constants/app_assets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'faq_section.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.strokePrimary, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FAQ Section
          const FaqSection(),
          const SizedBox(height: 32),
          // Logo
          Image.asset(
            AppAssets.logoInaku,
            height: 40,
            errorBuilder: (context, error, stackTrace) {
              return const Text(
                'INAKU',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brandPrimary,
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          // Description
          const Text(
            'Platform digital terpadu yang mengintegrasikan seluruh layanan administrasi pemerintahan untuk kemudahan akses masyarakat.',
            style: TextStyle(
              color: AppColors.contentSecondary,
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          // Social Media Icons
          Row(
            children: [
              _buildSocialIconButton(
                icon: FontAwesomeIcons.instagram,
                iconSize: 20,
                onTap: () {},
              ),
              const SizedBox(width: 10),
              _buildSocialIconButton(
                icon: FontAwesomeIcons.tiktok,
                iconSize: 18,
                onTap: () {},
              ),
              const SizedBox(width: 10),
              _buildSocialIconButton(
                icon: FontAwesomeIcons.xTwitter,
                iconSize: 18,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Footer Sections
          _buildExpandableSection('Layanan Publik'),
          const SizedBox(height: 20),
          _buildExpandableSection('Bantuan'),
          const SizedBox(height: 32),
          const Divider(color: AppColors.strokePrimary, thickness: 1),
          const SizedBox(height: 20),
          // Bottom Links
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Syarat dan Ketentuan',
                    style: TextStyle(
                      color: AppColors.contentPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Text(
                  '|',
                  style: TextStyle(
                    color: AppColors.contentSecondary,
                    fontSize: 13,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Kebijakan Privasi',
                    style: TextStyle(
                      color: AppColors.contentPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Copyright
          const Center(
            child: Text(
              'Copyright © 2026, INAKU - All right reserved.',
              style: TextStyle(
                color: AppColors.contentSecondary,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIconButton({
    required FaIconData icon,
    required VoidCallback onTap,
    double iconSize = 16,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.strokePrimary,
              width: 1,
            ),
          ),
          child: FaIcon(
            icon,
            size: iconSize,
            color: AppColors.brandPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableSection(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.contentPrimary,
            size: 24,
          ),
        ],
      ),
    );
  }
}
