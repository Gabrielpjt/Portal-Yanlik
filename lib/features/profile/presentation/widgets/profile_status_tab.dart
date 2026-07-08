import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../shared/widgets/filter_chips_row.dart';
import '../../../../shared/widgets/filter_sort_row.dart';
import '../../../services/presentation/pages/service_detail_page.dart';

class ProfileSubmissionStatus {
  final String title;
  final String submissionId;
  final String submittedAt;
  final String status;
  final int currentStep;
  final int totalStep;
  final bool isCompleted;

  const ProfileSubmissionStatus({
    required this.title,
    required this.submissionId,
    required this.submittedAt,
    required this.status,
    required this.currentStep,
    required this.totalStep,
    this.isCompleted = false,
  });
}

class ProfileStatusStore {
  static final ValueNotifier<List<ProfileSubmissionStatus>> submissions =
  ValueNotifier<List<ProfileSubmissionStatus>>([]);

  static void addBirthCertificateSubmission() {
    const submissionId = 'AKT-12345678-745';

    final alreadyExists = submissions.value.any(
          (item) => item.submissionId == submissionId,
    );

    if (alreadyExists) {
      return;
    }

    submissions.value = [
      const ProfileSubmissionStatus(
        title: 'Penerbitan Akta Kelahiran',
        submissionId: submissionId,
        submittedAt: '1 jam lalu',
        status: 'Pemeriksaan Dokumen',
        currentStep: 2,
        totalStep: 4,
      ),
      ...submissions.value,
    ];
  }

  static void clear() {
    submissions.value = [];
  }
}

class ProfileStatusTab extends StatefulWidget {
  final VoidCallback? onMenuTap;

  const ProfileStatusTab({
    super.key,
    this.onMenuTap,
  });

  @override
  State<ProfileStatusTab> createState() {
    return _ProfileStatusTabState();
  }
}

class _ProfileStatusTabState extends State<ProfileStatusTab> {
  final TextEditingController _searchController =
  TextEditingController();

  String _searchKeyword = '';
  String _selectedCategory = 'Semua';

  List<ProfileSubmissionStatus> _filterSubmissions(
      List<ProfileSubmissionStatus> submissions,
      ) {
    Iterable<ProfileSubmissionStatus> results = submissions;

    final keyword = _searchKeyword.trim().toLowerCase();

    if (keyword.isNotEmpty) {
      results = results.where((submission) {
        return submission.title.toLowerCase().contains(keyword) ||
            submission.submissionId.toLowerCase().contains(keyword) ||
            submission.status.toLowerCase().contains(keyword);
      });
    }

    if (_selectedCategory == 'Sedang Proses') {
      results = results.where(
            (submission) => !submission.isCompleted,
      );
    }

    if (_selectedCategory == 'Selesai') {
      results = results.where(
            (submission) => submission.isCompleted,
      );
    }

    return results.toList();
  }

  int _getCategoryCount(
      List<ProfileSubmissionStatus> submissions,
      String category,
      ) {
    if (category == 'Sedang Proses') {
      return submissions.where((item) {
        return !item.isCompleted;
      }).length;
    }

    if (category == 'Selesai') {
      return submissions.where((item) {
        return item.isCompleted;
      }).length;
    }

    return submissions.length;
  }

  void _openServiceDetail(
      ProfileSubmissionStatus submission,
      ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ServiceDetailPage(
          serviceTitle: submission.title,
          isLoggedIn: true,
          onMenuTap: widget.onMenuTap,
          initialHasSubmittedApplication: true,
        ),
      ),
    );
  }

  Future<void> _copySubmissionId(
      String submissionId,
      ) async {
    await Clipboard.setData(
      ClipboardData(
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ProfileSubmissionStatus>>(
      valueListenable: ProfileStatusStore.submissions,
      builder: (context, submissions, child) {
        if (submissions.isEmpty) {
          return const _ProfileEmptyStatus();
        }

        final visibleSubmissions = _filterSubmissions(
          submissions,
        );

        return Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(
            16,
            16,
            16,
            24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchKeyword = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Cari status',
                  hintStyle: const TextStyle(
                    color: Color(0xFFAAAAAA),
                    fontSize: 12,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 18,
                    color: Color(0xFFAAAAAA),
                  ),
                  suffixIcon: _searchKeyword.isEmpty
                      ? null
                      : IconButton(
                    onPressed: () {
                      _searchController.clear();

                      setState(() {
                        _searchKeyword = '';
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 17,
                    ),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: const BorderSide(
                      color: Color(0xFFE1E4E8),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: const BorderSide(
                      color: AppColors.guide600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              const FilterSortRow(
                sortLabel: 'Terbaru',
              ),

              const SizedBox(height: 14),

              FilterChipsRow(
                chips: [
                  FilterChipItem(
                    key: 'Semua',
                    label: 'Semua',
                    count: _getCategoryCount(
                      submissions,
                      'Semua',
                    ),
                  ),
                  FilterChipItem(
                    key: 'Sedang Proses',
                    label: 'Sedang Proses',
                    count: _getCategoryCount(
                      submissions,
                      'Sedang Proses',
                    ),
                  ),
                  FilterChipItem(
                    key: 'Selesai',
                    label: 'Selesai',
                    count: _getCategoryCount(
                      submissions,
                      'Selesai',
                    ),
                  ),
                ],
                selectedKey: _selectedCategory,
                onSelected: (key) {
                  setState(() {
                    _selectedCategory = key;
                  });
                },
              ),

              const SizedBox(height: 16),

              const Text(
                'Hari ini',
                style: TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              if (visibleSubmissions.isEmpty)
                const _ProfileStatusNotFound()
              else
                ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: visibleSubmissions.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 12);
                  },
                  itemBuilder: (context, index) {
                    final submission = visibleSubmissions[index];

                    return _SubmissionStatusCard(
                      submission: submission,
                      onTap: () {
                        _openServiceDetail(submission);
                      },
                      onCopyTap: () {
                        _copySubmissionId(
                          submission.submissionId,
                        );
                      },
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileEmptyStatus extends StatelessWidget {
  const _ProfileEmptyStatus();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 48,
              color: AppColors.contentSecondary.withValues(
                alpha: 0.4,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Informasi status belum tersedia',
              style: TextStyle(
                color: AppColors.contentSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileStatusNotFound extends StatelessWidget {
  const _ProfileStatusNotFound();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 160,
      child: Center(
        child: Text(
          'Status tidak ditemukan',
          style: TextStyle(
            color: AppColors.contentSecondary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _SubmissionStatusCard extends StatelessWidget {
  final ProfileSubmissionStatus submission;
  final VoidCallback onTap;
  final VoidCallback onCopyTap;

  const _SubmissionStatusCard({
    required this.submission,
    required this.onTap,
    required this.onCopyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFE3E6EA),
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
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F5F7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.badge_outlined,
                      size: 17,
                      color: AppColors.brandPrimary,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 34,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: submission.isCompleted
                          ? const Color(0xFFE6F6E9)
                          : const Color(0xFFEAF2FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      submission.isCompleted
                          ? Icons.check
                          : Icons.sync,
                      size: 13,
                      color: submission.isCompleted
                          ? const Color(0xFF258A3D)
                          : const Color(0xFF4F95FF),
                    ),
                  ),
                  const SizedBox(width: 9),
                  const Icon(
                    Icons.north_east,
                    size: 16,
                    color: AppColors.brandPrimary,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                submission.title,
                style: const TextStyle(
                  color: Color(0xFF252525),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    submission.submissionId,
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
                            size: 13,
                            color: AppColors.brandPrimary,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Salin',
                            style: TextStyle(
                              color: AppColors.brandPrimary,
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
              const SizedBox(height: 12),
              const Text(
                'Diajukan pada',
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 12,
                    color: Color(0xFF777777),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    submission.submittedAt,
                    style: const TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: submission.currentStep /
                      submission.totalStep,
                  minHeight: 5,
                  backgroundColor: const Color(0xFFE9EDF2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    submission.isCompleted
                        ? const Color(0xFF258A3D)
                        : const Color(0xFF2B7CF0),
                  ),
                ),
              ),
              const SizedBox(height: 9),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      submission.status,
                      style: const TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    '${submission.currentStep}/'
                        '${submission.totalStep} tahap',
                    style: const TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}