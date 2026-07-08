import 'package:flutter/material.dart';

import 'service_application_common_widgets.dart';

class BansosNikInputStep extends StatelessWidget {
  final String selectedNikType;
  final TextEditingController nikController;
  final bool isSelfNik;
  final bool canContinue;
  final ValueChanged<String> onNikTypeChanged;
  final ValueChanged<String> onNikChanged;
  final VoidCallback onNext;
  final VoidCallback onCancel;

  const BansosNikInputStep({
    super.key,
    required this.selectedNikType,
    required this.nikController,
    required this.isSelfNik,
    required this.canContinue,
    required this.onNikTypeChanged,
    required this.onNikChanged,
    required this.onNext,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _RequiredLabel('Pilih Tipe NIK'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 6,
          children: [
            _RadioOption(
              label: 'Diri sendiri',
              value: 'self',
              groupValue: selectedNikType,
              onChanged: onNikTypeChanged,
            ),
            _RadioOption(
              label: 'Orang lain',
              value: 'other',
              groupValue: selectedNikType,
              onChanged: onNikTypeChanged,
            ),
          ],
        ),
        const SizedBox(height: 18),
        ServiceApplicationLabeledTextField(
          label: 'Masukkan NIK',
          requiredField: true,
          controller: nikController,
          keyboardType: TextInputType.number,
          hintText: 'Masukkan NIK',
          readOnly: isSelfNik,
          enabled: !isSelfNik,
          onChanged: onNikChanged,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: 20),
        ServiceApplicationActions(
          primaryLabel: 'Selanjutnya',
          onPrimaryPressed: canContinue ? onNext : null,
          secondaryLabel: 'Sebelumnya',
          onSecondaryPressed: null,
          cancelLabel: 'Batal',
          onCancelPressed: onCancel,
        ),
      ],
    );
  }
}

class BansosResultStep extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onCancel;

  const BansosResultStep({
    super.key,
    required this.onPrevious,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ServiceApplicationInformationBanner(
          message:
          'Data yang ditampilkan adalah data resmi dari sistem '
              'bantuan sosial. Untuk informasi lebih lanjut, hubungi '
              'dinas sosial setempat.',
        ),
        const SizedBox(height: 22),
        const _PersonalInformationCard(),
        const SizedBox(height: 24),
        const _BenefitProgramList(),
        const SizedBox(height: 22),
        ServiceApplicationActions(
          primaryLabel: 'Selanjutnya',
          onPrimaryPressed: null,
          secondaryLabel: 'Sebelumnya',
          onSecondaryPressed: onPrevious,
          cancelLabel: 'Batal',
          onCancelPressed: onCancel,
        ),
      ],
    );
  }
}

class _PersonalInformationCard extends StatelessWidget {
  const _PersonalInformationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE5E5E5),
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Informasi Pribadi',
            style: TextStyle(
              color: Color(0xFF252525),
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 14),
          Wrap(
            spacing: 16,
            runSpacing: 13,
            children: [
              _InfoItem(
                label: 'Nama Lengkap',
                value: 'Ahmad Andrawan',
              ),
              _DesilItem(),
              _InfoItem(
                label: 'Provinsi',
                value: 'DKI Jakarta',
              ),
              _InfoItem(
                label: 'Kabupaten/Kota',
                value: 'Jakarta Selatan',
              ),
              _InfoItem(
                label: 'Kecamatan',
                value: 'Pancoran',
              ),
              _InfoItem(
                label: 'Kelurahan',
                value: 'Pancoran',
              ),
            ],
          ),
          SizedBox(height: 16),
          _DesilNoteCard(),
        ],
      ),
    );
  }
}

class _BenefitProgramList extends StatelessWidget {
  const _BenefitProgramList();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _BenefitProgramCard(
          title: 'Program Keluarga\nHarapan',
          period: 'Tahap II - 2026',
          status: 'Aktif',
          isActive: true,
          children: [
            SizedBox(height: 16),
            Text(
              'Komponen Bantuan PKH',
              style: TextStyle(
                color: Color(0xFF062F5E),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            _ComponentTile(
              title: 'Ibu Hamil/Menyusui',
              subtitle: '1 Orang',
            ),
            SizedBox(height: 6),
            _ComponentTile(
              title: 'Anak SD/Sederajat',
              subtitle: '1 Orang',
            ),
            SizedBox(height: 6),
            _ComponentTile(
              title: 'Anak SLTP/Sederajat',
              subtitle: '1 Orang',
            ),
          ],
        ),
        _ProgramDivider(),
        _BenefitProgramCard(
          title: 'Bantuan Pangan Non\nTunai',
          period: '2026',
          status: 'Aktif',
          isActive: true,
        ),
        _ProgramDivider(),
        _BenefitProgramCard(
          title: 'PBI - Jaminan\nKesehatan',
          period: '2026',
          status: 'Tidak aktif',
          isActive: false,
        ),
        _ProgramDivider(),
        _BenefitProgramCard(
          title: 'Bantuan Langsung\nTunai Sementara',
          period: '2026',
          status: 'Tidak aktif',
          isActive: false,
        ),
      ],
    );
  }
}

class _BenefitProgramCard extends StatelessWidget {
  final String title;
  final String period;
  final String status;
  final bool isActive;
  final List<Widget> children;

  const _BenefitProgramCard({
    required this.title,
    required this.period,
    required this.status,
    required this.isActive,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF062F5E),
                      fontSize: 16,
                      height: 1.25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    period,
                    style: const TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _StatusBadge(
              label: status,
              isActive: isActive,
            ),
          ],
        ),
        ...children,
      ],
    );
  }
}

class _RequiredLabel extends StatelessWidget {
  final String text;

  const _RequiredLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(text: text),
          const TextSpan(
            text: ' *',
            style: TextStyle(
              color: Color(0xFFE33B3B),
            ),
          ),
        ],
      ),
    );
  }
}

class _RadioOption extends StatelessWidget {
  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const _RadioOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: (newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
            activeColor: const Color(0xFF111111),
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 132,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF999999),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF252525),
              fontSize: 14,
              height: 1.25,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _DesilItem extends StatelessWidget {
  const _DesilItem();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 132,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Desil',
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 3),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE5E7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Desil 2',
              style: TextStyle(
                color: Color(0xFFE23B4E),
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DesilNoteCard extends StatelessWidget {
  const _DesilNoteCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border.all(
          color: const Color(0xFFBDBDBD),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.help_outline,
            size: 18,
            color: Color(0xFF444444),
          ),
          SizedBox(width: 9),
          Expanded(
            child: Text(
              'Desil digunakan dalam mengukur tingkat kesejahteraan '
                  'keluarga untuk penentuan bantuan. Desil 1-4 merupakan '
                  'prioritas utama penerima bansos.',
              style: TextStyle(
                color: Color(0xFF444444),
                fontSize: 12,
                height: 1.35,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final bool isActive;

  const _StatusBadge({
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFFE8FBEA)
            : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive
              ? const Color(0xFF2C9142)
              : const Color(0xFF555555),
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _ComponentTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const _ComponentTile({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF062F5E),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF999999),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgramDivider extends StatelessWidget {
  const _ProgramDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 18),
      child: Divider(
        height: 1,
        thickness: 0.6,
        color: Color(0xFFE4E4E4),
      ),
    );
  }
}