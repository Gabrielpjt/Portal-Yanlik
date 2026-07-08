import 'package:flutter/material.dart';

import '../../../../shared/navigation/main_navigation_controller.dart';
import '../../../../shared/widgets/biometric_authentication_view.dart';
import '../../../profile/presentation/widgets/profile_status_tab.dart';
import '../widgets/birth_certificate_application_steps.dart';
import '../widgets/service_application_common_widgets.dart';
import '../widgets/service_application_scaffold.dart';

class BirthCertificateApplicationPage extends StatefulWidget {
  final bool isLoggedIn;
  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;

  const BirthCertificateApplicationPage({
    super.key,
    this.isLoggedIn = false,
    this.onMenuTap,
    this.onLoginTap,
  });

  @override
  State<BirthCertificateApplicationPage> createState() {
    return _BirthCertificateApplicationPageState();
  }
}

class _BirthCertificateApplicationPageState
    extends State<BirthCertificateApplicationPage> {
  static const int _totalSteps = 5;

  final TextEditingController _firstWitnessNikController =
  TextEditingController(
    text: '53080428062008',
  );

  final TextEditingController _secondWitnessNikController =
  TextEditingController(
    text: '53080428062008',
  );

  final TextEditingController _childNameController = TextEditingController(
    text: 'Rizki Awan Ardawan',
  );

  final TextEditingController _childOrderController =
  TextEditingController(
    text: '2',
  );

  final TextEditingController _birthPlaceController = TextEditingController(
    text: 'DKI Jakarta',
  );

  final TextEditingController _birthDateController = TextEditingController(
    text: '18 Februari 2026',
  );

  final TextEditingController _birthTimeController = TextEditingController(
    text: '12:00 WIB',
  );

  final TextEditingController _birthWeightController = TextEditingController(
    text: '3.8',
  );

  final TextEditingController _birthLengthController = TextEditingController(
    text: '42',
  );

  int _currentStep = 0;

  String _selectedGender = 'Laki-laki';
  String _selectedBirthType = 'Tunggal';
  String _selectedBirthPlaceType =
      'Rumah Sakit / Rumah Bersalin';

  List<String> _selectedBirthAssistants = [
    'Dokter',
    'Bidan',
  ];

  bool get _isLastStep {
    return _currentStep == _totalSteps - 1;
  }

  String get _stepTitle {
    switch (_currentStep) {
      case 0:
        return 'Validasi Dokumen';
      case 1:
        return 'Data Anak';
      case 2:
        return 'Data Saksi';
      case 3:
        return 'Ringkasan';
      case 4:
        return 'Selesai';
      default:
        return '';
    }
  }

  void _handleBack() {
    if (_isLastStep) {
      Navigator.of(context).pop(true);
      return;
    }

    if (_currentStep > 0) {
      _previousStep();
      return;
    }

    Navigator.of(context).pop(false);
  }

  void _nextStep() {
    if (!_validateCurrentStep()) {
      return;
    }

    if (_currentStep >= 3) {
      return;
    }

    setState(() {
      _currentStep++;
    });
  }

  void _previousStep() {
    if (_currentStep <= 0) {
      return;
    }

    setState(() {
      _currentStep--;
    });
  }

  void _submitApplication() {
    ProfileStatusStore.addBirthCertificateSubmission();

    setState(() {
      _currentStep = 4;
    });
  }

  void _openStatusPage() {
    MainNavigationController.instance.goProfileStatus();
  }

  void _cancelApplication() {
    Navigator.of(context).pop(false);
  }

  void _returnToService() {
    MainNavigationController.instance.goServices();
  }

  void _changeGender(String value) {
    setState(() {
      _selectedGender = value;
    });
  }

  void _changeBirthType(String value) {
    setState(() {
      _selectedBirthType = value;
    });
  }

  void _changeBirthPlaceType(String value) {
    setState(() {
      _selectedBirthPlaceType = value;
    });
  }

  void _changeBirthAssistants(List<String> values) {
    setState(() {
      _selectedBirthAssistants = values;
    });
  }

  void _validateSecondWitness() {
    _showMessage(
      'Data saksi berhasil divalidasi.',
    );
  }

  bool _validateCurrentStep() {
    if (_currentStep == 1) {
      if (_childNameController.text.trim().isEmpty ||
          _childOrderController.text.trim().isEmpty ||
          _birthPlaceController.text.trim().isEmpty ||
          _birthDateController.text.trim().isEmpty ||
          _birthTimeController.text.trim().isEmpty ||
          _birthWeightController.text.trim().isEmpty ||
          _birthLengthController.text.trim().isEmpty ||
          _selectedBirthAssistants.isEmpty) {
        _showMessage(
          'Lengkapi data kelahiran terlebih dahulu.',
        );

        return false;
      }
    }

    if (_currentStep == 2) {
      if (_firstWitnessNikController.text.trim().isEmpty ||
          _secondWitnessNikController.text.trim().isEmpty) {
        _showMessage(
          'Lengkapi NIK saksi pertama dan saksi kedua.',
        );

        return false;
      }
    }

    return true;
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _openBiometricAuthentication() async {
    final isAuthenticated = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => const BiometricAuthenticationView(
          faceImageAsset:
          'assets/images/birth_certificate_face_scan.jpg',
        ),
      ),
    );

    if (!mounted || isAuthenticated != true) {
      return;
    }

    _submitApplication();
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return BirthCertificateDocumentStep(
          onNext: _nextStep,
          onCancel: _cancelApplication,
        );
      case 1:
        return BirthCertificateBirthDataStep(
          childNameController: _childNameController,
          childOrderController: _childOrderController,
          birthPlaceController: _birthPlaceController,
          birthDateController: _birthDateController,
          birthTimeController: _birthTimeController,
          birthWeightController: _birthWeightController,
          birthLengthController: _birthLengthController,
          selectedGender: _selectedGender,
          selectedBirthType: _selectedBirthType,
          selectedBirthPlaceType: _selectedBirthPlaceType,
          selectedBirthAssistants: _selectedBirthAssistants,
          onGenderChanged: _changeGender,
          onBirthTypeChanged: _changeBirthType,
          onBirthPlaceTypeChanged: _changeBirthPlaceType,
          onBirthAssistantsChanged: _changeBirthAssistants,
          onNext: _nextStep,
          onPrevious: _previousStep,
          onCancel: _cancelApplication,
        );
      case 2:
        return BirthCertificateWitnessStep(
          firstWitnessNikController: _firstWitnessNikController,
          secondWitnessNikController: _secondWitnessNikController,
          onValidateSecondWitness: _validateSecondWitness,
          onNext: _nextStep,
          onPrevious: _previousStep,
          onCancel: _cancelApplication,
        );
      case 3:
        return BirthCertificateSummaryStep(
          childName: _childNameController.text,
          gender: _selectedGender,
          birthDate: _birthDateController.text,
          birthTime: _birthTimeController.text,
          birthPlace: _birthPlaceController.text,
          birthType: _selectedBirthType,
          birthWeight: _birthWeightController.text,
          birthLength: _birthLengthController.text,
          onSubmit: _openBiometricAuthentication,
          onPrevious: _previousStep,
          onCancel: _cancelApplication,
        );
      case 4:
        return ServiceApplicationSuccessView(
          title: 'Data Berhasil Diajukan',
          description:
          'Untuk mengecek status pengajuan, Anda dapat mengunjungi '
              'halaman status atau kembali ke halaman layanan.',
          onStatusPressed: _openStatusPage,
          onReturnPressed: _returnToService,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    _firstWitnessNikController.dispose();
    _secondWitnessNikController.dispose();
    _childNameController.dispose();
    _childOrderController.dispose();
    _birthPlaceController.dispose();
    _birthDateController.dispose();
    _birthTimeController.dispose();
    _birthWeightController.dispose();
    _birthLengthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ServiceApplicationScaffold(
      title: 'Penerbitan Akta Kelahiran',
      description:
      'Lengkapi beberapa informasi berikut untuk mengurus akta kelahiran.',
      currentStep: _currentStep,
      totalSteps: _totalSteps,
      stepTitle: _stepTitle,
      isLoggedIn: widget.isLoggedIn,
      onMenuTap: widget.onMenuTap,
      onLoginTap: widget.onLoginTap,
      onBack: _handleBack,
      content: _buildCurrentStep(),
    );
  }
}
