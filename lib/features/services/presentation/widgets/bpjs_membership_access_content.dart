import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bpjs_membership_widgets.dart';
import 'service_access_common_widgets.dart';

class BpjsMembershipAccessContent extends StatefulWidget {
  const BpjsMembershipAccessContent({super.key});

  @override
  State<BpjsMembershipAccessContent> createState() {
    return _BpjsMembershipAccessContentState();
  }
}

class _BpjsMembershipAccessContentState
    extends State<BpjsMembershipAccessContent> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedCategory = 'Semua';
  String _selectedSort = 'Terbaru';
  String _searchKeyword = '';

  final List<Map<String, dynamic>> _memberships = [
    {
      'name': 'Iwan Nur Setiyawan',
      'number': '000123456788911',
      'active': true,
      'membershipType': 'Peserta (Pegawai Swasta)',
      'group': 'PRB (Hypertensi, Penyakit Jantung)\nProlanis (Diabetes melitus)',
      'facility': 'Puskesmas Tanjung Priok',
      'updatedAt': 3,
    },
    {
      'name': 'Iwan Nur Setiyawan',
      'number': '000123456788912',
      'active': true,
      'membershipType': 'Peserta (Pegawai Swasta)',
      'group': 'PRB (Hypertensi, Penyakit Jantung)\nProlanis (Diabetes melitus)',
      'facility': 'Puskesmas Tanjung Priok',
      'updatedAt': 2,
    },
    {
      'name': 'Iwan Nur Setiyawan',
      'number': '000123456788913',
      'active': false,
      'inactiveReason': 'Tidak aktif karena premi',
      'membershipType': 'Peserta (Pegawai Swasta)',
      'group': '-',
      'facility': 'Puskesmas Tanjung Priok',
      'updatedAt': 1,
    },
  ];

  List<Map<String, dynamic>> get _filteredMemberships {
    final keyword = _searchKeyword.trim().toLowerCase();

    final result = _memberships.where((membership) {
      final isActive = membership['active'] == true;
      var categoryMatch = true;

      if (_selectedCategory == 'Aktif') {
        categoryMatch = isActive;
      } else if (_selectedCategory == 'Tidak aktif') {
        categoryMatch = !isActive;
      }

      if (!categoryMatch) {
        return false;
      }

      if (keyword.isEmpty) {
        return true;
      }

      final searchableText = [
        membership['name'],
        membership['number'],
        membership['membershipType'],
        membership['group'],
        membership['facility'],
      ].join(' ').toLowerCase();

      return searchableText.contains(keyword);
    }).toList();

    result.sort((a, b) {
      final first = a['updatedAt'] as int? ?? 0;
      final second = b['updatedAt'] as int? ?? 0;

      if (_selectedSort == 'Terlama') {
        return first.compareTo(second);
      }

      return second.compareTo(first);
    });

    return result;
  }

  int get _activeCount {
    return _memberships.where((item) => item['active'] == true).length;
  }

  int get _inactiveCount {
    return _memberships.where((item) => item['active'] != true).length;
  }

  void _applySearch() {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _searchKeyword = _searchController.text;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _searchKeyword = '';
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

  Future<void> _copyMembershipNumber(String number) async {
    await Clipboard.setData(
      ClipboardData(text: number),
    );

    if (!mounted) {
      return;
    }

    _showMessage('Nomor kepesertaan berhasil disalin.');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final memberships = _filteredMemberships;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: ServiceAccessBackButton(
              label: 'Kembali',
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Informasi Kepesertaan BPJS',
            style: TextStyle(
              fontSize: 20,
              height: 1.3,
              fontWeight: FontWeight.w700,
              color: Color(0xFF252525),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Berikut adalah informasi kepesertaan BPJS Anda.',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Kartu Keluarga',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF888888),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '3506152911101038',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF164775),
            ),
          ),
          const SizedBox(height: 24),
          BpjsMembershipSearchField(
            controller: _searchController,
            onSearch: _applySearch,
            onClear: _clearSearch,
          ),
          const SizedBox(height: 12),
          BpjsMembershipSortButton(
            selectedValue: _selectedSort,
            onSelected: (value) {
              setState(() {
                _selectedSort = value;
              });
            },
          ),
          const SizedBox(height: 14),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ServiceAccessCategoryChip(
                  label: 'Semua',
                  count: _memberships.length,
                  selected: _selectedCategory == 'Semua',
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'Semua';
                    });
                  },
                ),
                const SizedBox(width: 10),
                ServiceAccessCategoryChip(
                  label: 'Aktif',
                  count: _activeCount,
                  selected: _selectedCategory == 'Aktif',
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'Aktif';
                    });
                  },
                ),
                const SizedBox(width: 10),
                ServiceAccessCategoryChip(
                  label: 'Tidak aktif',
                  count: _inactiveCount,
                  selected: _selectedCategory == 'Tidak aktif',
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'Tidak aktif';
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          BpjsInformationBanner(
            onWhatsappTap: () {
              _showMessage('Membuka Whatsapp Pandawa.');
            },
            onCareCenterTap: () {
              _showMessage('Membuka BPJS Care Center.');
            },
          ),
          const SizedBox(height: 18),
          if (memberships.isEmpty)
            ServiceAccessSearchEmptyState(
              title: 'Data kepesertaan tidak ditemukan',
              description:
              'Tidak ada data kepesertaan yang sesuai dengan pencarian dan filter yang dipilih.',
              icon: const Icon(
                Icons.search_off_outlined,
                size: 23,
                color: Color(0xFF062F5E),
              ),
              boxed: true,
              height: 250,
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: memberships.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final membership = memberships[index];

                return BpjsMembershipCard(
                  membership: membership,
                  onCopyNumber: () {
                    _copyMembershipNumber(
                      membership['number'] as String? ?? '-',
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
