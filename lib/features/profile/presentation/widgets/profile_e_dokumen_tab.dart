import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../shared/widgets/filter_chips_row.dart';
import '../../../../shared/widgets/filter_sort_row.dart';
import '../pages/document_detail_page.dart';

class ProfileEDokumenTab extends StatefulWidget {
  const ProfileEDokumenTab({super.key});

  @override
  State<ProfileEDokumenTab> createState() => _ProfileEDokumenTabState();
}

class _ProfileEDokumenTabState extends State<ProfileEDokumenTab> {
  int _activeDocTypeIndex = 0; // 0: Dokumen Saya, 1: Dokumen Keluarga
  int _activeCategoryIndex = 0; // 0: Semua, 1: Kependudukan, 2: Administratif, 3: Imigrasi, 4: Lainnya

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 1. Selector "Dokumen Saya" & "Dokumen Keluarga" ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _activeDocTypeIndex = 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _activeDocTypeIndex == 0
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: _activeDocTypeIndex == 0
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  )
                                ]
                              : null,
                        ),
                        child: const Center(
                          child: Text(
                            'Dokumen Saya',
                            style: TextStyle(
                              color: AppColors.contentPrimary,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _activeDocTypeIndex = 1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _activeDocTypeIndex == 1
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: _activeDocTypeIndex == 1
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  )
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Dokumen Keluarga',
                                style: TextStyle(
                                  color: _activeDocTypeIndex == 1
                                      ? AppColors.contentPrimary
                                      : AppColors.contentSecondary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFEE2E2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Text(
                                  '1',
                                  style: TextStyle(
                                    color: Color(0xFFEF4444),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
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
            ),
          ),

          const SizedBox(height: 16),

          // ── Conditional content based on active tab ──
          if (_activeDocTypeIndex == 1)
            _buildDokumenKeluarga()
          else
            _buildDokumenSaya(),
        ],
      ),
    );
  }

  // ── Dokumen Keluarga Content ──
  Widget _buildDokumenKeluarga() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Info Banner
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFBFDBFE)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.info, color: Color(0xFF2563EB), size: 18),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kelola Dokumen Keluarga',
                      style: TextStyle(
                        color: Color(0xFF1D4ED8),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Sebagai kepala keluarga, Anda dapat melihat dan mengelola dokumen digital semua anggota keluarga. Klik anggota keluarga untuk melihat detail dokumen mereka.',
                      style: TextStyle(
                        color: Color(0xFF1E40AF),
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Member count label
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '3 Anggota',
              style: TextStyle(
                color: AppColors.contentSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Family member cards
        _buildFamilyMemberCard(
          initials: 'KM',
          name: 'Karlina Maheira',
          role: 'Istri',
          docCount: '4 dokumen',
          hasNewDoc: false,
        ),
        _buildFamilyMemberCard(
          initials: 'AG',
          name: 'Rizkiawan Andrawan',
          role: 'Anak',
          docCount: '2 dokumen',
          hasNewDoc: true,
          newDocLabel: '1 dokumen baru',
        ),
        _buildFamilyMemberCard(
          initials: 'LA',
          name: 'Lisa Adriani',
          role: 'Anak',
          docCount: '2 dokumen',
          hasNewDoc: false,
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildFamilyMemberCard({
    required String initials,
    required String name,
    required String role,
    required String docCount,
    required bool hasNewDoc,
    String? newDocLabel,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            // Avatar with initials
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Center(
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: AppColors.brandPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Name, role, doc count
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          name,
                          style: const TextStyle(
                            color: AppColors.brandPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          role,
                          style: const TextStyle(
                            color: Color(0xFF2563EB),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        docCount,
                        style: const TextStyle(
                          color: AppColors.contentSecondary,
                          fontSize: 12.5,
                        ),
                      ),
                      if (hasNewDoc && newDocLabel != null) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF2F2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            newDocLabel,
                            style: const TextStyle(
                              color: Color(0xFFDC2626),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.north_east,
              color: AppColors.contentSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // ── Dokumen Saya Content ──
  Widget _buildDokumenSaya() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 2. Search Field ──
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: const [
                Icon(Icons.search, color: AppColors.contentSecondary, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari dokumen',
                      hintStyle: TextStyle(
                        color: AppColors.contentSecondary,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: FilterSortRow(
            sortLabel: 'Terbaru',
          ),
        ),

        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FilterChipsRow(
            chips: const [
              FilterChipItem(
                key: '0',
                label: 'Semua',
                count: 3,
              ),
              FilterChipItem(
                key: '1',
                label: 'Kependudukan',
                count: 2,
              ),
              FilterChipItem(
                key: '2',
                label: 'Administratif',
                count: 1,
              ),
              FilterChipItem(
                key: '3',
                label: 'Imigrasi & Perjalanan',
                count: 0,
              ),
            ],
            selectedKey: _activeCategoryIndex.toString(),
            onSelected: (key) {
              setState(() {
                _activeCategoryIndex = int.parse(key);
              });
            },
          ),
        ),

        // ── 5. Grouped Document Cards ──
        if (_activeCategoryIndex == 0 || _activeCategoryIndex == 1) ...[
          _buildCategorySectionHeader('Kependudukan', '4 Dokumen'),
          _buildDocCard(
            'Kartu Keluarga',
            '3**************38',
            true,
            onTap: () => _openDocument(
              context,
              DocumentData(
                title: 'Kartu Keluarga',
                validUntil: 'Selamanya',
                isVerified: true,
                ownerName: 'Ahmad Andrawan',
                ownerRole: 'Kepala keluarga',
                documentNumber: '53080428062008',
                issueDate: '20 Mei 1990',
                issuedBy: 'Dinas Kependudukan Jakarta Selatan',
              ),
            ),
          ),
          _buildDocCard(
            'Kartu Tanda Penduduk',
            '53***********08',
            true,
            onTap: () => _openDocument(
              context,
              DocumentData(
                title: 'Kartu Tanda Penduduk',
                validUntil: 'Selamanya',
                isVerified: true,
                ownerName: 'Ahmad Andrawan',
                ownerRole: 'Kepala keluarga',
                documentNumber: '53080428062008',
                issueDate: '20 Mei 1990',
                issuedBy: 'Dinas Kependudukan Jakarta Selatan',
              ),
            ),
          ),
          _buildDocCard(
            'Akta Kelahiran',
            '7****-AD-******12-**72',
            true,
            onTap: () => _openDocument(
              context,
              DocumentData(
                title: 'Akta Kelahiran',
                validUntil: 'Selamanya',
                isVerified: true,
                ownerName: 'Ahmad Andrawan',
                documentNumber: '7****-AD-******12-**72',
                issueDate: '28 Juni 2008',
                issuedBy: 'Dinas Kependudukan Jakarta Selatan',
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        if (_activeCategoryIndex == 0 || _activeCategoryIndex == 2) ...[
          _buildCategorySectionHeader('Administratif', '2 Dokumen'),
          _buildDocCard(
            'Nomor Pokok Wajib Pajak',
            'Value',
            true,
            onTap: () => _openDocument(
              context,
              DocumentData(
                title: 'Nomor Pokok Wajib Pajak',
                validUntil: 'Selamanya',
                isVerified: true,
                ownerName: 'Ahmad Andrawan',
                issuedBy: 'Direktorat Jenderal Pajak',
              ),
            ),
          ),
          _buildDocCard(
            'Surat Keterangan Catatan Kepolisian',
            'Value',
            false,
            isAlert: true,
            onTap: () => _openDocument(
              context,
              DocumentData(
                title: 'Surat Keterangan Catatan Kepolisian',
                validUntil: '-',
                isVerified: false,
                ownerName: 'Ahmad Andrawan',
                issuedBy: 'Kepolisian Negara Republik Indonesia',
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        if (_activeCategoryIndex == 0 || _activeCategoryIndex == 3) ...[
          _buildCategorySectionHeader('Imigrasi & Perjalanan', '2 Dokumen'),
          _buildDocCard(
            'Paspor RI',
            'Value',
            true,
            onTap: () => _openDocument(
              context,
              DocumentData(
                title: 'Paspor RI',
                validUntil: '25 Agustus 2029',
                isVerified: true,
                ownerName: 'Ahmad Andrawan',
                issuedBy: 'Direktorat Jenderal Imigrasi',
              ),
            ),
          ),
          _buildDocCard(
            'SIM C',
            '9********44',
            false,
            isAlert: true,
            onTap: () => _openDocument(
              context,
              DocumentData(
                title: 'SIM C',
                validUntil: '15 Maret 2025',
                isVerified: false,
                ownerName: 'Ahmad Andrawan',
                documentNumber: '9********44',
                issuedBy: 'Kepolisian Negara Republik Indonesia',
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        if (_activeCategoryIndex == 0) ...[
          _buildCategorySectionHeader('Lainnya', '1 Dokumen'),
          _buildDocCard(
            'Akta Perkawinan',
            'Value',
            true,
            onTap: () => _openDocument(
              context,
              DocumentData(
                title: 'Akta Perkawinan',
                validUntil: 'Selamanya',
                isVerified: true,
                ownerName: 'Ahmad Andrawan',
                issuedBy: 'Dinas Kependudukan Jakarta Selatan',
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }



  void _openDocument(BuildContext context, DocumentData data) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DocumentDetailPage(document: data),
      ),
    );
  }

  Widget _buildCategorySectionHeader(String title, String countLabel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.brandPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              countLabel,
              style: const TextStyle(
                color: AppColors.contentSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocCard(
    String title,
    String displayValue,
    bool isVerified, {
    bool isAlert = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.brandPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(
                Icons.north_east,
                color: AppColors.contentSecondary,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    displayValue,
                    style: const TextStyle(
                      color: AppColors.contentPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 6),
                  if (isVerified)
                    const Icon(
                      Icons.verified,
                      color: AppColors.guide600,
                      size: 16,
                    )
                  else if (isAlert)
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(
                        Icons.priority_high,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                ],
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Unduh',
                    style: TextStyle(
                      color: AppColors.brandPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
