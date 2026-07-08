import 'package:flutter/material.dart';

import '../../../../shared/navigation/main_navigation_controller.dart';
import '../widgets/bpjs_membership_addition_application_steps.dart';
import '../widgets/bpjs_membership_addition_widgets.dart';
import '../widgets/service_application_scaffold.dart';

enum BpjsMembershipAdditionPhase {
  familyNumber,
  participantData,
  addressAndFacility,
  serviceClass,
  contactVerification,
  success,
}

class BpjsMembershipAdditionApplicationPage
    extends StatefulWidget {
  final bool isLoggedIn;
  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;

  const BpjsMembershipAdditionApplicationPage({
    super.key,
    this.isLoggedIn = false,
    this.onMenuTap,
    this.onLoginTap,
  });

  @override
  State<BpjsMembershipAdditionApplicationPage>
  createState() {
    return _BpjsMembershipAdditionApplicationPageState();
  }
}

class _BpjsMembershipAdditionApplicationPageState
    extends State<BpjsMembershipAdditionApplicationPage> {
  final TextEditingController _familyNumberController =
  TextEditingController(
    text: '3506152911101038',
  );

  final TextEditingController _nikController =
  TextEditingController(
    text: '357402020020003',
  );

  final TextEditingController _nameController =
  TextEditingController(
    text: 'Iwan Setiawan',
  );

  final TextEditingController _birthPlaceController =
  TextEditingController(
    text: 'Kota Bandung',
  );

  final TextEditingController _birthDateController =
  TextEditingController(
    text: '02 Februari 2005',
  );

  final TextEditingController _addressController =
  TextEditingController(
    text: 'Jl. Bojongkoneng, No. 35',
  );

  final TextEditingController _villageController =
  TextEditingController(
    text: 'Cibaduyut Wetan',
  );

  final TextEditingController _postalCodeController =
  TextEditingController(
    text: '40125',
  );

  final TextEditingController _phoneController =
  TextEditingController(
    text: '0822 1234 5678',
  );

  final TextEditingController _emailController =
  TextEditingController(
    text: 'iwan@gmail.com',
  );

  BpjsMembershipAdditionPhase _currentPhase =
      BpjsMembershipAdditionPhase.familyNumber;

  bool _showNewParticipantForm = false;
  bool _phoneVerified = false;
  bool _emailVerified = false;

  String _selectedGender = 'Laki-Laki';
  String? _selectedMaritalStatus = 'Belum Kawin';
  String? _selectedRelationship = 'Anak';
  String? _selectedProvince = 'Jawa Barat';
  String? _selectedCity = 'Kota Bandung';
  String? _selectedDistrict = 'Bojongloa Kaler';
  String? _selectedFacility = 'Klinik Pratama Nusalima';
  String? _selectedServiceClass = '1 (Satu)';

  int get _currentStep {
    switch (_currentPhase) {
      case BpjsMembershipAdditionPhase.familyNumber:
      case BpjsMembershipAdditionPhase.participantData:
        return 0;
      case BpjsMembershipAdditionPhase.addressAndFacility:
        return 1;
      case BpjsMembershipAdditionPhase.serviceClass:
        return 2;
      case BpjsMembershipAdditionPhase.contactVerification:
        return 3;
      case BpjsMembershipAdditionPhase.success:
        return 4;
    }
  }

  String get _stepTitle {
    switch (_currentPhase) {
      case BpjsMembershipAdditionPhase.familyNumber:
      case BpjsMembershipAdditionPhase.participantData:
        return 'Validasi Dokumen';
      case BpjsMembershipAdditionPhase.addressAndFacility:
        return 'Alamat dan Faskes';
      case BpjsMembershipAdditionPhase.serviceClass:
        return 'Kelas Pelayanan';
      case BpjsMembershipAdditionPhase.contactVerification:
        return 'Verifikasi Kontak';
      case BpjsMembershipAdditionPhase.success:
        return 'Selesai';
    }
  }

  String get _description {
    if (_currentPhase ==
        BpjsMembershipAdditionPhase.success) {
      return 'Peserta baru berhasil ditambahkan.';
    }

    return 'Lengkapi data berikut untuk menambah kepesertaan baru.';
  }

  void _setPhase(
      BpjsMembershipAdditionPhase phase,
      ) {
    setState(() {
      _currentPhase = phase;
    });
  }

  void _cancelApplication() {
    Navigator.of(context).pop(false);
  }

  void _handleBack() {
    switch (_currentPhase) {
      case BpjsMembershipAdditionPhase.familyNumber:
        Navigator.of(context).pop(false);
        return;
      case BpjsMembershipAdditionPhase.participantData:
        _setPhase(
          BpjsMembershipAdditionPhase.familyNumber,
        );
        return;
      case BpjsMembershipAdditionPhase.addressAndFacility:
        _setPhase(
          BpjsMembershipAdditionPhase.participantData,
        );
        return;
      case BpjsMembershipAdditionPhase.serviceClass:
        _setPhase(
          BpjsMembershipAdditionPhase.addressAndFacility,
        );
        return;
      case BpjsMembershipAdditionPhase.contactVerification:
        _setPhase(
          BpjsMembershipAdditionPhase.serviceClass,
        );
        return;
      case BpjsMembershipAdditionPhase.success:
        Navigator.of(context).pop(true);
        return;
    }
  }

  void _openParticipantData() {
    _setPhase(
      BpjsMembershipAdditionPhase.participantData,
    );
  }

  void _showParticipantForm() {
    setState(() {
      _showNewParticipantForm = true;
    });
  }

  Future<void> _selectBirthDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2005, 2, 2),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );

    if (!mounted || selectedDate == null) {
      return;
    }

    setState(() {
      _birthDateController.text =
          _formatDate(selectedDate);
    });
  }

  String _formatDate(DateTime date) {
    const monthNames = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${date.day.toString().padLeft(2, '0')} '
        '${monthNames[date.month - 1]} ${date.year}';
  }

  bool get _participantDataComplete {
    return _showNewParticipantForm &&
        _nikController.text.trim().isNotEmpty &&
        _nameController.text.trim().isNotEmpty &&
        _birthPlaceController.text.trim().isNotEmpty &&
        _birthDateController.text.trim().isNotEmpty &&
        _selectedMaritalStatus != null &&
        _selectedRelationship != null;
  }

  void _continueFromParticipantData() {
    if (!_participantDataComplete) {
      _showMessage(
        'Tambahkan dan lengkapi data peserta baru terlebih dahulu.',
      );
      return;
    }

    _setPhase(
      BpjsMembershipAdditionPhase.addressAndFacility,
    );
  }

  bool get _addressDataComplete {
    return _addressController.text.trim().isNotEmpty &&
        _selectedProvince != null &&
        _selectedCity != null &&
        _selectedDistrict != null &&
        _villageController.text.trim().isNotEmpty &&
        _postalCodeController.text.trim().isNotEmpty &&
        _selectedFacility != null;
  }

  void _continueFromAddress() {
    if (!_addressDataComplete) {
      _showMessage(
        'Lengkapi alamat dan fasilitas kesehatan terlebih dahulu.',
      );
      return;
    }

    _setPhase(
      BpjsMembershipAdditionPhase.serviceClass,
    );
  }

  void _continueFromServiceClass() {
    if (_selectedServiceClass == null) {
      _showMessage(
        'Pilih kelas pelayanan terlebih dahulu.',
      );
      return;
    }

    _setPhase(
      BpjsMembershipAdditionPhase.contactVerification,
    );
  }

  Future<void> _verifyPhone() async {
    if (_phoneController.text.trim().isEmpty) {
      _showMessage(
        'Masukkan nomor telepon terlebih dahulu.',
      );
      return;
    }

    final verified =
    await showBpjsContactVerificationDialog(
      context: context,
      title: 'Verifikasi No. Telepon',
      destinationLabel: 'nomor',
      maskedDestination: '(+62) 822 **** **90',
    );

    if (!mounted || verified != true) {
      return;
    }

    setState(() {
      _phoneVerified = true;
    });
  }

  Future<void> _verifyEmail() async {
    if (_emailController.text.trim().isEmpty) {
      _showMessage(
        'Masukkan email terlebih dahulu.',
      );
      return;
    }

    final verified =
    await showBpjsContactVerificationDialog(
      context: context,
      title: 'Verifikasi Email',
      destinationLabel: 'email',
      maskedDestination: 'iw***@gmail.com',
    );

    if (!mounted || verified != true) {
      return;
    }

    setState(() {
      _emailVerified = true;
    });
  }

  void _submitApplication() {
    if (_phoneController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty) {
      _showMessage(
        'Masukkan nomor telepon dan email terlebih dahulu.',
      );
      return;
    }

    if (!_phoneVerified || !_emailVerified) {
      _showMessage(
        'Verifikasi nomor telepon dan email terlebih dahulu.',
      );
      return;
    }

    _setPhase(
      BpjsMembershipAdditionPhase.success,
    );
  }

  void _goToService() {
    MainNavigationController.instance.goServices();
  }

  void _goHome() {
    MainNavigationController.instance.goHome();
  }

  void _prefillParticipantData() {
    setState(() {
      _showNewParticipantForm = true;
      _nikController.text = '357402020020003';
      _nameController.text = 'Iwan Setiawan';
      _birthPlaceController.text = 'Kota Bandung';
      _birthDateController.text = '02 Februari 2005';
      _selectedGender = 'Laki-Laki';
      _selectedMaritalStatus = 'Belum Kawin';
      _selectedRelationship = 'Anak';
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildContent() {
    switch (_currentPhase) {
      case BpjsMembershipAdditionPhase.familyNumber:
        return BpjsFamilyNumberValidationStep(
          familyNumberController:
          _familyNumberController,
          onNext: _openParticipantData,
          onCancel: _cancelApplication,
        );

      case BpjsMembershipAdditionPhase.participantData:
        return BpjsParticipantDataStep(
          showNewParticipantForm:
          _showNewParticipantForm,
          nikController: _nikController,
          nameController: _nameController,
          birthPlaceController:
          _birthPlaceController,
          birthDateController:
          _birthDateController,
          selectedGender: _selectedGender,
          selectedMaritalStatus:
          _selectedMaritalStatus,
          selectedRelationship:
          _selectedRelationship,
          onAddParticipant: _prefillParticipantData,
          onBirthDateTap: _selectBirthDate,
          onGenderChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
          },
          onMaritalStatusChanged: (value) {
            setState(() {
              _selectedMaritalStatus = value;
            });
          },
          onRelationshipChanged: (value) {
            setState(() {
              _selectedRelationship = value;
            });
          },
          onEditCompleteMember: () {
            _showMessage(
              'Form perubahan data anggota dibuka.',
            );
          },
          onCompleteIncompleteMember:
          _prefillParticipantData,
          onDeleteCompleteMember: () {
            _showMessage(
              'Anggota keluarga belum dihapus pada data demo.',
            );
          },
          onDeleteIncompleteMember: () {
            _showMessage(
              'Anggota keluarga belum dihapus pada data demo.',
            );
          },
          onNext: _continueFromParticipantData,
          onPrevious: () {
            _setPhase(
              BpjsMembershipAdditionPhase.familyNumber,
            );
          },
          onCancel: _cancelApplication,
        );

      case BpjsMembershipAdditionPhase.addressAndFacility:
        return BpjsAddressAndFacilityStep(
          addressController: _addressController,
          selectedProvince: _selectedProvince,
          selectedCity: _selectedCity,
          selectedDistrict: _selectedDistrict,
          villageController: _villageController,
          postalCodeController:
          _postalCodeController,
          selectedFacility: _selectedFacility,
          onProvinceChanged: (value) {
            setState(() {
              _selectedProvince = value;
              _selectedCity = null;
              _selectedDistrict = null;
            });
          },
          onCityChanged: (value) {
            setState(() {
              _selectedCity = value;
              _selectedDistrict = null;
            });
          },
          onDistrictChanged: (value) {
            setState(() {
              _selectedDistrict = value;
            });
          },
          onFacilityChanged: (value) {
            setState(() {
              _selectedFacility = value;
            });
          },
          onNext: _continueFromAddress,
          onPrevious: () {
            _setPhase(
              BpjsMembershipAdditionPhase.participantData,
            );
          },
          onCancel: _cancelApplication,
        );

      case BpjsMembershipAdditionPhase.serviceClass:
        return BpjsServiceClassStep(
          selectedServiceClass:
          _selectedServiceClass,
          onServiceClassChanged: (value) {
            setState(() {
              _selectedServiceClass = value;
            });
          },
          onNext: _continueFromServiceClass,
          onPrevious: () {
            _setPhase(
              BpjsMembershipAdditionPhase.addressAndFacility,
            );
          },
          onCancel: _cancelApplication,
        );

      case BpjsMembershipAdditionPhase.contactVerification:
        return BpjsContactVerificationStep(
          phoneController: _phoneController,
          emailController: _emailController,
          phoneVerified: _phoneVerified,
          emailVerified: _emailVerified,
          onSendPhoneOtp: _verifyPhone,
          onSendEmailCode: _verifyEmail,
          onNext: _submitApplication,
          onPrevious: () {
            _setPhase(
              BpjsMembershipAdditionPhase.serviceClass,
            );
          },
          onCancel: _cancelApplication,
        );

      case BpjsMembershipAdditionPhase.success:
        return BpjsMembershipAdditionSuccessStep(
          onServicePressed: _goToService,
          onHomePressed: _goHome,
        );
    }
  }

  @override
  void dispose() {
    _familyNumberController.dispose();
    _nikController.dispose();
    _nameController.dispose();
    _birthPlaceController.dispose();
    _birthDateController.dispose();
    _addressController.dispose();
    _villageController.dispose();
    _postalCodeController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ServiceApplicationScaffold(
      title: 'Penambahan Peserta Baru',
      description: _description,
      currentStep: _currentStep,
      totalSteps: 5,
      stepTitle: _stepTitle,
      showProgress:
      _currentPhase !=
          BpjsMembershipAdditionPhase.success,
      contentKey: _currentPhase,
      content: _buildContent(),
      onBack: _handleBack,
      isLoggedIn: widget.isLoggedIn,
      onMenuTap: widget.onMenuTap,
      onLoginTap: widget.onLoginTap,
    );
  }
}
