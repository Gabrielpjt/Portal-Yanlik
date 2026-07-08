import 'package:flutter/material.dart';

import '../widgets/queue_registration_application_steps.dart';
import '../widgets/service_application_common_widgets.dart';
import '../widgets/service_application_scaffold.dart';

enum QueueRegistrationView {
  form,
  queueIssued,
  cancelled,
}

class QueueRegistrationApplicationPage extends StatefulWidget {
  final bool isLoggedIn;
  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;

  const QueueRegistrationApplicationPage({
    super.key,
    this.isLoggedIn = false,
    this.onMenuTap,
    this.onLoginTap,
  });

  @override
  State<QueueRegistrationApplicationPage> createState() {
    return _QueueRegistrationApplicationPageState();
  }
}

class _QueueRegistrationApplicationPageState
    extends State<QueueRegistrationApplicationPage> {
  static const int _currentStep = 0;
  static const int _totalSteps = 5;

  final TextEditingController _visitDateController =
  TextEditingController(
    text: '08 Maret 2026',
  );

  final TextEditingController _complaintController =
  TextEditingController(
    text: 'Batuk dan demam',
  );

  QueueRegistrationView _currentView =
      QueueRegistrationView.form;

  String? _selectedParticipant = 'Iwan Nur Setiyawan';
  String? _selectedPolyclinic = 'Poli Umum';
  String? _selectedDoctor = 'Hafizur Rahman';

  String get _description {
    switch (_currentView) {
      case QueueRegistrationView.form:
        return 'Lengkapi data berikut untuk membuat nomor antrean.';
      case QueueRegistrationView.queueIssued:
        return 'Nomor Antrean Anda telah diterbitkan.';
      case QueueRegistrationView.cancelled:
        return 'Nomor Antrean Anda telah dibatalkan.';
    }
  }

  void _handleBack() {
    if (_currentView == QueueRegistrationView.form) {
      Navigator.of(context).pop(false);
      return;
    }

    Navigator.of(context).pop(true);
  }

  void _cancelForm() {
    Navigator.of(context).pop(false);
  }

  void _onParticipantChanged(String? value) {
    setState(() {
      _selectedParticipant = value;
      _selectedPolyclinic = null;
      _selectedDoctor = null;
      _visitDateController.clear();
    });
  }

  void _onPolyclinicChanged(String? value) {
    setState(() {
      _selectedPolyclinic = value;
      _selectedDoctor = null;
    });
  }

  void _onDoctorChanged(String? value) {
    setState(() {
      _selectedDoctor = value;
    });
  }

  Future<void> _selectVisitDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2026, 3, 8),
      firstDate: DateTime(2026, 1, 1),
      lastDate: DateTime(2027, 12, 31),
    );

    if (!mounted || selectedDate == null) {
      return;
    }

    setState(() {
      _visitDateController.text =
          _formatVisitDate(selectedDate);
      _selectedDoctor = null;
    });
  }

  String _formatVisitDate(DateTime date) {
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

  void _submitQueueRegistration() {
    if (_selectedParticipant == null ||
        _selectedPolyclinic == null ||
        _visitDateController.text.trim().isEmpty ||
        _selectedDoctor == null ||
        _complaintController.text.trim().isEmpty) {
      _showMessage(
        'Lengkapi seluruh data pendaftaran antrean terlebih dahulu.',
      );
      return;
    }

    setState(() {
      _currentView = QueueRegistrationView.queueIssued;
    });
  }

  Future<void> _showCancellationDialog() async {
    final confirmed =
    await showServiceApplicationConfirmationDialog(
      context: context,
      title: 'Konfirmasi Pembatalan',
      content: QueueCancellationSummary(
        queueNumber: 'B-32',
        visitDate: _visitDateController.text,
        complaint: _complaintController.text,
      ),
      confirmLabel: 'Ya, Batalkan',
      cancelLabel: 'Tidak',
    );

    if (!mounted || confirmed != true) {
      return;
    }

    setState(() {
      _currentView = QueueRegistrationView.cancelled;
    });
  }

  void _registerAgain() {
    setState(() {
      _selectedParticipant = 'Iwan Nur Setiyawan';
      _selectedPolyclinic = 'Poli Umum';
      _selectedDoctor = 'Hafizur Rahman';
      _visitDateController.text = '08 Maret 2026';
      _complaintController.text =
      'Batuk dan demam';
      _currentView = QueueRegistrationView.form;
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
    switch (_currentView) {
      case QueueRegistrationView.form:
        return QueueRegistrationFormStep(
          selectedParticipant: _selectedParticipant,
          selectedPolyclinic: _selectedPolyclinic,
          selectedDoctor: _selectedDoctor,
          visitDateController: _visitDateController,
          complaintController: _complaintController,
          onParticipantChanged: _onParticipantChanged,
          onPolyclinicChanged: _onPolyclinicChanged,
          onDoctorChanged: _onDoctorChanged,
          onDateTap: _selectVisitDate,
          onNext: _submitQueueRegistration,
          onCancel: _cancelForm,
        );

      case QueueRegistrationView.queueIssued:
        return QueueIssuedView(
          queueNumber: 'B-32',
          remainingQueue: '2',
          servedParticipants: '34',
          estimatedWaitingTime: '00:15:32',
          visitDate: _visitDateController.text,
          complaint: _complaintController.text,
          onCancelQueue: _showCancellationDialog,
          onMapTap: () {
            _showMessage('Fitur peta belum dihubungkan.');
          },
          onContactTap: () {
            _showMessage('Fitur hubungi belum dihubungkan.');
          },
        );

      case QueueRegistrationView.cancelled:
        return QueueCancelledView(
          onRegisterAgain: _registerAgain,
        );
    }
  }

  @override
  void dispose() {
    _visitDateController.dispose();
    _complaintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ServiceApplicationScaffold(
      title: 'Pendaftaran Pelayanan (Antrean)',
      description: _description,
      currentStep: _currentStep,
      totalSteps: _totalSteps,
      stepTitle: 'Validasi Dokumen',
      showProgress:
      _currentView != QueueRegistrationView.cancelled,
      contentKey: _currentView,
      content: _buildContent(),
      onBack: _handleBack,
      isLoggedIn: widget.isLoggedIn,
      onMenuTap: widget.onMenuTap,
      onLoginTap: widget.onLoginTap,
    );
  }
}
