import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class ProfileSettingsTab extends StatefulWidget {
  const ProfileSettingsTab({
    super.key,
  });

  @override
  State<ProfileSettingsTab> createState() => _ProfileSettingsTabState();
}

class _ProfileSettingsTabState extends State<ProfileSettingsTab> {
  bool _emailNotification = true;
  bool _submissionUpdateNotification = true;
  bool _securityWarningNotification = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SettingsSectionTitle(title: 'Keamanan'),
          const SizedBox(height: 14),

          _SecurityPasswordCard(
            onTap: _showChangePasswordPendingMessage,
          ),

          const _SettingsDivider(),

          const _SettingsSectionTitle(title: 'Notifikasi'),
          const SizedBox(height: 16),

          _NotificationSwitchTile(
            title: 'Notifikasi Email',
            description: 'Terima pembaruan melalui email.',
            value: _emailNotification,
            onChanged: (value) {
              setState(() {
                _emailNotification = value;
              });
            },
          ),
          const SizedBox(height: 18),

          _NotificationSwitchTile(
            title: 'Pembaruan Permohonan',
            description:
            'Dapatkan notifikasi tentang perubahan status permohonan.',
            value: _submissionUpdateNotification,
            onChanged: (value) {
              setState(() {
                _submissionUpdateNotification = value;
              });
            },
          ),
          const SizedBox(height: 18),

          _NotificationSwitchTile(
            title: 'Peringatan Keamanan',
            description: 'Dapatkan informasi peringatan keamanan akun Anda.',
            value: _securityWarningNotification,
            onChanged: (value) {
              setState(() {
                _securityWarningNotification = value;
              });
            },
          ),

          const _SettingsDivider(),

          const _SettingsSectionTitle(title: 'Zona Berbahaya'),
          const SizedBox(height: 12),

          _DangerZoneCard(
            onDeleteTap: () {},
          ),
        ],
      ),
    );
  }

  void _showChangePasswordPendingMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Membuka halaman ubah kata sandi',
        ),
      ),
    );
  }
}

class _SettingsSectionTitle extends StatelessWidget {
  final String title;

  const _SettingsSectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.contentPrimary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        height: 1.25,
      ),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Divider(
        color: Color(0xFFE7E7E7),
        thickness: 1,
        height: 1,
      ),
    );
  }
}

class _SecurityPasswordCard extends StatelessWidget {
  final VoidCallback onTap;

  const _SecurityPasswordCard({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ubah Kata Sandi',
                style: TextStyle(
                  color: AppColors.contentPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Perbarui kata sandi Anda secara\nberkala.',
                style: TextStyle(
                  color: AppColors.contentSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        SizedBox(
          height: 38,
          child: OutlinedButton.icon(
            onPressed: onTap,
            icon: const Icon(
              Icons.gpp_good_outlined,
              size: 20,
            ),
            label: const Text('Ubah'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.contentPrimary,
              side: const BorderSide(
                color: Color(0xFFE1E1E1),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NotificationSwitchTile extends StatelessWidget {
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _NotificationSwitchTile({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.contentPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.contentSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MiniSwitch(
              value: value,
              onChanged: onChanged,
            ),
            const SizedBox(width: 7),
            const Text(
              'Ya',
              style: TextStyle(
                color: AppColors.contentSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MiniSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _MiniSwitch({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 38,
        height: 20,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF35C75A) : const Color(0xFFD1D5DB),
          borderRadius: BorderRadius.circular(999),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 15,
            height: 15,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

class _DangerZoneCard extends StatelessWidget {
  final VoidCallback onDeleteTap;

  const _DangerZoneCard({
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFAFA),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: const Color(0xFFFF2D2D),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hapus Akun Saya',
            style: TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Menghapus seluruh informasi data Anda.',
            style: TextStyle(
              color: AppColors.contentSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 39,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.delete_outline_rounded,
                size: 20,
              ),
              label: const Text('Hapus akun'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF2D2D),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}