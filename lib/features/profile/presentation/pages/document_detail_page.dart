import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/app_footer.dart';

/// Model data untuk dokumen yang akan ditampilkan di halaman detail.
class DocumentData {
  final String title;
  final String validUntil;
  final bool isVerified;
  final String ownerName;
  final String? ownerRole; // e.g. 'Kepala keluarga'
  final String? documentNumber;
  final String? issueDate;
  final String? issuedBy;

  const DocumentData({
    required this.title,
    required this.validUntil,
    required this.isVerified,
    required this.ownerName,
    this.ownerRole,
    this.documentNumber,
    this.issueDate,
    this.issuedBy,
  });
}

class DocumentDetailPage extends StatelessWidget {
  final DocumentData document;
  final VoidCallback? onMenuTap;

  const DocumentDetailPage({
    super.key,
    required this.document,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      body: Column(
        children: [
          // ── 1. Header ──
          AppHeader(
            onMenuTap: onMenuTap,
            isLoggedIn: true,
            showLoginButton: false,
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // ── 2. Breadcrumb ──
                Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .popUntil((route) => route.isFirst),
                        child: const Text(
                          'Beranda',
                          style: TextStyle(
                            color: AppColors.contentSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(Icons.chevron_right,
                            size: 14, color: AppColors.contentSecondary),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Akun Saya',
                          style: TextStyle(
                            color: AppColors.contentSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(Icons.chevron_right,
                            size: 14, color: AppColors.contentSecondary),
                      ),
                      Flexible(
                        child: Text(
                          document.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.contentPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ── 3. Top Summary Card ──
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        document.title,
                        style: const TextStyle(
                          color: AppColors.brandPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.access_time_outlined,
                              color: AppColors.contentSecondary, size: 16),
                          const SizedBox(width: 4),
                          const Text(
                            'Berlaku hingga ',
                            style: TextStyle(
                              color: AppColors.contentSecondary,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            document.validUntil,
                            style: const TextStyle(
                              color: AppColors.contentPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: document.isVerified
                                  ? const Color(0xFFEFF6FF)
                                  : const Color(0xFFFEF2F2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              document.isVerified
                                  ? 'Tervalidasi'
                                  : 'Belum Tervalidasi',
                              style: TextStyle(
                                color: document.isVerified
                                    ? const Color(0xFF2563EB)
                                    : const Color(0xFFDC2626),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.download, size: 18),
                        label: const Text('Unduh dokumen'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brandPrimary,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 46),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ── 4. Detailed Metadata Card ──
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Owner label + name + role badge
                      Text(
                        document.ownerName,
                        style: const TextStyle(
                          color: AppColors.contentSecondary,
                          fontSize: 12.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            document.ownerName,
                            style: const TextStyle(
                              color: AppColors.brandPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (document.ownerRole != null) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0FDF4),
                                borderRadius: BorderRadius.circular(30),
                                border:
                                    Border.all(color: const Color(0xFFDCFCE7)),
                              ),
                              child: Text(
                                document.ownerRole!,
                                style: const TextStyle(
                                  color: Color(0xFF16A34A),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),

                      if (document.documentNumber != null) ...[
                        const SizedBox(height: 16),
                        _buildMetaItem('Nomor Dokumen', document.documentNumber!),
                      ],

                      if (document.issueDate != null) ...[
                        const SizedBox(height: 16),
                        _buildMetaItem('Tanggal Terbit', document.issueDate!),
                      ],

                      if (document.issuedBy != null) ...[
                        const SizedBox(height: 16),
                        _buildMetaItem('Diterbitkan Oleh', document.issuedBy!),
                      ],

                      const SizedBox(height: 16),
                      const Divider(color: AppColors.strokePrimary, thickness: 1),
                      const SizedBox(height: 16),

                      // ── Lihat Dokumen Section ──
                      Center(
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFFE2E8F0),
                                      width: 2,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 76,
                                  height: 76,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.black.withValues(alpha: 0.08),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.description_outlined,
                                    color: AppColors.brandPrimary,
                                    size: 32,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Lihat Dokumen',
                              style: TextStyle(
                                color: AppColors.brandPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Untuk dapat melihat dokumen secara langsung klik tombol di bawah ini.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.contentSecondary,
                                  fontSize: 12.5,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.visibility_outlined,
                                  size: 16),
                              label: const Text('Lihat dokumen'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.brandPrimary,
                                side: const BorderSide(
                                    color: Color(0xFFCBD5E1)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                textStyle: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── 5. App Footer ──
                const AppFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.contentSecondary,
            fontSize: 12.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.contentPrimary,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
