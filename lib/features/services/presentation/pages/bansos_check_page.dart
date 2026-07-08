import 'package:flutter/material.dart';

import '../widgets/bansos_check_widgets.dart';
import '../widgets/service_application_scaffold.dart';

class BansosCheckPage extends StatefulWidget {
  final bool isLoggedIn;
  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;

  const BansosCheckPage({
    super.key,
    this.isLoggedIn = false,
    this.onMenuTap,
    this.onLoginTap,
  });

  @override
  State<BansosCheckPage> createState() {
    return _BansosCheckPageState();
  }
}

class _BansosCheckPageState extends State<BansosCheckPage> {
  static const String _defaultNik = '3734562010200004';

  final TextEditingController _nikController =
  TextEditingController(text: _defaultNik);

  int _currentStep = 0;
  String _selectedNikType = 'self';

  bool get _isSelfNik {
    return _selectedNikType == 'self';
  }

  bool get _canContinue {
    return _nikController.text.trim().isNotEmpty;
  }

  String get _stepTitle {
    return _currentStep == 0
        ? 'Masukkan NIK'
        : 'Detail Informasi Bansos';
  }

  @override
  void dispose() {
    _nikController.dispose();
    super.dispose();
  }

  void _backToDetail() {
    Navigator.of(context).pop(false);
  }

  void _cancel() {
    Navigator.of(context).pop(false);
  }

  void _goNext() {
    if (!_canContinue) {
      return;
    }

    setState(() {
      _currentStep = 1;
    });
  }

  void _goPrevious() {
    setState(() {
      _currentStep = 0;
    });
  }

  void _changeNikType(String value) {
    setState(() {
      _selectedNikType = value;

      if (value == 'self') {
        _nikController.text = _defaultNik;
      } else {
        _nikController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ServiceApplicationScaffold(
      title: 'Mengecek Bantuan Sosial',
      description:
      'Cek status kepesertaan dan rincian bantuan sosial '
          'Anda dengan memasukkan NIK yang terdaftar pada KTP.',
      currentStep: _currentStep,
      totalSteps: 2,
      stepTitle: _stepTitle,
      contentKey: 'bansos-$_currentStep-$_selectedNikType',
      onBack: _backToDetail,
      isLoggedIn: widget.isLoggedIn,
      onMenuTap: widget.onMenuTap,
      onLoginTap: widget.onLoginTap,
      content: _currentStep == 0
          ? BansosNikInputStep(
        selectedNikType: _selectedNikType,
        nikController: _nikController,
        isSelfNik: _isSelfNik,
        canContinue: _canContinue,
        onNikTypeChanged: _changeNikType,
        onNikChanged: (_) {
          setState(() {});
        },
        onNext: _goNext,
        onCancel: _cancel,
      )
          : BansosResultStep(
        onPrevious: _goPrevious,
        onCancel: _cancel,
      ),
    );
  }
}
