import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class ServiceDetailSupportSection extends StatefulWidget {
  final String serviceTitle;

  const ServiceDetailSupportSection({
    super.key,
    required this.serviceTitle,
  });

  @override
  State<ServiceDetailSupportSection> createState() {
    return _ServiceDetailSupportSectionState();
  }
}

class _ServiceDetailSupportSectionState
    extends State<ServiceDetailSupportSection> {
  int? _openedQuestion = 0;

  List<Map<String, String>> get _questions {
    if (widget.serviceTitle == 'Cari Fasilitas Kesehatan') {
      return const [
        {
          'question': 'Apa itu verifikasi BPJS?',
          'answer':
          'Fasilitas kesehatan yang terverifikasi BPJS adalah rumah sakit, '
              'klinik, atau puskesmas yang telah terdaftar dan bekerja sama '
              'dengan BPJS Kesehatan. Anda dapat menggunakan kartu BPJS '
              'untuk berobat di fasilitas tersebut.',
        },
        {
          'question': 'Apakah semua fasilitas buka 24 jam?',
          'answer':
          'Tidak semua fasilitas kesehatan beroperasi selama 24 jam. '
              'Jam operasional dapat berbeda pada setiap fasilitas.',
        },
        {
          'question':
          'Apa perbedaan antara Rumah Sakit, Klinik, dan Puskesmas?',
          'answer':
          'Rumah sakit menyediakan layanan yang lebih lengkap, klinik '
              'melayani kebutuhan tertentu, sedangkan puskesmas merupakan '
              'fasilitas kesehatan tingkat pertama.',
        },
      ];
    }

    if (widget.serviceTitle == 'Pengurusan Akta Kelahiran') {
      return const [
        {
          'question': 'Siapa yang dapat mengajukan Akta Kelahiran?',
          'answer':
          'Pengajuan dapat dilakukan oleh orang tua, wali, atau pihak '
              'yang diberikan kuasa sesuai ketentuan yang berlaku.',
        },
        {
          'question':
          'Apakah pengurusan Akta Kelahiran dikenakan biaya?',
          'answer':
          'Pengurusan Akta Kelahiran melalui layanan resmi pemerintah '
              'tidak dikenakan biaya.',
        },
        {
          'question':
          'Berapa lama proses penerbitan Akta Kelahiran?',
          'answer':
          'Waktu penerbitan bergantung pada kelengkapan dokumen dan '
              'proses verifikasi dari instansi terkait.',
        },
      ];
    }

    return const [
      {
        'question': 'Bagaimana cara mengakses layanan ini?',
        'answer':
        'Klik tombol Akses layanan, kemudian ikuti petunjuk yang tersedia.',
      },
      {
        'question': 'Apakah layanan ini dikenakan biaya?',
        'answer':
        'Informasi mengenai biaya dapat dilihat pada portal resmi layanan.',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionTitle(title: 'Kanal Pengaduan'),
        const SizedBox(height: 14),
        const _ComplaintChannelChips(),
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
        ...List.generate(
          _questions.length,
              (index) {
            final question = _questions[index];
            final isOpened = _openedQuestion == index;

            return _QuestionItem(
              question: question['question']!,
              answer: question['answer']!,
              isOpened: isOpened,
              onTap: () {
                setState(() {
                  _openedQuestion = isOpened ? null : index;
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
  const _ComplaintChannelChips();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: const [
        _ComplaintTopChip(
          label: 'Whatsapp Aduan',
        ),
        _ComplaintTopChip(
          label: 'Email Dinas',
        ),
      ],
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
      onPressed: () {},
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
              fontSize: 12,
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
                fontSize: 11,
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
                      question,
                      style: const TextStyle(
                        color: AppColors.contentPrimary,
                        fontSize: 13,
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
                  answer,
                  style: const TextStyle(
                    color: AppColors.contentPrimary,
                    fontSize: 12,
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
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Anda dapat menghubungi tim kami.',
                    style: TextStyle(
                      color: AppColors.contentSecondary,
                      fontSize: 11,
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