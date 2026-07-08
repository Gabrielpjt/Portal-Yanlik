import 'package:flutter/material.dart';

import 'bpjs_membership_addition_widgets.dart';
import 'service_application_common_widgets.dart';

class BpjsFamilyNumberValidationStep extends StatelessWidget {
  final TextEditingController familyNumberController;
  final VoidCallback onNext;
  final VoidCallback onCancel;

  const BpjsFamilyNumberValidationStep({
    super.key,
    required this.familyNumberController,
    required this.onNext,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ServiceApplicationLabeledTextField(
          label: 'Nomor Kartu Keluarga',
          controller: familyNumberController,
          keyboardType: TextInputType.number,
          readOnly: true,
          enabled: false,
        ),
        const SizedBox(height: 20),
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

class BpjsParticipantDataStep extends StatelessWidget {
  final bool showNewParticipantForm;
  final TextEditingController nikController;
  final TextEditingController nameController;
  final TextEditingController birthPlaceController;
  final TextEditingController birthDateController;
  final String selectedGender;
  final String? selectedMaritalStatus;
  final String? selectedRelationship;
  final VoidCallback onAddParticipant;
  final VoidCallback onBirthDateTap;
  final ValueChanged<String> onGenderChanged;
  final ValueChanged<String?> onMaritalStatusChanged;
  final ValueChanged<String?> onRelationshipChanged;
  final VoidCallback onEditCompleteMember;
  final VoidCallback onCompleteIncompleteMember;
  final VoidCallback onDeleteCompleteMember;
  final VoidCallback onDeleteIncompleteMember;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onCancel;

  const BpjsParticipantDataStep({
    super.key,
    required this.showNewParticipantForm,
    required this.nikController,
    required this.nameController,
    required this.birthPlaceController,
    required this.birthDateController,
    required this.selectedGender,
    required this.selectedMaritalStatus,
    required this.selectedRelationship,
    required this.onAddParticipant,
    required this.onBirthDateTap,
    required this.onGenderChanged,
    required this.onMaritalStatusChanged,
    required this.onRelationshipChanged,
    required this.onEditCompleteMember,
    required this.onCompleteIncompleteMember,
    required this.onDeleteCompleteMember,
    required this.onDeleteIncompleteMember,
    required this.onNext,
    required this.onPrevious,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const BpjsParticipantStatusCard(
          name: 'Iwan Nur Setiyawan',
          participantNumber: '000123456788911',
          membershipType: 'Peserta (Pegawai Swasta)',
          group:
          'PRB (Hypertensi, Penyakit Jantung)\n'
              'Prolanis (Diabetes melitus)',
          primaryFacility: 'Puskesmas Tanjung Priok',
        ),
        const SizedBox(height: 13),
        BpjsFamilyMemberCard(
          name: 'Imah Nursaidah',
          isComplete: true,
          onEdit: onEditCompleteMember,
          onDelete: onDeleteCompleteMember,
        ),
        const SizedBox(height: 11),
        BpjsFamilyMemberCard(
          name: 'Imah Nursaidah',
          isComplete: false,
          onEdit: onCompleteIncompleteMember,
          onDelete: onDeleteIncompleteMember,
        ),
        const SizedBox(height: 12),
        BpjsAddParticipantButton(
          onPressed: onAddParticipant,
        ),
        if (showNewParticipantForm) ...[
          const SizedBox(height: 14),
          BpjsParticipantFormCard(
            nikController: nikController,
            nameController: nameController,
            birthPlaceController: birthPlaceController,
            birthDateController: birthDateController,
            selectedGender: selectedGender,
            selectedMaritalStatus: selectedMaritalStatus,
            selectedRelationship: selectedRelationship,
            onBirthDateTap: onBirthDateTap,
            onGenderChanged: onGenderChanged,
            onMaritalStatusChanged:
            onMaritalStatusChanged,
            onRelationshipChanged:
            onRelationshipChanged,
          ),
        ],
        const SizedBox(height: 18),
        ServiceApplicationActions(
          primaryLabel: 'Selanjutnya',
          onPrimaryPressed: onNext,
          secondaryLabel: 'Sebelumnya',
          onSecondaryPressed: onPrevious,
          cancelLabel: 'Batal',
          onCancelPressed: onCancel,
        ),
      ],
    );
  }
}

class BpjsAddressAndFacilityStep extends StatelessWidget {
  final TextEditingController addressController;
  final String? selectedProvince;
  final String? selectedCity;
  final String? selectedDistrict;
  final TextEditingController villageController;
  final TextEditingController postalCodeController;
  final String? selectedFacility;
  final ValueChanged<String?> onProvinceChanged;
  final ValueChanged<String?> onCityChanged;
  final ValueChanged<String?> onDistrictChanged;
  final ValueChanged<String?> onFacilityChanged;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onCancel;

  const BpjsAddressAndFacilityStep({
    super.key,
    required this.addressController,
    required this.selectedProvince,
    required this.selectedCity,
    required this.selectedDistrict,
    required this.villageController,
    required this.postalCodeController,
    required this.selectedFacility,
    required this.onProvinceChanged,
    required this.onCityChanged,
    required this.onDistrictChanged,
    required this.onFacilityChanged,
    required this.onNext,
    required this.onPrevious,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ServiceApplicationLabeledTextField(
          label: 'Alamat Lengkap',
          requiredField: true,
          controller: addressController,
          hintText: 'Jalan, RT, RW atau nomor rumah',
        ),
        const SizedBox(height: 14),
        ServiceApplicationDropdownField<String>(
          label: 'Provinsi',
          requiredField: true,
          value: selectedProvince,
          hintText: 'Pilih provinsi',
          items: const [
            DropdownMenuItem(
              value: 'Jawa Barat',
              child: Text('Jawa Barat'),
            ),
          ],
          onChanged: onProvinceChanged,
        ),
        const SizedBox(height: 14),
        ServiceApplicationDropdownField<String>(
          label: 'Kabupaten/Kota',
          requiredField: true,
          value: selectedCity,
          hintText: 'Pilih kabupaten/kota',
          enabled: selectedProvince != null,
          items: const [
            DropdownMenuItem(
              value: 'Kota Bandung',
              child: Text('Kota Bandung'),
            ),
          ],
          onChanged: onCityChanged,
        ),
        const SizedBox(height: 14),
        ServiceApplicationDropdownField<String>(
          label: 'Kecamatan',
          requiredField: true,
          value: selectedDistrict,
          hintText: 'Pilih kecamatan',
          enabled: selectedCity != null,
          items: const [
            DropdownMenuItem(
              value: 'Bojongloa Kaler',
              child: Text('Bojongloa Kaler'),
            ),
          ],
          onChanged: onDistrictChanged,
        ),
        const SizedBox(height: 14),
        ServiceApplicationLabeledTextField(
          label: 'Kelurahan',
          requiredField: true,
          controller: villageController,
          hintText: 'Masukkan kelurahan',
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: 145,
          child: ServiceApplicationLabeledTextField(
            label: 'Kode Pos',
            requiredField: true,
            controller: postalCodeController,
            keyboardType: TextInputType.number,
            hintText: 'Masukkan kode pos',
          ),
        ),
        const SizedBox(height: 22),
        ServiceApplicationDropdownField<String>(
          label: 'Faskes Tingkat Pertama',
          requiredField: true,
          value: selectedFacility,
          hintText: 'Pilih Faskes Tingkat Pertama',
          items: const [
            DropdownMenuItem(
              value: 'Klinik Pratama Nusalima',
              child: Text('Klinik Pratama Nusalima'),
            ),
          ],
          onChanged: onFacilityChanged,
        ),
        if (selectedFacility != null) ...[
          const SizedBox(height: 10),
          const BpjsFacilityInformationCard(),
        ],
        const SizedBox(height: 18),
        ServiceApplicationActions(
          primaryLabel: 'Selanjutnya',
          onPrimaryPressed: onNext,
          secondaryLabel: 'Sebelumnya',
          onSecondaryPressed: onPrevious,
          cancelLabel: 'Batal',
          onCancelPressed: onCancel,
        ),
      ],
    );
  }
}

class BpjsServiceClassStep extends StatelessWidget {
  final String? selectedServiceClass;
  final ValueChanged<String?> onServiceClassChanged;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onCancel;

  const BpjsServiceClassStep({
    super.key,
    required this.selectedServiceClass,
    required this.onServiceClassChanged,
    required this.onNext,
    required this.onPrevious,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ServiceApplicationDropdownField<String>(
          label: 'Kelas Pelayanan',
          requiredField: true,
          value: selectedServiceClass,
          hintText: 'Pilih kelas pelayanan',
          items: const [
            DropdownMenuItem(
              value: '1 (Satu)',
              child: Text('1 (Satu)'),
            ),
            DropdownMenuItem(
              value: '2 (Dua)',
              child: Text('2 (Dua)'),
            ),
            DropdownMenuItem(
              value: '3 (Tiga)',
              child: Text('3 (Tiga)'),
            ),
          ],
          onChanged: onServiceClassChanged,
        ),
        if (selectedServiceClass != null) ...[
          const SizedBox(height: 10),
          const BpjsServiceClassSummary(
            monthlyContribution: 'Rp. 100.000',
            familyContribution: 'Rp. 300.000',
          ),
        ],
        const SizedBox(height: 20),
        ServiceApplicationActions(
          primaryLabel: 'Selanjutnya',
          onPrimaryPressed: onNext,
          secondaryLabel: 'Sebelumnya',
          onSecondaryPressed: onPrevious,
          cancelLabel: 'Batal',
          onCancelPressed: onCancel,
        ),
      ],
    );
  }
}

class BpjsContactVerificationStep extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final bool phoneVerified;
  final bool emailVerified;
  final VoidCallback onSendPhoneOtp;
  final VoidCallback onSendEmailCode;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onCancel;

  const BpjsContactVerificationStep({
    super.key,
    required this.phoneController,
    required this.emailController,
    required this.phoneVerified,
    required this.emailVerified,
    required this.onSendPhoneOtp,
    required this.onSendEmailCode,
    required this.onNext,
    required this.onPrevious,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BpjsContactVerificationField(
          label: 'No. Telepon/HP',
          controller: phoneController,
          hintText: 'Masukkan nomor telepon/HP',
          actionLabel: 'Kirim OTP',
          onActionPressed: onSendPhoneOtp,
          verified: phoneVerified,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 15),
        BpjsContactVerificationField(
          label: 'Email',
          controller: emailController,
          hintText: 'Masukkan email',
          actionLabel: 'Kirim kode',
          onActionPressed: onSendEmailCode,
          verified: emailVerified,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        ServiceApplicationActions(
          primaryLabel: 'Selanjutnya',
          onPrimaryPressed: onNext,
          secondaryLabel: 'Sebelumnya',
          onSecondaryPressed: onPrevious,
          cancelLabel: 'Batal',
          onCancelPressed: onCancel,
        ),
      ],
    );
  }
}

class BpjsMembershipAdditionSuccessStep extends StatelessWidget {
  final VoidCallback onServicePressed;
  final VoidCallback onHomePressed;

  const BpjsMembershipAdditionSuccessStep({
    super.key,
    required this.onServicePressed,
    required this.onHomePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 4),
        Center(
          child: Container(
            width: 76,
            height: 76,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF27883B),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 42,
            ),
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Berhasil Menambahkan Peserta',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF062F5E),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          'Cek peserta BPJS yang telah ditambahkan melalui '
              'website INAku dan aplikasi Mobile JKN.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF777777),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 18),
        const BpjsVirtualAccountCard(
          accountNumber: '8888 0 30012123456',
        ),
        const SizedBox(height: 18),
        ServiceApplicationActions(
          primaryLabel: 'Ke Layanan',
          onPrimaryPressed: onServicePressed,
          secondaryLabel: 'Ke Beranda',
          onSecondaryPressed: onHomePressed,
          cancelLabel: null,
        ),
      ],
    );
  }
}
