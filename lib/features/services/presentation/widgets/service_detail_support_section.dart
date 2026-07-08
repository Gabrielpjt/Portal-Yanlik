import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/service_detail_entity.dart';

class ServiceDetailSupportSection extends StatefulWidget {
  final ServiceDetailEntity detail;

  const ServiceDetailSupportSection({
    super.key,
    required this.detail,
  });

  @override
  State<ServiceDetailSupportSection> createState() {
    return _ServiceDetailSupportSectionState();
  }
}

class _ServiceDetailSupportSectionState
    extends State<ServiceDetailSupportSection> {
  final Set<int> _openedQuestions = <int>{};

  @override
  Widget build(BuildContext context) {
    final faqItems = widget.detail.faq;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionTitle(title: 'Kanal Pengaduan'),
        const SizedBox(height: 14),
        _ComplaintChannelChips(
          channels: widget.detail.kanalPengaduan,
        ),
        const SizedBox(height: 14),
        const _ComplaintCard(),
        const Divider(
          height: 38,
          thickness: 1,
        ),
        const _SectionTitle(
          title: 'Pertanyaan Seputar Layanan',
        ),
        const SizedBox(height: 12),
        if (faqItems.isEmpty)
          const Text(
            'Belum ada pertanyaan seputar layanan ini.',
            style: TextStyle(
              color: AppColors.contentSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          )
        else
          ...List.generate(
            faqItems.length,
                (index) {
              final item = faqItems[index];
              final isOpened = _openedQuestions.contains(index);

              return _QuestionItem(
                question: item.pertanyaan,
                answer: item.jawaban,
                isOpened: isOpened,
                onTap: () {
                  setState(() {
                    if (isOpened) {
                      _openedQuestions.remove(index);
                    } else {
                      _openedQuestions.add(index);
                    }
                  });
                },
              );
            },
          ),
        const SizedBox(height: 12),
        const _HelpCard(),
      ],
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
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.contentPrimary,
        fontSize: 20,
        height: 1.3,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ComplaintChannelChips extends StatelessWidget {
  final List<ServiceComplaintEntity> channels;

  const _ComplaintChannelChips({
    required this.channels,
  });

  @override
  Widget build(BuildContext context) {
    if (channels.isEmpty) {
      return const Text(
        'Belum ada kanal pengaduan khusus untuk layanan ini.',
        style: TextStyle(
          color: AppColors.contentSecondary,
          fontSize: 14,
          height: 1.5,
        ),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: channels.map((item) {
        final label = item.judul.trim().isNotEmpty
            ? item.judul.trim()
            : item.tipe.trim();

        return _ComplaintTopChip(
          label: label.isNotEmpty ? label : 'Kanal Pengaduan',
        );
      }).toList(),
    );
  }
}

class _ComplaintTopChip extends StatelessWidget {
  final String label;

  const _ComplaintTopChip({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.contentPrimary,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        side: const BorderSide(
          color: AppColors.strokePrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(
            Icons.arrow_outward,
            size: 14,
            color: AppColors.contentSecondary,
          ),
        ],
      ),
    );
  }
}

class _ComplaintCard extends StatelessWidget {
  const _ComplaintCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: AppColors.strokePrimary,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sampaikan Melalui Aplikasi LAPOR!',
            style: TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'Melalui LAPOR!, Anda dapat menyampaikan permasalahan '
                'pelayanan publik yang Anda temui dalam satu kanal sehingga '
                'laporan dapat kami sampaikan ke instansi terkait.',
            style: TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 13,
              height: 1.45,
            ),
          ),
          SizedBox(height: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ComplaintChip(
                icon: Icons.language,
                label: 'Website lapor',
              ),
              SizedBox(height: 8),
              _ComplaintChip(
                icon: Icons.play_arrow_rounded,
                label: 'Unduh di Playstore',
              ),
              SizedBox(height: 8),
              _ComplaintChip(
                icon: Icons.apple,
                label: 'Unduh di Appstore',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ComplaintChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ComplaintChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.strokePrimary,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 13,
              color: AppColors.brandPrimary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.brandPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestionItem extends StatelessWidget {
  final String question;
  final String answer;
  final bool isOpened;
  final VoidCallback onTap;

  const _QuestionItem({
    required this.question,
    required this.answer,
    required this.isOpened,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final safeQuestion = question.trim().isNotEmpty
        ? question.trim()
        : 'Pertanyaan layanan';
    final safeAnswer = answer.trim().isNotEmpty
        ? answer.trim()
        : '-';

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.strokePrimary,
          ),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      safeQuestion,
                      style: const TextStyle(
                        color: AppColors.contentPrimary,
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isOpened
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 18,
                    color: AppColors.contentPrimary,
                  ),
                ],
              ),
              if (isOpened) ...[
                const SizedBox(height: 10),
                Text(
                  safeAnswer,
                  style: const TextStyle(
                    color: AppColors.contentPrimary,
                    fontSize: 14,
                    height: 1.45,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _HelpCard extends StatelessWidget {
  const _HelpCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.strokePrimary,
          ),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.chat_bubble_outline,
              color: AppColors.contentSecondary,
              size: 18,
            ),
            SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tidak menemukan jawaban Anda?',
                    style: TextStyle(
                      color: AppColors.contentPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Anda dapat menghubungi tim kami.',
                    style: TextStyle(
                      color: AppColors.contentSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: AppColors.contentSecondary,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
