import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'service_application_common_widgets.dart';

class BpjsParticipantStatusCard extends StatelessWidget {
  final String name;
  final String participantNumber;
  final String membershipType;
  final String group;
  final String primaryFacility;

  const BpjsParticipantStatusCard({
    super.key,
    required this.name,
    required this.participantNumber,
    required this.membershipType,
    required this.group,
    required this.primaryFacility,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFFFB),
        border: Border.all(
          color: const Color(0xFF41A654),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE5F7E8),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                'Aktif',
                style: TextStyle(
                  color: Color(0xFF2E9442),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 13),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ParticipantAvatar(),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color(0xFF062F5E),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            participantNumber,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF777777),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: participantNumber,
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Nomor peserta berhasil disalin',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(4),
                          child: const Padding(
                            padding: EdgeInsets.all(2),
                            child: Icon(
                              Icons.copy_outlined,
                              size: 15,
                              color: Color(0xFF062F5E),
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
          const SizedBox(height: 13),
          _ParticipantInformation(
            label: 'Tipe Kepesertaan',
            value: membershipType,
          ),
          const SizedBox(height: 11),
          _ParticipantInformation(
            label: 'Kelompok',
            value: group,
          ),
          const SizedBox(height: 11),
          _ParticipantInformation(
            label: 'Faskes Umum',
            value: primaryFacility,
          ),
        ],
      ),
    );
  }
}

class BpjsFamilyMemberCard extends StatelessWidget {
  final String name;
  final bool isComplete;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BpjsFamilyMemberCard({
    super.key,
    required this.name,
    required this.isComplete,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final statusText = isComplete
        ? 'Data sudah lengkap'
        : 'Data belum lengkap';

    final statusColor = isComplete
        ? const Color(0xFF1267ED)
        : const Color(0xFF9A6A00);

    final statusBackground = isComplete
        ? const Color(0xFFEAF2FF)
        : const Color(0xFFFFF3D7);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE2E2E2),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const _ParticipantAvatar(),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF062F5E),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: statusBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton.icon(
            onPressed: onEdit,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF333333),
              side: const BorderSide(
                color: Color(0xFFE2E2E2),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 9,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            icon: const Icon(
              Icons.edit_outlined,
              size: 14,
            ),
            label: Text(
              isComplete ? 'Ubah' : 'Lengkapi',
            ),
          ),
          const SizedBox(width: 7),
          SizedBox(
            width: 38,
            height: 38,
            child: OutlinedButton(
              onPressed: onDelete,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFFF3B3B),
                side: const BorderSide(
                  color: Color(0xFFE2E2E2),
                ),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: const Icon(
                Icons.delete_outline,
                size: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BpjsAddParticipantButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BpjsAddParticipantButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF062F5E),
          backgroundColor: const Color(0xFFFCFCFC),
          side: const BorderSide(
            color: Color(0xFFE3E3E3),
            style: BorderStyle.solid,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        icon: const Icon(
          Icons.add,
          size: 19,
        ),
        label: const Text(
          'Tambah peserta baru',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class BpjsParticipantFormCard extends StatelessWidget {
  final TextEditingController nikController;
  final TextEditingController nameController;
  final TextEditingController birthPlaceController;
  final TextEditingController birthDateController;
  final String selectedGender;
  final String? selectedMaritalStatus;
  final String? selectedRelationship;
  final VoidCallback onBirthDateTap;
  final ValueChanged<String> onGenderChanged;
  final ValueChanged<String?> onMaritalStatusChanged;
  final ValueChanged<String?> onRelationshipChanged;

  const BpjsParticipantFormCard({
    super.key,
    required this.nikController,
    required this.nameController,
    required this.birthPlaceController,
    required this.birthDateController,
    required this.selectedGender,
    required this.selectedMaritalStatus,
    required this.selectedRelationship,
    required this.onBirthDateTap,
    required this.onGenderChanged,
    required this.onMaritalStatusChanged,
    required this.onRelationshipChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE0E0E0),
        ),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Peserta Baru - 1',
            style: TextStyle(
              color: Color(0xFF252525),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
          ServiceApplicationLabeledTextField(
            label: 'NIK Peserta',
            requiredField: true,
            controller: nikController,
            keyboardType: TextInputType.number,
            hintText: 'Masukkan NIK',
          ),
          const SizedBox(height: 15),
          ServiceApplicationLabeledTextField(
            label: 'Nama Lengkap Peserta Baru',
            requiredField: true,
            controller: nameController,
            hintText: 'Masukkan nama lengkap',
          ),
          const SizedBox(height: 15),
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 330;

              if (compact) {
                return Column(
                  children: [
                    ServiceApplicationLabeledTextField(
                      label: 'Tempat Lahir Peserta',
                      requiredField: true,
                      controller: birthPlaceController,
                      hintText: 'Pilih tempat lahir',
                    ),
                    const SizedBox(height: 15),
                    ServiceApplicationLabeledTextField(
                      label: 'Tanggal Lahir Peserta',
                      requiredField: true,
                      controller: birthDateController,
                      hintText: 'Pilih tanggal lahir',
                      readOnly: true,
                      onTap: onBirthDateTap,
                      suffixIcon: const Icon(
                        Icons.calendar_today_outlined,
                        size: 17,
                      ),
                    ),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ServiceApplicationLabeledTextField(
                      label: 'Tempat Lahir Peserta',
                      requiredField: true,
                      controller: birthPlaceController,
                      hintText: 'Pilih tempat lahir',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ServiceApplicationLabeledTextField(
                      label: 'Tanggal Lahir Peserta',
                      requiredField: true,
                      controller: birthDateController,
                      hintText: 'Pilih tanggal lahir',
                      readOnly: true,
                      onTap: onBirthDateTap,
                      suffixIcon: const Icon(
                        Icons.calendar_today_outlined,
                        size: 17,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 15),
          const _FieldLabel(
            label: 'Jenis Kelamin Peserta',
            requiredField: true,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _GenderOption(
                label: 'Laki-Laki',
                value: 'Laki-Laki',
                groupValue: selectedGender,
                onChanged: onGenderChanged,
              ),
              _GenderOption(
                label: 'Perempuan',
                value: 'Perempuan',
                groupValue: selectedGender,
                onChanged: onGenderChanged,
              ),
            ],
          ),
          const SizedBox(height: 15),
          ServiceApplicationDropdownField<String>(
            label: 'Status Pernikahan',
            requiredField: true,
            value: selectedMaritalStatus,
            hintText: 'Pilih status',
            items: const [
              DropdownMenuItem(
                value: 'Belum Kawin',
                child: Text('Belum Kawin'),
              ),
              DropdownMenuItem(
                value: 'Kawin',
                child: Text('Kawin'),
              ),
            ],
            onChanged: onMaritalStatusChanged,
          ),
          const SizedBox(height: 15),
          ServiceApplicationDropdownField<String>(
            label: 'Hubungan Dengan Kepala Keluarga',
            requiredField: true,
            value: selectedRelationship,
            hintText: 'Pilih hubungan',
            items: const [
              DropdownMenuItem(
                value: 'Anak',
                child: Text('Anak'),
              ),
              DropdownMenuItem(
                value: 'Istri',
                child: Text('Istri'),
              ),
              DropdownMenuItem(
                value: 'Suami',
                child: Text('Suami'),
              ),
              DropdownMenuItem(
                value: 'Lainnya',
                child: Text('Lainnya'),
              ),
            ],
            onChanged: onRelationshipChanged,
          ),
        ],
      ),
    );
  }
}

class BpjsFacilityInformationCard extends StatelessWidget {
  const BpjsFacilityInformationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border.all(
          color: const Color(0xFFE4E4E4),
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE9EC),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Icon(
                  Icons.local_hospital_outlined,
                  color: Color(0xFFE43D4F),
                  size: 19,
                ),
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
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Klinik Pratama Nusalima',
                      style: TextStyle(
                        color: Color(0xFF062F5E),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          const Row(
            children: [
              Expanded(
                child: _SmallInfo(
                  label: 'Jarak',
                  value: '84 KM',
                ),
              ),
              Expanded(
                child: _SmallInfo(
                  label: 'Jumlah Peserta',
                  value: '73.986',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _SmallInfo(
                  label: 'Alamat',
                  value: 'Jl. Cijerah, No. 72',
                ),
              ),
              Expanded(
                child: _SmallInfo(
                  label: 'No. Telepon',
                  value: '766-87689',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BpjsServiceClassSummary extends StatelessWidget {
  final String monthlyContribution;
  final String familyContribution;

  const BpjsServiceClassSummary({
    super.key,
    required this.monthlyContribution,
    required this.familyContribution,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border.all(
          color: const Color(0xFFE5E5E5),
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SmallInfo(
              label: 'Iuran Perbulan / Orang',
              value: monthlyContribution,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: _SmallInfo(
              label: 'Iuran Satu Keluarga',
              value: familyContribution,
            ),
          ),
        ],
      ),
    );
  }
}

class BpjsContactVerificationField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final String actionLabel;
  final VoidCallback onActionPressed;
  final bool verified;
  final TextInputType keyboardType;

  const BpjsContactVerificationField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.actionLabel,
    required this.onActionPressed,
    required this.verified,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox.shrink(),
        _FieldLabel(
          label: label,
          requiredField: true,
        ),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(
            color: Color(0xFF444444),
            fontSize: 12,
          ),
          decoration: serviceApplicationFieldDecoration(
            hintText: hintText,
            suffixIcon: verified
                ? const Icon(
              Icons.verified,
              size: 19,
              color: Color(0xFF1267ED),
            )
                : TextButton(
              onPressed: onActionPressed,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF1267ED),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                textStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: Text(actionLabel),
            ),
          ),
        ),
      ],
    );
  }
}

class BpjsVirtualAccountCard extends StatelessWidget {
  final String accountNumber;

  const BpjsVirtualAccountCard({
    super.key,
    required this.accountNumber,
  });

  @override
  Widget build(BuildContext context) {
    const banks = [
      'BCA',
      'BRI',
      'BNI',
      'Mandiri',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE0E0E0),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Nomor Virtual Account',
            style: TextStyle(
              color: Color(0xFF252525),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Nomor di bawah ini adalah nomor untuk '
                'melakukan pembayaran iuran bulanan.',
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          for (int index = 0; index < banks.length; index++) ...[
            _VirtualAccountRow(
              bankName: banks[index],
              accountNumber: accountNumber,
            ),
            if (index != banks.length - 1)
              const SizedBox(height: 11),
          ],
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F9FF),
              border: Border.all(
                color: const Color(0xFF216BF3),
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Color(0xFF216BF3),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Nomor virtual account di atas telah dikirimkan '
                            'ke email Anda. Anda juga dapat mengecek nomor '
                            'virtual account melalui aplikasi Mobile JKN.',
                        style: TextStyle(
                          color: Color(0xFF344054),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 9),
                Text(
                  'Unduh Mobile JKN',
                  style: TextStyle(
                    color: Color(0xFF1267ED),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
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

Future<bool?> showBpjsContactVerificationDialog({
  required BuildContext context,
  required String title,
  required String destinationLabel,
  required String maskedDestination,
}) {
  final codeController = TextEditingController();

  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 420,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              16,
              18,
              16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(dialogContext).pop(false);
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: const Padding(
                        padding: EdgeInsets.all(3),
                        child: Icon(
                          Icons.close,
                          size: 22,
                          color: Color(0xFF555555),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Masukkan 6 digit kode verifikasi yang diterima '
                      'pada $destinationLabel',
                  style: const TextStyle(
                    color: Color(0xFF444444),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  maskedDestination,
                  style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: codeController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 6,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: const TextStyle(
                    color: Color(0xFF444444),
                    fontSize: 18,
                    letterSpacing: 4,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: serviceApplicationFieldDecoration(
                    hintText: '000 - 000',
                  ).copyWith(
                    counterText: '',
                  ),
                ),
                const SizedBox(height: 14),
                const Row(
                  children: [
                    Text(
                      'Belum menerima kode?',
                      style: TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Kirim ulang',
                      style: TextStyle(
                        color: Color(0xFF062F5E),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                ServiceApplicationActions(
                  primaryLabel: 'Verifikasi',
                  onPrimaryPressed: () {
                    Navigator.of(dialogContext).pop(true);
                  },
                  secondaryLabel: 'Batal',
                  onSecondaryPressed: () {
                    Navigator.of(dialogContext).pop(false);
                  },
                  cancelLabel: null,
                ),
              ],
            ),
          ),
        ),
      );
    },
  ).whenComplete(codeController.dispose);
}

class _VirtualAccountRow extends StatelessWidget {
  final String bankName;
  final String accountNumber;

  const _VirtualAccountRow({
    required this.bankName,
    required this.accountNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bankName,
          style: const TextStyle(
            color: Color(0xFF777777),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Expanded(
              child: Text(
                accountNumber,
                style: const TextStyle(
                  color: Color(0xFF062F5E),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Clipboard.setData(
                  ClipboardData(
                    text: accountNumber,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Nomor virtual account $bankName berhasil disalin',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              borderRadius: BorderRadius.circular(4),
              child: const Padding(
                padding: EdgeInsets.all(3),
                child: Icon(
                  Icons.copy_outlined,
                  size: 14,
                  color: Color(0xFF062F5E),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ParticipantAvatar extends StatelessWidget {
  const _ParticipantAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(7),
      ),
      child: const Icon(
        Icons.person,
        size: 20,
        color: Color(0xFFE26A2C),
      ),
    );
  }
}

class _ParticipantInformation extends StatelessWidget {
  final String label;
  final String value;

  const _ParticipantInformation({
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
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF062F5E),
            fontSize: 13,
            height: 1.35,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _SmallInfo extends StatelessWidget {
  final String label;
  final String value;

  const _SmallInfo({
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
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF062F5E),
            fontSize: 13,
            height: 1.3,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  final bool requiredField;

  const _FieldLabel({
    required this.label,
    required this.requiredField,
  });

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
          TextSpan(text: label),
          if (requiredField)
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

class _GenderOption extends StatelessWidget {
  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const _GenderOption({
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
      borderRadius: BorderRadius.circular(6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: (selectedValue) {
              if (selectedValue != null) {
                onChanged(selectedValue);
              }
            },
            visualDensity: VisualDensity.compact,
            materialTapTargetSize:
            MaterialTapTargetSize.shrinkWrap,
          ),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}