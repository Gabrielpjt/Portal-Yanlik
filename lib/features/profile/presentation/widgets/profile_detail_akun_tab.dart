import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../shared/widgets/biometric_authentication_view.dart';
import '../../domain/entities/user_profile_entity.dart';

class ProfileDetailAkunTab extends StatefulWidget {
  final UserProfileEntity? profile;
  final VoidCallback? onLogout;

  const ProfileDetailAkunTab({
    super.key,
    this.profile,
    this.onLogout,
  });

  @override
  State<ProfileDetailAkunTab> createState() => _ProfileDetailAkunTabState();
}

class _ProfileDetailAkunTabState extends State<ProfileDetailAkunTab> {
  bool _dataTerbuka = false;

  Future<void> _handleSensitiveDataTap() async {
    if (_dataTerbuka) {
      setState(() {
        _dataTerbuka = false;
      });

      return;
    }

    final isAuthenticated = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => const BiometricAuthenticationView(
          title: 'Autentikasi Diperlukan',
          description: 'Gunakan kunci biometrik untuk membuka data sensitif.',
          instruction: 'Tempatkan wajah di depan kamera',
          buttonLabel: 'Mulai scan wajah',
        ),
      ),
    );

    if (!mounted || isAuthenticated != true) {
      return;
    }

    setState(() {
      _dataTerbuka = true;
    });
  }

  String _valueOrFallback(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Belum tersedia';
    }

    return value;
  }

  String _masked(String value) {
    if (value.trim().isEmpty || value == 'Belum tersedia') {
      return value;
    }

    if (value.contains('@')) {
      final parts = value.split('@');

      if (parts.length < 2) {
        return value;
      }

      if (parts[0].length > 3) {
        return '${parts[0].substring(0, 3)}${'•' * (parts[0].length - 3)}@${parts[1]}';
      }

      return '•••@${parts[1]}';
    }

    if (value.startsWith('+') && value.length > 8) {
      return '${value.substring(0, 4)} ${'•' * (value.length - 8)} ${value.substring(value.length - 4)}';
    }

    if (value.length > 8) {
      return '${value.substring(0, 4)}${'•' * (value.length - 8)}${value.substring(value.length - 4)}';
    }

    return '•' * value.length;
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;

    final userId = profile?.id?.toString() ?? 'Belum tersedia';
    final username = _valueOrFallback(profile?.username);
    final email = _valueOrFallback(profile?.email);
    final instansi = _valueOrFallback(profile?.instansiName);
    final peran = _valueOrFallback(profile?.peranLabel);

    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSensitiveDataNotice(),

          const SizedBox(height: 12),

          const _SectionTitle(title: 'Informasi Akun'),
          _buildInfoItem('ID Pengguna', userId),
          _buildInfoItem(
            'Username',
            username,
            isSensitive: true,
            isVerified: profile != null && username != 'Belum tersedia',
          ),
          _buildInfoItem(
            'Email',
            email,
            isSensitive: true,
            isVerified: profile != null && email != 'Belum tersedia',
          ),
          _buildInfoItem('Instansi', instansi),
          _buildInfoItem('Peran', peran),

          const _SectionDivider(),

          const _SectionTitle(title: 'Informasi Umum'),
          _buildInfoItem(
            'Nomor Kartu Keluarga',
            'Belum tersedia',
            isSensitive: true,
          ),
          _buildInfoItem(
            'Nomor Induk Kependudukan',
            'Belum tersedia',
            isSensitive: true,
          ),
          _buildInfoItem('Nama Depan', 'Belum tersedia'),
          _buildInfoItem('Jenis Kelamin', 'Belum tersedia'),
          _buildInfoItem('Tanggal Lahir', 'Belum tersedia'),
          _buildInfoItem('Tempat Lahir', 'Belum tersedia'),
          _buildInfoItem('Golongan Darah', 'Belum tersedia'),
          _buildInfoItem('Agama', 'Belum tersedia'),
          _buildInfoItem('Status', 'Belum tersedia'),
          _buildInfoItem('Pekerjaan', 'Belum tersedia'),

          const _SectionDivider(),

          const _SectionTitle(title: 'Informasi Kontak'),
          _buildInfoItem(
            'Email',
            email,
            isSensitive: true,
            isVerified: profile != null && email != 'Belum tersedia',
          ),
          _buildInfoItem(
            'Nomor Handphone',
            'Belum tersedia',
            isSensitive: true,
          ),

          const _SectionDivider(),

          const _SectionTitle(title: 'Alamat'),
          _buildInfoItem('Provinsi', 'Belum tersedia'),
          _buildInfoItem('Kota/Kabupaten', 'Belum tersedia'),
          _buildInfoItem('Kecamatan', 'Belum tersedia'),
          _buildInfoItem('Kelurahan', 'Belum tersedia'),
          _buildInfoItem(
            'Alamat Lengkap',
            'Belum tersedia',
            isSensitive: true,
          ),

          const _SectionDivider(),

          const _SectionTitle(title: 'Pendidikan'),
          _buildEmptyStateCard(
            icon: Icons.school_outlined,
            title: 'Data pendidikan belum tersedia',
            description:
            'Data pendidikan belum dikirim dari server untuk akun ini.',
          ),

          const _SectionDivider(),

          const _SectionTitle(title: 'Pekerjaan'),
          _buildEmptyStateCard(
            icon: Icons.work_outline_rounded,
            title: 'Data pekerjaan belum tersedia',
            description:
            'Data pekerjaan belum dikirim dari server untuk akun ini.',
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: AppColors.strokePrimary, thickness: 1),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GestureDetector(
              onTap: _showLogoutDialog,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red.shade100),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout_rounded,
                      size: 18,
                      color: Colors.red.shade600,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Keluar dari Akun',
                        style: TextStyle(
                          color: Colors.red.shade600,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.red.shade300,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSensitiveDataNotice() {
    final backgroundColor = _dataTerbuka
        ? const Color(0xFFF0FDF4)
        : const Color(0xFFFFFBEB);

    final borderColor =
    _dataTerbuka ? const Color(0xFF16A34A) : const Color(0xFFD97706);

    final iconColor =
    _dataTerbuka ? const Color(0xFF15803D) : const Color(0xFF92400E);

    final title = _dataTerbuka
        ? 'Semua data sensitif sedang ditampilkan'
        : 'Beberapa data sensitif disembunyikan untuk keamanan';

    final description = _dataTerbuka
        ? 'Pastikan menutup data Anda kembali setelah selesai.'
        : 'Data sensitif seperti username, email, NIK, Nomor Kartu Keluarga, nomor handphone, dan alamat detail akan disembunyikan apabila tersedia dari server.';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info,
                color: iconColor,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.contentPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Text(
              description,
              style: const TextStyle(
                color: AppColors.contentSecondary,
                fontSize: 11.5,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _handleSensitiveDataTap,
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _dataTerbuka
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.brandPrimary,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _dataTerbuka ? 'Tutup data' : 'Buka data',
                        style: const TextStyle(
                          color: AppColors.brandPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
      String label,
      String value, {
        bool isSensitive = false,
        bool isVerified = false,
      }) {
    final displayValue = isSensitive && !_dataTerbuka ? _masked(value) : value;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.contentSecondary,
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Flexible(
                child: Text(
                  displayValue,
                  style: TextStyle(
                    color: value == 'Belum tersedia'
                        ? AppColors.contentSecondary
                        : AppColors.contentPrimary,
                    fontSize: 15,
                    fontWeight: value == 'Belum tersedia'
                        ? FontWeight.w500
                        : FontWeight.bold,
                  ),
                ),
              ),
              if (isVerified) ...[
                const SizedBox(width: 6),
                const Icon(
                  Icons.verified,
                  color: AppColors.guide600,
                  size: 16,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyStateCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.strokePrimary,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.contentSecondary,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.contentPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.contentSecondary,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Keluar dari Akun',
          style: TextStyle(
            color: AppColors.contentPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        content: const Text(
          'Apakah Anda yakin ingin keluar dari akun IKD?',
          style: TextStyle(
            color: AppColors.contentSecondary,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Batal',
              style: TextStyle(
                color: AppColors.contentSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onLogout?.call();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.brandPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(color: AppColors.strokePrimary, thickness: 1),
    );
  }
}