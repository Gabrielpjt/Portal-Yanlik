import 'package:flutter/material.dart';
import 'service_application_common_widgets.dart';

class BirthCertificateDocumentStep extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onCancel;

  const BirthCertificateDocumentStep({
    super.key,
    required this.onNext,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ServiceApplicationInformationBanner(
          richMessage: TextSpan(
            children: [
              TextSpan(
                text: 'Pastikan seluruh dokumen di bawah ini ',
              ),
              TextSpan(
                text: 'tervalidasi',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: ' sebelum melanjutkan.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const ServiceApplicationDocumentValidationCard(
          title: 'Kartu Keluarga',
          category: 'Kependudukan',
          documentNumber: '3***********38',
        ),
        const SizedBox(height: 12),
        const ServiceApplicationDocumentValidationCard(
          title: 'Akta Perkawinan',
          category: 'Lainnya',
          documentNumber: 'AK-5**-*******97',
        ),
        const SizedBox(height: 12),
        const ServiceApplicationDocumentValidationCard(
          title: 'Surat Keterangan Lahir',
          category: 'Kependudukan',
          documentNumber: '331/RSU/SKL/IV/2026',
        ),
        const SizedBox(height: 18),
        ServiceApplicationActions(
          primaryLabel: 'Selanjutnya',
          onPrimaryPressed: onNext,
          onSecondaryPressed: null,
          onCancelPressed: onCancel,
        ),
      ],
    );
  }
}

class BirthCertificateBirthDataStep extends StatelessWidget {
  final TextEditingController childNameController;
  final TextEditingController childOrderController;
  final TextEditingController birthPlaceController;
  final TextEditingController birthDateController;
  final TextEditingController birthTimeController;
  final TextEditingController birthWeightController;
  final TextEditingController birthLengthController;

  final String selectedGender;
  final String selectedBirthType;
  final String selectedBirthPlaceType;
  final List<String> selectedBirthAssistants;

  final ValueChanged<String> onGenderChanged;
  final ValueChanged<String> onBirthTypeChanged;
  final ValueChanged<String> onBirthPlaceTypeChanged;
  final ValueChanged<List<String>> onBirthAssistantsChanged;

  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onCancel;

  const BirthCertificateBirthDataStep({
    super.key,
    required this.childNameController,
    required this.childOrderController,
    required this.birthPlaceController,
    required this.birthDateController,
    required this.birthTimeController,
    required this.birthWeightController,
    required this.birthLengthController,
    required this.selectedGender,
    required this.selectedBirthType,
    required this.selectedBirthPlaceType,
    required this.selectedBirthAssistants,
    required this.onGenderChanged,
    required this.onBirthTypeChanged,
    required this.onBirthPlaceTypeChanged,
    required this.onBirthAssistantsChanged,
    required this.onNext,
    required this.onPrevious,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ServiceApplicationInformationBanner(
          message: 'Pastikan data anak telah sesuai.',
        ),
        const SizedBox(height: 20),

        const ServiceApplicationSubsectionTitle(
          title: 'Identitas Anak',
        ),
        const SizedBox(height: 15),

        ServiceApplicationLabeledTextField(
          label: 'Nama Lengkap',
          requiredField: true,
          controller: childNameController,
        ),
        const SizedBox(height: 14),

        ServiceApplicationDropdownField<String>(
          label: 'Jenis Kelamin',
          value: selectedGender,
          items: const [
            DropdownMenuItem(
              value: 'Laki-laki',
              child: Text('Laki-Laki'),
            ),
            DropdownMenuItem(
              value: 'Perempuan',
              child: Text('Perempuan'),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              onGenderChanged(value);
            }
          },
        ),
        const SizedBox(height: 14),

        ServiceApplicationLabeledTextField(
          label: 'Anak Ke',
          requiredField: true,
          controller: childOrderController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 22),

        const ServiceApplicationSubsectionTitle(
          title: 'Data Kelahiran',
        ),
        const SizedBox(height: 15),

        ServiceApplicationLabeledTextField(
          label: 'Hari dan Tanggal Lahir',
          requiredField: true,
          controller: birthDateController,
          suffixIcon: const Icon(
            Icons.calendar_today_outlined,
            size: 18,
            color: Color(0xFFA7A7A7),
          ),
        ),
        const SizedBox(height: 14),

        ServiceApplicationLabeledTextField(
          label: 'Waktu Kelahiran',
          requiredField: true,
          controller: birthTimeController,
          suffixIcon: const Icon(
            Icons.access_time_rounded,
            size: 20,
            color: Color(0xFFA7A7A7),
          ),
        ),
        const SizedBox(height: 14),

        ServiceApplicationLabeledTextField(
          label: 'Tempat Kelahiran',
          requiredField: true,
          controller: birthPlaceController,
          suffixIcon: const Icon(
            Icons.search_rounded,
            size: 22,
            color: Color(0xFFA7A7A7),
          ),
        ),
        const SizedBox(height: 14),

        ServiceApplicationDropdownField<String>(
          label: 'Tempat Dilahirkan',
          value: selectedBirthPlaceType,
          items: const [
            DropdownMenuItem(
              value: 'Rumah Sakit / Rumah Bersalin',
              child: Text('Rumah Sakit / Rumah Bersalin'),
            ),
            DropdownMenuItem(
              value: 'Puskesmas',
              child: Text('Puskesmas'),
            ),
            DropdownMenuItem(
              value: 'Klinik',
              child: Text('Klinik'),
            ),
            DropdownMenuItem(
              value: 'Rumah',
              child: Text('Rumah'),
            ),
            DropdownMenuItem(
              value: 'Lainnya',
              child: Text('Lainnya'),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              onBirthPlaceTypeChanged(value);
            }
          },
        ),
        const SizedBox(height: 22),

        const ServiceApplicationSubsectionTitle(
          title: 'Catatan Medis',
        ),
        const SizedBox(height: 15),

        ServiceApplicationDropdownField<String>(
          label: 'Jenis Kelahiran',
          value: selectedBirthType,
          items: const [
            DropdownMenuItem(
              value: 'Tunggal',
              child: Text('Tunggal'),
            ),
            DropdownMenuItem(
              value: 'Kembar',
              child: Text('Kembar'),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              onBirthTypeChanged(value);
            }
          },
        ),
        const SizedBox(height: 14),

        _BirthAssistantField(
          label: 'Penolong Kelahiran',
          selectedValues: selectedBirthAssistants,
          onChanged: onBirthAssistantsChanged,
        ),
        const SizedBox(height: 14),

        ServiceApplicationLabeledTextField(
          label: 'Berat Badan',
          requiredField: true,
          controller: birthWeightController,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          suffixText: 'kg',
        ),
        const SizedBox(height: 14),

        ServiceApplicationLabeledTextField(
          label: 'Panjang Badan',
          requiredField: true,
          controller: birthLengthController,
          keyboardType: TextInputType.number,
          suffixText: 'cm',
        ),
        const SizedBox(height: 18),

        ServiceApplicationActions(
          primaryLabel: 'Selanjutnya',
          onPrimaryPressed: onNext,
          onSecondaryPressed: onPrevious,
          onCancelPressed: onCancel,
        ),
      ],
    );
  }
}

class _BirthAssistantField extends StatelessWidget {
  final String label;
  final List<String> selectedValues;
  final ValueChanged<List<String>> onChanged;

  const _BirthAssistantField({
    required this.label,
    required this.selectedValues,
    required this.onChanged,
  });

  static const List<String> _options = [
    'Dokter',
    'Bidan',
  ];

  Future<void> _showPicker(BuildContext context) async {
    final temporaryValues = List<String>.from(selectedValues);

    final result = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Pilih Penolong Kelahiran',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._options.map((option) {
                      final isSelected =
                      temporaryValues.contains(option);

                      return CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: isSelected,
                        title: Text(option),
                        controlAffinity:
                        ListTileControlAffinity.leading,
                        onChanged: (value) {
                          setModalState(() {
                            if (value == true) {
                              temporaryValues.add(option);
                            } else {
                              temporaryValues.remove(option);
                            }
                          });
                        },
                      );
                    }),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(temporaryValues);
                        },
                        child: const Text('Simpan'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (result != null) {
      onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333),
                ),
              ),
              const TextSpan(
                text: ' *',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFF4D4F),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => _showPicker(context),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              minHeight: 40,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFE2E2E2),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: selectedValues.isEmpty
                      ? const Text(
                    'Pilih penolong kelahiran',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF999999),
                    ),
                  )
                      : Wrap(
                    spacing: 6,
                    runSpacing: 5,
                    children: selectedValues.map((value) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFE0E0E0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              value,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF999999),
                              ),
                            ),
                            const SizedBox(width: 3),
                            const Icon(
                              Icons.check_rounded,
                              size: 12,
                              color: Color(0xFFB2B2B2),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: Color(0xFFA7A7A7),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BirthCertificateWitnessStep extends StatelessWidget {
  final TextEditingController firstWitnessNikController;
  final TextEditingController secondWitnessNikController;
  final VoidCallback onValidateSecondWitness;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onCancel;

  const BirthCertificateWitnessStep({
    super.key,
    required this.firstWitnessNikController,
    required this.secondWitnessNikController,
    required this.onValidateSecondWitness,
    required this.onNext,
    required this.onPrevious,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ServiceApplicationInformationBanner(
          message: 'Pastikan kedua saksi valid.',
        ),
        const SizedBox(height: 20),
        const ServiceApplicationSubsectionTitle(
          title: 'Saksi Pertama',
        ),
        const SizedBox(height: 15),
        ServiceApplicationLabeledTextField(
          label: 'NIK Saksi Pertama',
          requiredField: true,
          controller: firstWitnessNikController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        const ServiceApplicationPersonValidationCard(
          name: 'Dr. Idham Arhadian',
          familyNumber: '3***********38',
        ),
        const SizedBox(height: 22),
        const ServiceApplicationSubsectionTitle(
          title: 'Saksi Kedua',
        ),
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ServiceApplicationLabeledTextField(
                label: 'NIK Saksi Kedua',
                requiredField: true,
                controller: secondWitnessNikController,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 44,
              child: OutlinedButton(
                onPressed: onValidateSecondWitness,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF062F5E),
                  side: const BorderSide(
                    color: Color(0xFFD8DDE3),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  'Cek validitas',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const ServiceApplicationPersonValidationCard(
          name: 'Suster Nining Wijaya...',
          familyNumber: '3***********38',
        ),
        const SizedBox(height: 18),
        ServiceApplicationActions(
          primaryLabel: 'Selanjutnya',
          onPrimaryPressed: onNext,
          onSecondaryPressed: onPrevious,
          onCancelPressed: onCancel,
        ),
      ],
    );
  }
}

class BirthCertificateSummaryStep extends StatelessWidget {
  final String childName;
  final String gender;
  final String birthDate;
  final String birthTime;
  final String birthPlace;
  final String birthType;
  final String birthWeight;
  final String birthLength;
  final VoidCallback onSubmit;
  final VoidCallback onPrevious;
  final VoidCallback onCancel;

  const BirthCertificateSummaryStep({
    super.key,
    required this.childName,
    required this.gender,
    required this.birthDate,
    required this.birthTime,
    required this.birthPlace,
    required this.birthType,
    required this.birthWeight,
    required this.birthLength,
    required this.onSubmit,
    required this.onPrevious,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ServiceApplicationSummaryGroup(
          title: 'Data Ayah',
          rows: [
            ServiceApplicationSummaryData(
              label: 'Nama',
              value: 'Ahmad Ardhawan',
            ),
            ServiceApplicationSummaryData(
              label: 'NIK',
              value: '3***********38',
            ),
            ServiceApplicationSummaryData(
              label: 'Tempat Lahir',
              value: 'Jakarta',
            ),
            ServiceApplicationSummaryData(
              label: 'Tanggal Lahir',
              value: '20 Jan 1990',
            ),
            ServiceApplicationSummaryData(
              label: 'Kewarganegaraan',
              value: 'Indonesia',
            ),
          ],
        ),
        const SizedBox(height: 12),
        const ServiceApplicationSummaryGroup(
          title: 'Data Ibu',
          rows: [
            ServiceApplicationSummaryData(
              label: 'Nama',
              value: 'Karlina Maheira',
            ),
            ServiceApplicationSummaryData(
              label: 'NIK',
              value: '3***********38',
            ),
            ServiceApplicationSummaryData(
              label: 'Tempat Lahir',
              value: 'Jakarta',
            ),
            ServiceApplicationSummaryData(
              label: 'Tanggal Lahir',
              value: '20 Jan 1990',
            ),
            ServiceApplicationSummaryData(
              label: 'Kewarganegaraan',
              value: 'Indonesia',
            ),
          ],
        ),
        const SizedBox(height: 12),
        ServiceApplicationSummaryGroup(
          title: 'Identitas Anak',
          rows: [
            ServiceApplicationSummaryData(
              label: 'Nama',
              value: childName,
            ),
            ServiceApplicationSummaryData(
              label: 'Jenis Kelamin',
              value: gender,
            ),
            const ServiceApplicationSummaryData(
              label: 'Anak Ke-',
              value: '2',
            ),
          ],
        ),
        const SizedBox(height: 12),
        ServiceApplicationSummaryGroup(
          title: 'Data Kelahiran',
          rows: [
            ServiceApplicationSummaryData(
              label: 'Hari dan Tanggal Lahir',
              value: birthDate,
            ),
            ServiceApplicationSummaryData(
              label: 'Waktu',
              value: birthTime,
            ),
            ServiceApplicationSummaryData(
              label: 'Tempat Kelahiran',
              value: birthPlace,
            ),
            const ServiceApplicationSummaryData(
              label: 'Tempat Dilahirkan',
              value: 'Rumah Sakit / Rumah Bersalin',
            ),
          ],
        ),
        const SizedBox(height: 12),
        ServiceApplicationSummaryGroup(
          title: 'Catatan Medis',
          rows: [
            ServiceApplicationSummaryData(
              label: 'Jenis Kelahiran',
              value: birthType,
            ),
            const ServiceApplicationSummaryData(
              label: 'Penolong Kelahiran',
              value: 'Dokter, Bidan',
            ),
            ServiceApplicationSummaryData(
              label: 'Berat Badan',
              value: '$birthWeight kg',
            ),
            ServiceApplicationSummaryData(
              label: 'Panjang Badan',
              value: '$birthLength cm',
            ),
          ],
        ),
        const SizedBox(height: 12),
        const ServiceApplicationSummaryGroup(
          title: 'Data Saksi Pertama',
          rows: [
            ServiceApplicationSummaryData(
              label: 'Nama',
              value: 'Dr. Idham Arhadian',
            ),
            ServiceApplicationSummaryData(
              label: 'No. Kartu Keluarga',
              value: '3***********38',
            ),
            ServiceApplicationSummaryData(
              label: 'Kewarganegaraan',
              value: 'Indonesia',
            ),
          ],
        ),
        const SizedBox(height: 12),
        const ServiceApplicationSummaryGroup(
          title: 'Data Saksi Kedua',
          rows: [
            ServiceApplicationSummaryData(
              label: 'Nama',
              value: 'Suster Nining Wijaya...',
            ),
            ServiceApplicationSummaryData(
              label: 'No. Kartu Keluarga',
              value: '3***********38',
            ),
            ServiceApplicationSummaryData(
              label: 'Kewarganegaraan',
              value: 'Indonesia',
            ),
          ],
        ),
        const SizedBox(height: 14),
        const ServiceApplicationInformationBanner(
          richMessage: TextSpan(
            children: [
              TextSpan(
                text: 'Dengan melanjutkan Anda telah setuju dengan semua ',
              ),
              TextSpan(
                text: 'Syarat dan Ketentuan',
                style: const TextStyle(
                  color: Color(0xFF0056B3),
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF0056B3),
                ),
              ),
              TextSpan(
                text: ' dari Inaku',
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ServiceApplicationActions(
          primaryLabel: 'Kirim pengajuan',
          onPrimaryPressed: onSubmit,
          onSecondaryPressed: onPrevious,
          onCancelPressed: onCancel,
        ),
      ],
    );
  }
}
