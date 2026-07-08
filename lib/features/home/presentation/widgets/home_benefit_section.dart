import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

/// Section yang muncul di HomePage saat user sudah login.
/// Menampilkan tab Benefit dan E-Dokumen dengan horizontal scroll cards.
class HomeBenefitSection extends StatefulWidget {
  final VoidCallback? onLihatSemuaBenefit;
  final VoidCallback? onLihatSemuaDokumen;
  final void Function(String benefitName)? onBenefitTap;
  final void Function(
      String documentName,
      String category,
      String number,
      bool verified,
      )? onDocumentTap;

  const HomeBenefitSection({
    super.key,
    this.onLihatSemuaBenefit,
    this.onLihatSemuaDokumen,
    this.onBenefitTap,
    this.onDocumentTap,
  });

  @override
  State<HomeBenefitSection> createState() => _HomeBenefitSectionState();
}

class _HomeBenefitSectionState extends State<HomeBenefitSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock data benefit
  static const _benefits = [
    {
      'name': 'Program Keluarga Harapan',
      'amount': '75.000',
      'period': 'Per triwulan',
      'status': 'Aktif',
      'cair': 'Cair Feb 2026',
    },
    {
      'name': 'Bantuan Pangan Non Tunai',
      'amount': '118.000',
      'period': 'Saldo tersedia',
      'status': 'Aktif',
      'cair': null,
    },
    {
      'name': 'Kartu Indonesia Pintar',
      'amount': '900.000',
      'period': 'Per semester',
      'status': 'Aktif',
      'cair': 'Cair Okt 2026',
    },
  ];

  // Mock data dokumen
  static const _documents = [
    {
      'name': 'Kartu Keluarga',
      'category': 'Kependudukan',
      'number': '3***********38',
      'verified': true,
    },
    {
      'name': 'KTP Elektronik',
      'category': 'Kependudukan',
      'number': '3***********71',
      'verified': true,
    },
    {
      'name': 'Akta Kelahiran',
      'category': 'Kependudukan',
      'number': '5***********02',
      'verified': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Tab Toggle ──────────────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.strokePrimary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              _buildTab(0, 'Benefit'),
              _buildTab(1, 'E-Dokumen'),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // ── Section Title ───────────────────────────────────────────
        Text(
          _tabController.index == 0 ? 'Benefit Anda' : 'E-Dokumen Anda',
          style: const TextStyle(
            color: AppColors.brandPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _tabController.index == 0
              ? 'Anda memiliki ${_benefits.length} benefit.'
              : 'Anda memiliki ${_documents.length} dokumen.',
          style: const TextStyle(
            color: AppColors.contentSecondary,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 12),

        // ── Cards ───────────────────────────────────────────────────
        if (_tabController.index == 0)
          _buildBenefitCards()
        else
          _buildDocumentCards(),

        const SizedBox(height: 12),

        // ── Lihat Semua Link ────────────────────────────────────────
        Center(
          child: GestureDetector(
            onTap: _tabController.index == 0
                ? widget.onLihatSemuaBenefit
                : widget.onLihatSemuaDokumen,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _tabController.index == 0
                      ? 'Lihat semua benefit'
                      : 'Lihat semua dokumen',
                  style: const TextStyle(
                    color: AppColors.brandPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_outward,
                  size: 16,
                  color: AppColors.brandPrimary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTab(int index, String label) {
    final isSelected = _tabController.index == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _tabController.animateTo(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.brandPrimary : Colors.white,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.contentSecondary,
                fontSize: 14,
                fontWeight:
                    isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitCards() {
    return SizedBox(
      height: 148,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _benefits.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final b = _benefits[index];
          final benefitName = b['name'] as String;

          return _BenefitCard(
            name: benefitName,
            amount: b['amount'] as String,
            period: b['period'] as String,
            status: b['status'] as String,
            cairDate: b['cair'] as String?,
            onTap: () {
              widget.onBenefitTap?.call(benefitName);
            },
          );
        },
      ),
    );
  }

  Widget _buildDocumentCards() {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _documents.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final d = _documents[index];

          final documentName = d['name'] as String;
          final category = d['category'] as String;
          final number = d['number'] as String;
          final verified = d['verified'] as bool;

          return _DocumentCard(
            name: documentName,
            category: category,
            number: number,
            verified: verified,
            onTap: () {
              widget.onDocumentTap?.call(
                documentName,
                category,
                number,
                verified,
              );
            },
          );
        },
      ),
    );
  }
}

// ── Benefit Card ──────────────────────────────────────────────────────────────

class _BenefitCard extends StatelessWidget {
  final String name;
  final String amount;
  final String period;
  final String status;
  final String? cairDate;
  final VoidCallback? onTap;

  const _BenefitCard({
    required this.name,
    required this.amount,
    required this.period,
    required this.status,
    this.cairDate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.strokePrimary),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name + Arrow
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: AppColors.brandPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_outward,
                    size: 14,
                    color: AppColors.contentSecondary,
                  ),
                ],
              ),

              const SizedBox(height: 4),

              // Amount
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: AppColors.brandPrimary),
                  children: [
                    const TextSpan(
                      text: 'Rp. ',
                      style: TextStyle(fontSize: 13),
                    ),
                    TextSpan(
                      text: amount,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 4),

              // Period
              Text(
                period,
                style: const TextStyle(
                  color: AppColors.contentSecondary,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 4),
              // Status badges
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [
                  _StatusBadge(label: status, isGreen: true),
                  if (cairDate != null)
                    _StatusBadge(label: cairDate!, isGreen: false),
                ],
              ),
            ],
          ),
        ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final bool isGreen;

  const _StatusBadge({required this.label, required this.isGreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isGreen
            ? const Color(0xFFDCFCE7)
            : const Color(0xFFDBEAFE),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isGreen ? const Color(0xFF15803D) : const Color(0xFF1D4ED8),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ── Document Card ─────────────────────────────────────────────────────────────

class _DocumentCard extends StatelessWidget {
  final String name;
  final String category;
  final String number;
  final bool verified;
  final VoidCallback? onTap;

  const _DocumentCard({
    required this.name,
    required this.category,
    required this.number,
    required this.verified,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.strokePrimary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name + Arrow
            Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: AppColors.brandPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.arrow_outward,
                  size: 14,
                  color: AppColors.contentSecondary,
                ),
              ],
            ),

            Text(
              category,
              style: const TextStyle(
                color: AppColors.contentSecondary,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          number,
                          style: const TextStyle(
                            color: AppColors.contentPrimary,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (verified) ...[
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified,
                          size: 14,
                          color: Color(0xFF2563EB),
                        ),
                      ],
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.strokePrimary),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Unduh',
                    style: TextStyle(
                      color: AppColors.brandPrimary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}