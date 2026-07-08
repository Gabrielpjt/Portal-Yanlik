import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../shared/widgets/app_footer.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/breadcrumb_widget.dart';
import '../../../profile/presentation/widgets/profile_status_tab.dart';
import '../../domain/entities/service_detail_entity.dart';
import '../bloc/service_detail_bloc.dart';
import '../bloc/service_detail_event.dart';
import '../bloc/service_detail_state.dart';
import '../widgets/service_detail_main_content.dart';
import '../widgets/service_detail_overview_card.dart';
import '../widgets/service_detail_support_section.dart';
import '../widgets/service_review_related_section.dart';
import 'bansos_check_page.dart';
import 'birth_certificate_application_page.dart';
import 'bpjs_membership_addition_application_page.dart';
import 'queue_registration_application_page.dart';
import 'service_access_search_page.dart';

class ServiceDetailPage extends StatefulWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;
  final VoidCallback? onServicesTap;

  final int? serviceId;
  final bool isLoggedIn;
  final String serviceTitle;
  final bool initialHasSubmittedApplication;

  const ServiceDetailPage({
    super.key,
    this.serviceId,
    this.onMenuTap,
    this.onLoginTap,
    this.onServicesTap,
    this.isLoggedIn = false,
    this.serviceTitle = 'Cari Fasilitas Kesehatan',
    this.initialHasSubmittedApplication = false,
  });

  @override
  State<ServiceDetailPage> createState() {
    return _ServiceDetailPageState();
  }
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  late bool _hasSubmittedApplication;

  @override
  void initState() {
    super.initState();

    final hasStoredBirthCertificateSubmission =
    ProfileStatusStore.submissions.value.any(
          (submission) {
        return submission.title == 'Penerbitan Akta Kelahiran' ||
            submission.title == 'Pengurusan Akta Kelahiran';
      },
    );

    _hasSubmittedApplication = widget.initialHasSubmittedApplication ||
        (_isBirthCertificate && hasStoredBirthCertificateSubmission);
  }

  ServiceDetailEntity get _fallbackDetail {
    return ServiceDetailEntity(
      id: widget.serviceId ?? 0,
      nama: widget.serviceTitle,
      deskripsi: '',
      status: 'PUBLISHED',
      cakupan: 'Nasional',
    );
  }

  bool get _isHealthFacility {
    return widget.serviceTitle == 'Cek Fasilitas Kesehatan' ||
        widget.serviceTitle == 'Cari Fasilitas Kesehatan' ||
        widget.serviceTitle == 'Cari Dokter dan Fasilitas Kesehatan' ||
        widget.serviceTitle.startsWith('Pencarian Layanan Keseha');
  }

  bool get _isDoctor {
    return widget.serviceTitle == 'Cari Dokter';
  }

  bool get _isHealthDirectory {
    return _isDoctor || _isHealthFacility;
  }

  bool get _isBpjsMembership {
    return widget.serviceTitle == 'Informasi Kepesertaan BPJS';
  }

  bool get _isBpjsMembershipAddition {
    return widget.serviceTitle == 'Penambahan Kepesertaan BPJS';
  }

  bool get _isQueueRegistration {
    return widget.serviceTitle == 'Pendaftaran Pelayanan BPJS (Antrean)' ||
        widget.serviceTitle == 'Pendaftaran Pelayanan (Antrean)';
  }

  bool get _isBirthCertificate {
    return widget.serviceTitle == 'Penerbitan Akta Kelahiran' ||
        widget.serviceTitle == 'Pengurusan Akta Kelahiran';
  }

  bool get _isBansosCheck {
    return widget.serviceTitle == 'Mengecek Bantuan Sosial' ||
        widget.serviceTitle == 'Cek Bantuan Sosial' ||
        widget.serviceTitle == 'Pengecekan Bantuan Sosial';
  }

  bool get _isBpomProductCheck {
    return widget.serviceTitle == 'Pengecekan Produk BPOM' ||
        widget.serviceTitle == 'Cek Produk BPOM' ||
        widget.serviceTitle == 'Mengecek Produk BPOM';
  }

  bool get _usesServiceAccess {
    return _isHealthDirectory || _isBpjsMembership || _isBpomProductCheck;
  }

  bool get _canAccessFromMainContent {
    return _isBirthCertificate ||
        _isBpjsMembership ||
        _isBpjsMembershipAddition ||
        _isQueueRegistration ||
        _isBansosCheck ||
        _isBpomProductCheck;
  }

  void _openServiceAccess(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ServiceAccessSearchPage(
          serviceTitle: widget.serviceTitle,
          isLoggedIn: widget.isLoggedIn,
          onMenuTap: widget.onMenuTap,
          onLoginTap: widget.onLoginTap,
        ),
      ),
    );
  }

  Future<void> _openBirthCertificateApplication() async {
    final submitted = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => BirthCertificateApplicationPage(
          isLoggedIn: widget.isLoggedIn,
          onMenuTap: widget.onMenuTap,
          onLoginTap: widget.onLoginTap,
        ),
      ),
    );

    if (!mounted || submitted != true) {
      return;
    }

    setState(() {
      _hasSubmittedApplication = true;
    });
  }

  Future<void> _openBpjsMembershipAdditionApplication() async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => BpjsMembershipAdditionApplicationPage(
          isLoggedIn: widget.isLoggedIn,
          onMenuTap: widget.onMenuTap,
          onLoginTap: widget.onLoginTap,
        ),
      ),
    );
  }

  Future<void> _openQueueRegistrationApplication() async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => QueueRegistrationApplicationPage(
          isLoggedIn: widget.isLoggedIn,
          onMenuTap: widget.onMenuTap,
          onLoginTap: widget.onLoginTap,
        ),
      ),
    );
  }

  Future<void> _openBansosCheckApplication() async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => BansosCheckPage(
          isLoggedIn: widget.isLoggedIn,
          onMenuTap: widget.onMenuTap,
          onLoginTap: widget.onLoginTap,
        ),
      ),
    );
  }

  void _handleAccessService(BuildContext context) {
    if (_isBpjsMembershipAddition) {
      _openBpjsMembershipAdditionApplication();
      return;
    }

    if (_isQueueRegistration) {
      _openQueueRegistrationApplication();
      return;
    }

    if (_usesServiceAccess) {
      _openServiceAccess(context);
      return;
    }

    if (_isBirthCertificate) {
      _openBirthCertificateApplication();
      return;
    }

    if (_isBansosCheck) {
      _openBansosCheckApplication();
      return;
    }
  }

  Future<void> _copySubmissionId() async {
    const submissionId = '1234567890';

    await Clipboard.setData(
      const ClipboardData(
        text: submissionId,
      ),
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ID pengajuan berhasil disalin'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.serviceId == null) {
      return _buildDetailPage(_fallbackDetail);
    }

    return BlocProvider(
      create: (_) => getIt<ServiceDetailBloc>()
        ..add(FetchServiceDetail(widget.serviceId!)),
      child: BlocBuilder<ServiceDetailBloc, ServiceDetailState>(
        builder: (context, state) {
          if (state.status == ServiceDetailStatus.loading ||
              state.status == ServiceDetailStatus.initial) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state.status == ServiceDetailStatus.error ||
              state.detail == null) {
            debugPrint(
              'Gagal memuat detail layanan id ${widget.serviceId}: '
                  '${state.errorMessage}',
            );

            return _buildDetailPage(_fallbackDetail);
          }

          return _buildDetailPage(state.detail!);
        },
      ),
    );
  }

  Widget _buildDetailPage(ServiceDetailEntity detail) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppHeader(
            isLoggedIn: widget.isLoggedIn,
            onMenuTap: widget.onMenuTap,
            onLoginTap: widget.onLoginTap,
          ),
          Expanded(
            child: _buildDetailContent(
              context: context,
              detail: detail,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailContent({
    required BuildContext context,
    required ServiceDetailEntity detail,
  }) {
    final showSubmissionStatus =
        _isBirthCertificate && _hasSubmittedApplication;

    final title = detail.nama.trim().isNotEmpty
        ? detail.nama.trim()
        : widget.serviceTitle;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BreadcrumbWidget(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            items: [
              const BreadcrumbItem(label: 'Beranda'),
              const BreadcrumbItem(label: 'Layanan Publik'),
              BreadcrumbItem(label: title),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (showSubmissionStatus)
                  _SubmittedServiceOverviewCard(
                    title: title,
                    submissionId: '1234567890',
                    onCopyTap: _copySubmissionId,
                    onShareTap: () {},
                  )
                else
                  ServiceDetailOverviewCard(
                    title: title,
                    status: detail.status,
                    updatedAt: detail.updatedAt,
                    onAccessTap: () {
                      _handleAccessService(
                        context,
                      );
                    },
                  ),
                const SizedBox(height: 24),
                ServiceDetailMainContent(
                  detail: detail,
                  onHealthFacilityTap: _isHealthDirectory
                      ? () {
                    _openServiceAccess(context);
                  }
                      : null,
                  onAccessServiceTap: _canAccessFromMainContent
                      ? () {
                    _handleAccessService(context);
                  }
                      : null,
                ),
                const Divider(height: 40, thickness: 0.4),
                ServiceDetailSupportSection(
                  detail: detail,
                ),
                const Divider(height: 40, thickness: 0.4),
                ServiceReviewRelatedSection(
                  showRelatedService: !_isBirthCertificate,
                ),
                const SizedBox(height: 52),
              ],
            ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }
}

class _SubmittedServiceOverviewCard extends StatelessWidget {
  final String title;
  final String submissionId;
  final VoidCallback onCopyTap;
  final VoidCallback onShareTap;

  const _SubmittedServiceOverviewCard({
    required this.title,
    required this.submissionId,
    required this.onCopyTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE1E4E8),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF252525),
              fontSize: 20,
              height: 1.3,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 7),
          const Row(
            children: [
              Icon(
                Icons.schedule_outlined,
                size: 14,
                color: Color(0xFF888888),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  'Terakhir diperbarui 25 Feb 2026',
                  style: TextStyle(
                    color: Color(0xFF777777),
                    fontSize: 11,
                  ),
                ),
              ),
              _ActiveBadge(),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 42,
            child: OutlinedButton.icon(
              onPressed: onShareTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF252525),
                side: const BorderSide(
                  color: Color(0xFFE1E4E8),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              icon: const Icon(
                Icons.share_outlined,
                size: 17,
              ),
              label: const Text(
                'Bagikan',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              border: Border.all(
                color: const Color(0xFFE6E6E6),
              ),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Pengajuan Anda',
                        style: TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    _SubmissionCheckBadge(),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      'ID: $submissionId',
                      style: const TextStyle(
                        color: Color(0xFF555555),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 7),
                    InkWell(
                      onTap: onCopyTap,
                      borderRadius: BorderRadius.circular(4),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3,
                          vertical: 2,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.copy_outlined,
                              size: 15,
                              color: Color(0xFF062F5E),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Salin',
                              style: TextStyle(
                                color: Color(0xFF062F5E),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  'Diajukan pada',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: Color(0xFF777777),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Rabu, 12 Feb 2026',
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const LinearProgressIndicator(
                    value: 0.5,
                    minHeight: 5,
                    backgroundColor: Color(0xFFE8EDF3),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF2D7FF0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Pemeriksaan oleh petugas.',
                        style: TextStyle(
                          color: Color(0xFF444444),
                          fontSize: 13.5,
                          height: 1.3,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      '2/4 tahap',
                      style: TextStyle(
                        color: Color(0xFF555555),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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
}

class _ActiveBadge extends StatelessWidget {
  const _ActiveBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE5F7E9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'Aktif',
        style: TextStyle(
          color: Color(0xFF25843A),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SubmissionCheckBadge extends StatelessWidget {
  const _SubmissionCheckBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFE9F2FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.check,
        size: 14,
        color: Color(0xFF5B9BFF),
      ),
    );
  }
}
