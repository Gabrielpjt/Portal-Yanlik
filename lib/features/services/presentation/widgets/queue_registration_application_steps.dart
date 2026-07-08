import 'package:flutter/material.dart';

import 'service_application_common_widgets.dart';

class QueueRegistrationFormStep extends StatelessWidget {
  final String? selectedParticipant;
  final String? selectedPolyclinic;
  final String? selectedDoctor;
  final TextEditingController visitDateController;
  final TextEditingController complaintController;
  final ValueChanged<String?> onParticipantChanged;
  final ValueChanged<String?> onPolyclinicChanged;
  final ValueChanged<String?> onDoctorChanged;
  final VoidCallback onDateTap;
  final VoidCallback onNext;
  final VoidCallback onCancel;

  const QueueRegistrationFormStep({
    super.key,
    required this.selectedParticipant,
    required this.selectedPolyclinic,
    required this.selectedDoctor,
    required this.visitDateController,
    required this.complaintController,
    required this.onParticipantChanged,
    required this.onPolyclinicChanged,
    required this.onDoctorChanged,
    required this.onDateTap,
    required this.onNext,
    required this.onCancel,
  });

  bool get _hasParticipant => selectedParticipant != null;

  bool get _hasVisitDate {
    return visitDateController.text.trim().isNotEmpty;
  }

  bool get _canSelectDoctor {
    return _hasParticipant &&
        selectedPolyclinic != null &&
        _hasVisitDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ServiceApplicationDropdownField<String>(
          label: 'Peserta',
          requiredField: true,
          value: selectedParticipant,
          hintText: 'Pilih peserta',
          items: const [
            DropdownMenuItem(
              value: 'Iwan Nur Setiyawan',
              child: Text('Iwan Nur Setiyawan'),
            ),
          ],
          onChanged: onParticipantChanged,
        ),
        if (_hasParticipant) ...[
          const SizedBox(height: 10),
          const _QueueFacilityCard(),
        ],
        const SizedBox(height: 14),
        ServiceApplicationDropdownField<String>(
          label: 'Poli',
          requiredField: true,
          value: selectedPolyclinic,
          hintText: 'Pilih poli',
          enabled: _hasParticipant,
          items: const [
            DropdownMenuItem(
              value: 'Poli Umum',
              child: Text('Poli Umum'),
            ),
          ],
          onChanged: onPolyclinicChanged,
        ),
        const SizedBox(height: 14),
        ServiceApplicationLabeledTextField(
          label: 'Tanggal Kunjungan',
          requiredField: true,
          controller: visitDateController,
          hintText: 'Pilih tanggal kunjungan',
          readOnly: true,
          enabled: _hasParticipant,
          onTap: _hasParticipant ? onDateTap : null,
          suffixIcon: const Icon(
            Icons.calendar_today_outlined,
            size: 17,
          ),
        ),
        const SizedBox(height: 14),
        ServiceApplicationDropdownField<String>(
          label: 'Jadwal dan Tenaga Medis',
          requiredField: true,
          value: selectedDoctor,
          hintText: 'Pilih jadwal dan tenaga medis',
          enabled: _canSelectDoctor,
          items: const [
            DropdownMenuItem(
              value: 'Hafizur Rahman',
              child: Text('Hafizur Rahman'),
            ),
          ],
          onChanged: onDoctorChanged,
        ),
        if (selectedDoctor != null) ...[
          const SizedBox(height: 10),
          const _QueueDoctorCard(),
        ],
        const SizedBox(height: 14),
        ServiceApplicationLabeledTextField(
          label: 'Keluhan',
          requiredField: true,
          controller: complaintController,
          hintText: 'Masukkan keluhan',
          maxLines: 5,
          textInputAction: TextInputAction.newline,
        ),
        const SizedBox(height: 18),
        ServiceApplicationActions(
          primaryLabel: 'Selanjutnya',
          onPrimaryPressed: onNext,
          secondaryLabel: 'Sebelumnya',
          onSecondaryPressed: null,
          cancelLabel: 'Batal',
          onCancelPressed: onCancel,
        ),
      ],
    );
  }
}

class QueueIssuedView extends StatelessWidget {
  final String queueNumber;
  final String remainingQueue;
  final String servedParticipants;
  final String estimatedWaitingTime;
  final String visitDate;
  final String complaint;
  final VoidCallback onCancelQueue;
  final VoidCallback? onMapTap;
  final VoidCallback? onContactTap;

  const QueueIssuedView({
    super.key,
    required this.queueNumber,
    required this.remainingQueue,
    required this.servedParticipants,
    required this.estimatedWaitingTime,
    required this.visitDate,
    required this.complaint,
    required this.onCancelQueue,
    this.onMapTap,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _QueueSuccessBanner(),
        const SizedBox(height: 16),
        _QueueTicketCard(
          queueNumber: queueNumber,
          remainingQueue: remainingQueue,
          servedParticipants: servedParticipants,
          estimatedWaitingTime: estimatedWaitingTime,
          visitDate: visitDate,
          complaint: complaint,
          onMapTap: onMapTap,
          onContactTap: onContactTap,
        ),
        const SizedBox(height: 16),
        ServiceApplicationActions(
          primaryLabel: 'Batalkan',
          onPrimaryPressed: onCancelQueue,
          secondaryLabel: null,
          cancelLabel: null,
        ),
      ],
    );
  }
}

class QueueCancellationSummary extends StatelessWidget {
  final String queueNumber;
  final String visitDate;
  final String complaint;

  const QueueCancellationSummary({
    super.key,
    required this.queueNumber,
    required this.visitDate,
    required this.complaint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Apakah Anda ingin membatalkan antrean ini?',
          style: TextStyle(
            color: Color(0xFF444444),
            fontSize: 14,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            border: Border.all(
              color: const Color(0xFFE5E5E5),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _QueueSummaryItem(
                label: 'Poli',
                value: 'Umum',
              ),
              const SizedBox(height: 10),
              const _QueueSummaryItem(
                label: 'Tenaga Medis',
                value: 'Hafizur Rahman',
                secondaryValue: '08:00 - 16:00 WIB • Buka',
                secondaryValueColor: Color(0xFF2C9142),
              ),
              const SizedBox(height: 10),
              _QueueSummaryItem(
                label: 'Keluhan',
                value: complaint,
              ),
              const SizedBox(height: 10),
              _QueueSummaryItem(
                label: 'No. Antrean',
                value: queueNumber,
              ),
              const SizedBox(height: 10),
              _QueueSummaryItem(
                label: 'Tanggal Kunjungan',
                value: visitDate,
              ),
              const SizedBox(height: 10),
              const _QueueSummaryItem(
                label: 'Faskes Tingkat Pertama',
                value: 'Klinik Pratama Nusalima',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class QueueCancelledView extends StatelessWidget {
  final VoidCallback onRegisterAgain;

  const QueueCancelledView({
    super.key,
    required this.onRegisterAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFDADADA),
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              22,
              28,
              22,
              22,
            ),
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFFE8E8),
                  ),
                  child: const Icon(
                    Icons.event_busy_outlined,
                    color: Color(0xFFFF3B3B),
                    size: 36,
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Antrean Telah Dibatalkan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF252525),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Antrean Anda sebelumnya telah dibatalkan, '
                      'dan Anda dapat mendaftar kembali untuk '
                      'mendapatkan nomor antrean baru.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const _DashedDivider(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ServiceApplicationActions(
              primaryLabel: 'Daftar antrean baru',
              onPrimaryPressed: onRegisterAgain,
              secondaryLabel: null,
              cancelLabel: null,
            ),
          ),
        ],
      ),
    );
  }
}

class _QueueFacilityCard extends StatelessWidget {
  const _QueueFacilityCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border.all(
          color: const Color(0xFFE3E3E3),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconBox(
                icon: Icons.local_hospital_outlined,
                iconColor: Color(0xFFE43D4F),
                backgroundColor: Color(0xFFFFE9EC),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Faskes Tingkat Pertama',
                      style: TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Klinik Pratama Nusalima',
                      style: TextStyle(
                        color: Color(0xFF062F5E),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: _QueueSmallInformation(
                  label: 'Alamat',
                  value: 'Jalan Cemara...',
                  trailingIcon: Icons.arrow_outward,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _QueueSmallInformation(
                  label: 'No. Telepon',
                  value: '0761-2674',
                  trailingIcon: Icons.phone_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QueueDoctorCard extends StatelessWidget {
  const _QueueDoctorCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border.all(
          color: const Color(0xFFE3E3E3),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconBox(
                icon: Icons.medical_services_outlined,
                iconColor: Color(0xFF2878D4),
                backgroundColor: Color(0xFFEAF3FF),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tenaga Medis',
                      style: TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Dr. Hafizur Rahman',
                      style: TextStyle(
                        color: Color(0xFF062F5E),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                child: _QueueSmallInformation(
                  label: 'Jadwal',
                  value: '08:00 - 14:00 WIB',
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C9142),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Buka',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QueueSuccessBanner extends StatelessWidget {
  const _QueueSuccessBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1FFF1),
        border: Border.all(
          color: const Color(0xFF4DAA5D),
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Color(0xFF2C9142),
            size: 18,
          ),
          SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat!',
                  style: TextStyle(
                    color: Color(0xFF252525),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Data Anda telah diverifikasi dan nomor antrean '
                      'telah terbit.',
                  style: TextStyle(
                    color: Color(0xFF444444),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
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
}

class _QueueTicketCard extends StatelessWidget {
  final String queueNumber;
  final String remainingQueue;
  final String servedParticipants;
  final String estimatedWaitingTime;
  final String visitDate;
  final String complaint;
  final VoidCallback? onMapTap;
  final VoidCallback? onContactTap;

  const _QueueTicketCard({
    required this.queueNumber,
    required this.remainingQueue,
    required this.servedParticipants,
    required this.estimatedWaitingTime,
    required this.visitDate,
    required this.complaint,
    required this.onMapTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFD6D6D6),
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              14,
              16,
              14,
              14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Nomor Antrean',
                  style: TextStyle(
                    color: Color(0xFF252525),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  queueNumber,
                  style: const TextStyle(
                    color: Color(0xFF1267ED),
                    fontSize: 64,
                    height: 1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _QueueStat(
                        label: 'Sisa Antrean',
                        value: remainingQueue,
                      ),
                    ),
                    Expanded(
                      child: _QueueStat(
                        label: 'Peserta Dilayani',
                        value: servedParticipants,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _QueueStat(
                  label: 'Estimasi Waktu Tunggu',
                  value: estimatedWaitingTime,
                ),
              ],
            ),
          ),
          const _DashedDivider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              14,
              16,
              14,
              14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Detail Kunjungan',
                  style: TextStyle(
                    color: Color(0xFF252525),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _QueueDetailItem(
                        label: 'Tanggal Kunjungan',
                        value: visitDate,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: _QueueDetailItem(
                        label: 'Faskes Tingkat Pertama',
                        value: 'Klinik Pratama Nusalima',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _QueueDetailItem(
                        label: 'Poli',
                        value: 'Umum',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _QueueDetailItem(
                        label: 'Tenaga Medis',
                        value: 'Hafizur Rahman',
                        secondaryValue: '08:00 - 16:00 WIB • Buka',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _QueueDetailItem(
                  label: 'Keluhan',
                  value: complaint,
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onMapTap,
                        style: _smallOutlinedButtonStyle(),
                        icon: const Icon(
                          Icons.location_on_outlined,
                          size: 17,
                        ),
                        label: const Text(
                          'Lihat peta',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onContactTap,
                        style: _smallOutlinedButtonStyle(),
                        icon: const Icon(
                          Icons.phone_outlined,
                          size: 17,
                        ),
                        label: const Text(
                          'Hubungi',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ButtonStyle _smallOutlinedButtonStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF062F5E),
      side: const BorderSide(
        color: Color(0xFFE0E0E0),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 11,
      ),
      textStyle: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

class _QueueStat extends StatelessWidget {
  final String label;
  final String value;

  const _QueueStat({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF888888),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF062F5E),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _QueueDetailItem extends StatelessWidget {
  final String label;
  final String value;
  final String? secondaryValue;

  const _QueueDetailItem({
    required this.label,
    required this.value,
    this.secondaryValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF888888),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF062F5E),
            fontSize: 13,
            height: 1.3,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (secondaryValue != null) ...[
          const SizedBox(height: 2),
          Text(
            secondaryValue!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF777777),
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}

class _QueueSummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final String? secondaryValue;
  final Color? secondaryValueColor;

  const _QueueSummaryItem({
    required this.label,
    required this.value,
    this.secondaryValue,
    this.secondaryValueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF888888),
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF062F5E),
            fontSize: 16,
            height: 1.3,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (secondaryValue != null) ...[
          const SizedBox(height: 2),
          Text(
            secondaryValue!,
            style: TextStyle(
              color: secondaryValueColor ??
                  const Color(0xFF777777),
              fontSize: 14,
            ),
          ),
        ],
      ],
    );
  }
}

class _QueueSmallInformation extends StatelessWidget {
  final String label;
  final String value;
  final IconData? trailingIcon;

  const _QueueSmallInformation({
    required this.label,
    required this.value,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF888888),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF062F5E),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: 4),
              Icon(
                trailingIcon,
                size: 14,
                color: const Color(0xFF062F5E),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _IconBox extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const _IconBox({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: 19,
      ),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 5.0;
        const gapWidth = 4.0;
        final count =
        (constraints.maxWidth / (dashWidth + gapWidth))
            .floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            count,
                (_) => const SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFD4D4D4),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
