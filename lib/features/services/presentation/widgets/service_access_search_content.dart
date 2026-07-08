import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/widgets/app_pagination.dart';
import '../../../../shared/widgets/filter_chips_row.dart';
import '../../../../shared/widgets/filter_sort_row.dart';
import 'service_access_common_widgets.dart';
import '../../../../core/bloc/user_session/user_session_bloc.dart';
import '../../domain/entities/service_access_item_entity.dart';
import '../../domain/entities/service_access_type.dart';
import '../bloc/service_access_bloc.dart';
import '../bloc/service_access_event.dart';
import '../bloc/service_access_state.dart';
import 'service_access_result_cards.dart';

class ServiceAccessSearchConfig {
  final ServiceAccessSearchType type;
  final String subtitle;
  final String searchHint;
  final String emptyTitle;
  final String emptyDescription;
  final String categoryField;
  final List<String> searchFields;
  final String noResultItemLabel;
  final String noResultTitle;
  final double emptyStateHeight;

  const ServiceAccessSearchConfig({
    required this.type,
    required this.subtitle,
    required this.searchHint,
    required this.emptyTitle,
    required this.emptyDescription,
    required this.categoryField,
    required this.searchFields,
    required this.noResultItemLabel,
    required this.noResultTitle,
    required this.emptyStateHeight,
  });

  bool get isDoctor => type == ServiceAccessSearchType.doctor;
  bool get isBpomProductCheck => type == ServiceAccessSearchType.bpomProduct;
  bool get isHealthFacility => type == ServiceAccessSearchType.healthFacility;
}

ServiceAccessSearchConfig serviceAccessSearchConfigFromTitle(String serviceTitle) {
  if (serviceTitle == 'Cari Dokter') {
    return const ServiceAccessSearchConfig(
      type: ServiceAccessSearchType.doctor,
      subtitle: 'Temukan dokter sesuai dengan kebutuhan Anda.',
      searchHint: 'Cari dokter atau spesialis',
      emptyTitle: 'Temukan Dokter',
      emptyDescription: 'Lakukan pencarian dokter dengan memasukkan nama atau spesialisasi.',
      categoryField: 'specialization',
      searchFields: [
        'name',
        'registrationNumber',
        'specialization',
        'hospital',
        'city',
      ],
      noResultItemLabel: 'dokter',
      noResultTitle: 'Dokter tidak ditemukan',
      emptyStateHeight: 280,
    );
  }

  if (serviceTitle == 'Pengecekan Produk BPOM' ||
      serviceTitle == 'Cek Produk BPOM' ||
      serviceTitle == 'Mengecek Produk BPOM') {
    return const ServiceAccessSearchConfig(
      type: ServiceAccessSearchType.bpomProduct,
      subtitle: 'Cek apakah produk yang Anda gunakan sudah terdaftar, masih berlaku, dan aman sebelum dikonsumsi atau digunakan.',
      searchHint: 'Cari nama produk, merek, kode NIE, atau pendaftar',
      emptyTitle: 'Pengecekan Produk BPOM',
      emptyDescription: 'Masukkan nama produk, merek, kode NIE, atau nama pendaftar untuk mulai melakukan pengecekan.',
      categoryField: 'category',
      searchFields: [
        'productName',
        'registrationNumber',
        'brand',
        'type',
        'packaging',
        'registrant',
        'location',
        'category',
        'keywords',
      ],
      noResultItemLabel: 'produk',
      noResultTitle: 'Hasil tidak ditemukan',
      emptyStateHeight: 310,
    );
  }

  return const ServiceAccessSearchConfig(
    type: ServiceAccessSearchType.healthFacility,
    subtitle: 'Temukan fasilitas kesehatan yang sesuai dengan kebutuhan Anda.',
    searchHint: 'Cari fasilitas kesehatan',
    emptyTitle: 'Temukan Fasilitas Kesehatan',
    emptyDescription: 'Lakukan pencarian fasilitas kesehatan dengan memasukkan nama atau tipe faskes.',
    categoryField: 'jenis_sarana_name',
    searchFields: [
      'jenis_sarana_name',
      'jenis_sarana_kode',
      'nama',
      'kode_sarana',
      'kode_satu_sehat',
      'alamat',
      'telp',
      'email',
      'website',
      'type',
      'name',
      'address',
    ],
    noResultItemLabel: 'fasilitas',
    noResultTitle: 'Fasilitas tidak ditemukan',
    emptyStateHeight: 250,
  );
}

class ServiceAccessInitialIcon extends StatelessWidget {
  final ServiceAccessSearchType type;

  const ServiceAccessInitialIcon({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ServiceAccessSearchType.bpomProduct:
        return const ServiceAccessDocumentSearchIcon();
      case ServiceAccessSearchType.doctor:
        return const FaIcon(
          FontAwesomeIcons.stethoscope,
          size: 22,
          color: Color(0xFF062F5E),
        );
      case ServiceAccessSearchType.healthFacility:
        return const Icon(
          Icons.medical_services_outlined,
          size: 23,
          color: Color(0xFF062F5E),
        );
    }
  }
}

class ServiceAccessDocumentSearchIcon extends StatelessWidget {
  const ServiceAccessDocumentSearchIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34,
      height: 34,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            left: 2,
            top: 0,
            child: Icon(
              Icons.description_outlined,
              size: 30,
              color: Color(0xFF062F5E),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 2,
            child: Container(
              width: 17,
              height: 17,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search,
                size: 14,
                color: Color(0xFF062F5E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Data sementara untuk UI

const List<Map<String, dynamic>> serviceAccessMockDoctors = [

  {
    'name': 'Dr. Ahmad Wijaya, Sp.JP',
    'registrationNumber': '000/STR/098IV-2006/098765',
    'specialization': 'Spesialis Jantung',
    'schedule': 'Sen 07 Mei, 08:00 - 14:00 WIB',
    'detailSchedule': 'Senin - Jumat, 14:00 - 17:00',
    'status': 'Buka',
    'hospital': 'RS Graha Bunda',
    'city': 'Jakarta Pusat',
    'distance': '1,25 KM',
    'phone': '+62-21-12345678',
    'description':
    'Dr. Ahmad Wijaya, Sp.JP adalah seorang spesialis jantung '
        'berpengalaman dengan 15 tahun praktik di bidangnya. '
        'Lulus dari Universitas Indonesia, beliau telah menangani '
        'lebih dari 2.500 pasien dengan dedikasi tinggi dan '
        'profesionalisme.',
    'education': [
      {
        'degree': 'Spesialisasi Spesialis Jantung',
        'institution': 'Universitas Indonesia (2015)',
      },
      {
        'degree': 'Sarjana Kedokteran',
        'institution': 'Universitas Indonesia (2005)',
      },
    ],
  },
  {
    'name': 'Dr. Siti Nurhaliza, Sp.A',
    'registrationNumber': '000/STR/098IV-2006/098765',
    'specialization': 'Spesialis Anak',
    'schedule': 'Sen 07 Mei, 08:00 - 14:00 WIB',
    'detailSchedule': 'Senin - Sabtu, 08:00 - 14:00',
    'status': 'Buka',
    'hospital': 'Klinik Pratama Medika',
    'city': 'Jakarta Pusat',
    'distance': '2 KM',
    'phone': '+62-21-87654321',
    'description':
    'Dr. Siti Nurhaliza, Sp.A memberikan pelayanan kesehatan anak '
        'mulai dari pemeriksaan rutin, pemantauan tumbuh kembang, '
        'hingga penanganan berbagai keluhan kesehatan anak.',
    'education': [
      {
        'degree': 'Spesialisasi Ilmu Kesehatan Anak',
        'institution': 'Universitas Gadjah Mada (2017)',
      },
      {
        'degree': 'Sarjana Kedokteran',
        'institution': 'Universitas Gadjah Mada (2008)',
      },
    ],
  },
  {
    'name': 'Dr. Budi Santoso, Sp.OT',
    'registrationNumber': '000/STR/098IV-2006/098765',
    'specialization': 'Spesialis Ortopedi',
    'schedule': 'Sen 07 Mei, 08:00 - 14:00 WIB',
    'detailSchedule': 'Senin - Jumat, 08:00 - 14:00',
    'status': 'Buka',
    'hospital': 'RS Cipto Mangunkusumo',
    'city': 'Jakarta Pusat',
    'distance': '3,65 KM',
    'phone': '+62-21-31900001',
    'description':
    'Dr. Budi Santoso, Sp.OT merupakan dokter spesialis ortopedi '
        'yang menangani gangguan tulang, sendi, otot, serta '
        'pemulihan cedera sistem gerak.',
    'education': [
      {
        'degree': 'Spesialisasi Ortopedi dan Traumatologi',
        'institution': 'Universitas Airlangga (2016)',
      },
      {
        'degree': 'Sarjana Kedokteran',
        'institution': 'Universitas Airlangga (2007)',
      },
    ],
  },
  {
    'name': 'Dr. Maya Putri, Sp.PD',
    'registrationNumber': '001/STR/098IV-2008/118765',
    'specialization': 'Spesialis Penyakit Dalam',
    'schedule': 'Sel 08 Mei, 09:00 - 15:00 WIB',
    'detailSchedule': 'Selasa - Sabtu, 09:00 - 15:00',
    'status': 'Buka',
    'hospital': 'RS Metropolitan Medical Centre',
    'city': 'Jakarta Selatan',
    'distance': '4 KM',
    'phone': '+62-21-5203435',
    'description':
    'Dr. Maya Putri, Sp.PD menangani pemeriksaan dan perawatan '
        'berbagai penyakit pada pasien dewasa dengan pendekatan '
        'yang menyeluruh dan berorientasi pada kebutuhan pasien.',
    'education': [
      {
        'degree': 'Spesialisasi Penyakit Dalam',
        'institution': 'Universitas Indonesia (2018)',
      },
      {
        'degree': 'Sarjana Kedokteran',
        'institution': 'Universitas Padjadjaran (2009)',
      },
    ],
  },
  {
    'name': 'Dr. Rina Kurnia, Sp.M',
    'registrationNumber': '002/STR/098IV-2009/128765',
    'specialization': 'Spesialis Mata',
    'schedule': 'Rab 09 Mei, 10:00 - 16:00 WIB',
    'detailSchedule': 'Senin - Jumat, 10:00 - 16:00',
    'status': 'Buka',
    'hospital': 'RS Mata Jakarta Eye Center',
    'city': 'Jakarta Pusat',
    'distance': '4,8 KM',
    'phone': '+62-21-29221000',
    'description':
    'Dr. Rina Kurnia, Sp.M memberikan layanan pemeriksaan mata, '
        'konsultasi gangguan penglihatan, serta penanganan penyakit '
        'mata pada pasien anak dan dewasa.',
    'education': [
      {
        'degree': 'Spesialisasi Ilmu Kesehatan Mata',
        'institution': 'Universitas Indonesia (2019)',
      },
      {
        'degree': 'Sarjana Kedokteran',
        'institution': 'Universitas Trisakti (2010)',
      },
    ],
  },
  {
    'name': 'Dr. Fajar Ramadhan, Sp.KK',
    'registrationNumber': '003/STR/098IV-2010/138765',
    'specialization': 'Spesialis Kulit',
    'schedule': 'Kam 10 Mei, 08:00 - 13:00 WIB',
    'detailSchedule': 'Senin - Kamis, 08:00 - 13:00',
    'status': 'Buka',
    'hospital': 'RS Pondok Indah',
    'city': 'Jakarta Selatan',
    'distance': '5,1 KM',
    'phone': '+62-21-7657525',
    'description':
    'Dr. Fajar Ramadhan, Sp.KK menangani berbagai keluhan kulit '
        'dan kelamin, termasuk alergi, infeksi, perawatan kulit, '
        'dan edukasi pencegahan kekambuhan.',
    'education': [
      {
        'degree': 'Spesialisasi Kulit dan Kelamin',
        'institution': 'Universitas Indonesia (2020)',
      },
      {
        'degree': 'Sarjana Kedokteran',
        'institution': 'Universitas Diponegoro (2011)',
      },
    ],
  },
  {
    'name': 'Dr. Nadia Permata, Sp.A',
    'registrationNumber': '004/STR/098IV-2011/148765',
    'specialization': 'Spesialis Anak',
    'schedule': 'Jum 11 Mei, 09:00 - 14:00 WIB',
    'detailSchedule': 'Senin - Jumat, 09:00 - 14:00',
    'status': 'Buka',
    'hospital': 'RSIA Bunda Jakarta',
    'city': 'Jakarta Pusat',
    'distance': '5,7 KM',
    'phone': '+62-21-31922005',
    'description':
    'Dr. Nadia Permata, Sp.A berfokus pada kesehatan anak, '
        'pemantauan tumbuh kembang, imunisasi, dan konsultasi '
        'kesehatan keluarga.',
    'education': [
      {
        'degree': 'Spesialisasi Ilmu Kesehatan Anak',
        'institution': 'Universitas Indonesia (2020)',
      },
      {
        'degree': 'Sarjana Kedokteran',
        'institution': 'Universitas Indonesia (2011)',
      },
    ],
  },
  {
    'name': 'Dr. Reza Mahendra, Sp.JP',
    'registrationNumber': '005/STR/098IV-2012/158765',
    'specialization': 'Spesialis Jantung',
    'schedule': 'Sab 12 Mei, 08:00 - 12:00 WIB',
    'detailSchedule': 'Senin - Sabtu, 08:00 - 12:00',
    'status': 'Buka',
    'hospital': 'RS Jantung Harapan Kita',
    'city': 'Jakarta Barat',
    'distance': '6,2 KM',
    'phone': '+62-21-5684085',
    'description':
    'Dr. Reza Mahendra, Sp.JP memberikan layanan pemeriksaan '
        'jantung, evaluasi faktor risiko, dan pendampingan '
        'perawatan penyakit kardiovaskular.',
    'education': [
      {
        'degree': 'Spesialisasi Jantung dan Pembuluh Darah',
        'institution': 'Universitas Indonesia (2021)',
      },
      {
        'degree': 'Sarjana Kedokteran',
        'institution': 'Universitas Brawijaya (2012)',
      },
    ],
  },
  {
    'name': 'Dr. Intan Lestari, Sp.PD',
    'registrationNumber': '006/STR/098IV-2013/168765',
    'specialization': 'Spesialis Penyakit Dalam',
    'schedule': 'Sen 14 Mei, 13:00 - 18:00 WIB',
    'detailSchedule': 'Senin - Jumat, 13:00 - 18:00',
    'status': 'Buka',
    'hospital': 'RS Siloam Semanggi',
    'city': 'Jakarta Selatan',
    'distance': '6,8 KM',
    'phone': '+62-21-29962888',
    'description':
    'Dr. Intan Lestari, Sp.PD menangani pemeriksaan penyakit '
        'dalam, pengelolaan penyakit kronis, serta edukasi '
        'kesehatan bagi pasien dewasa.',
    'education': [
      {
        'degree': 'Spesialisasi Penyakit Dalam',
        'institution': 'Universitas Padjadjaran (2021)',
      },
      {
        'degree': 'Sarjana Kedokteran',
        'institution': 'Universitas Padjadjaran (2012)',
      },
    ],
  },
  {
    'name': 'Dr. Arif Hidayat, Sp.OT',
    'registrationNumber': '007/STR/098IV-2014/178765',
    'specialization': 'Spesialis Ortopedi',
    'schedule': 'Sel 15 Mei, 10:00 - 16:00 WIB',
    'detailSchedule': 'Selasa - Sabtu, 10:00 - 16:00',
    'status': 'Buka',
    'hospital': 'RS Fatmawati',
    'city': 'Jakarta Selatan',
    'distance': '7,4 KM',
    'phone': '+62-21-7501524',
    'description':
    'Dr. Arif Hidayat, Sp.OT memberikan pelayanan ortopedi untuk '
        'cedera olahraga, gangguan sendi, serta masalah tulang '
        'dan otot pada pasien dewasa.',
    'education': [
      {
        'degree': 'Spesialisasi Ortopedi dan Traumatologi',
        'institution': 'Universitas Indonesia (2022)',
      },
      {
        'degree': 'Sarjana Kedokteran',
        'institution': 'Universitas Hasanuddin (2013)',
      },
    ],
  },
];

const List<Map<String, dynamic>> serviceAccessMockBpomProducts = [
  {
    'productName': 'Nama Produk',
    'registrationNumber': 'NA-123456789012',
    'issuedDate': '08 Mei 2025',
    'validUntil': '08 Mei 2031',
    'brand': 'Merek',
    'type': 'Tipe',
    'packaging': 'Kemasan',
    'registrant': 'Rohto Laboratories Indonesia, PT',
    'location': 'Kota Adm, Jakarta Barat, DKI Jakarta, Indonesia',
    'category': 'Kosmetik',
    'keywords': 'selsun kosmetik shampoo produk bpom na-123456789012 rohto',
  },
  {
    'productName': 'Nama Produk',
    'registrationNumber': 'NA-123456789012',
    'issuedDate': '08 Mei 2025',
    'validUntil': '08 Mei 2031',
    'brand': 'Merek',
    'type': 'Tipe',
    'packaging': 'Kemasan',
    'registrant': 'Rohto Laboratories Indonesia, PT',
    'location': 'Kota Adm, Jakarta Barat, DKI Jakarta, Indonesia',
    'category': 'Kosmetik',
    'keywords': 'selsun kosmetik shampoo produk bpom na-123456789012 rohto',
  },
];

List<Map<String, dynamic>> getServiceAccessMockItems(ServiceAccessSearchType type) {
  switch (type) {
    case ServiceAccessSearchType.bpomProduct:
      return serviceAccessMockBpomProducts;
    case ServiceAccessSearchType.doctor:
      return serviceAccessMockDoctors;
    case ServiceAccessSearchType.healthFacility:
      return const <Map<String, dynamic>>[];
  }
}

class ServiceAccessSearchContent extends StatefulWidget {
  final String serviceTitle;
  final ValueChanged<Map<String, dynamic>> onItemTap;

  const ServiceAccessSearchContent({
    super.key,
    required this.serviceTitle,
    required this.onItemTap,
  });

  @override
  State<ServiceAccessSearchContent> createState() {
    return _ServiceAccessSearchContentState();
  }
}

class _ServiceAccessSearchContentState extends State<ServiceAccessSearchContent> {
  static const int _defaultPageSize = 3;
  static const int _fasyankesPageSize = 5;

  final TextEditingController _searchController = TextEditingController();

  bool _hasSearched = false;
  String _searchKeyword = '';
  String _selectedCategory = 'Semua';
  int _currentPage = 1;

  ServiceAccessSearchConfig get _config {
    return serviceAccessSearchConfigFromTitle(widget.serviceTitle);
  }

  int get _pageSize {
    return _config.isHealthFacility ? _fasyankesPageSize : _defaultPageSize;
  }

  List<Map<String, dynamic>> get _sourceItems {
    if (_config.isHealthFacility) {
      return const <Map<String, dynamic>>[];
    }

    return getServiceAccessMockItems(_config.type);
  }

  List<Map<String, dynamic>> get _searchMatchedItems {
    final keyword = _searchKeyword.trim().toLowerCase();

    if (keyword.isEmpty) {
      return List<Map<String, dynamic>>.from(_sourceItems);
    }

    return _sourceItems.where((item) {
      return _config.searchFields.any((field) {
        final value = item[field]?.toString().toLowerCase() ?? '';
        return value.contains(keyword);
      });
    }).toList();
  }

  List<Map<String, dynamic>> get _filteredItems {
    return _filterItemsByCategory(_searchMatchedItems);
  }

  List<Map<String, dynamic>> _filterItemsByCategory(
      List<Map<String, dynamic>> source,
      ) {
    if (_selectedCategory == 'Semua') {
      return source;
    }

    return source.where((item) {
      return item[_config.categoryField]?.toString() == _selectedCategory;
    }).toList();
  }

  List<String> _categoriesFromItems(List<Map<String, dynamic>> items) {
    final categories = <String>['Semua'];

    for (final item in items) {
      final category = item[_config.categoryField]?.toString() ?? '';

      if (category.isNotEmpty && !categories.contains(category)) {
        categories.add(category);
      }
    }

    return categories;
  }

  int _getCategoryCount(
      String category,
      List<Map<String, dynamic>> items,
      ) {
    if (category == 'Semua') {
      return items.length;
    }

    return items.where((item) {
      return item[_config.categoryField]?.toString() == category;
    }).length;
  }

  List<Map<String, dynamic>> _facilityItemsFromState(ServiceAccessState state) {
    return state.items.map((ServiceAccessItemEntity item) => item.toMap()).toList();
  }

  String _sessionToken() {
    return context.read<UserSessionBloc>().state.token;
  }

  void _search() {
    final keyword = _searchController.text.trim();

    if (keyword.isEmpty && !_config.isHealthFacility) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    if (_config.isHealthFacility) {
      setState(() {
        _hasSearched = true;
        _searchKeyword = keyword;
        _selectedCategory = 'Semua';
        _currentPage = 1;
      });

      context.read<ServiceAccessBloc>().add(
        ServiceAccessSearchRequested(
          type: _config.type,
          token: _sessionToken(),
          page: 1,
          limit: _pageSize,
          query: keyword,
        ),
      );
      return;
    }

    setState(() {
      _hasSearched = true;
      _searchKeyword = keyword;
      _selectedCategory = 'Semua';
      _currentPage = 1;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    FocusManager.instance.primaryFocus?.unfocus();

    if (_config.isHealthFacility) {
      context.read<ServiceAccessBloc>().add(const ServiceAccessSearchCleared());
    }

    setState(() {
      _hasSearched = false;
      _searchKeyword = '';
      _selectedCategory = 'Semua';
      _currentPage = 1;
    });
  }

  void _selectCategory(String category) {
    if (_selectedCategory == category) {
      return;
    }

    setState(() {
      _selectedCategory = category;
      _currentPage = 1;
    });
  }

  void _changePage(int page, int pageCount) {
    if (page < 1 || page > pageCount || page == _currentPage) {
      return;
    }

    setState(() {
      _currentPage = page;
    });
  }

  void _retryFacilitySearch() {
    setState(() {
      _currentPage = 1;
    });

    context.read<ServiceAccessBloc>().add(
      ServiceAccessSearchRequested(
        type: _config.type,
        token: _sessionToken(),
        page: 1,
        limit: _pageSize,
        query: _searchKeyword,
      ),
    );
  }

  void _copyRegistrationNumber(String registrationNumber) {
    Clipboard.setData(
      ClipboardData(text: registrationNumber),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nomor STR berhasil disalin'),
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
    final config = _config;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ServiceAccessBackButton(
            label: 'Kembali',
          ),
          const SizedBox(height: 32),
          Text(
            widget.serviceTitle,
            style: const TextStyle(
              fontSize: 24,
              height: 1.3,
              fontWeight: FontWeight.w700,
              color: Color(0xFF252525),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            config.subtitle,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 24),
          ServiceAccessSearchBox(
            controller: _searchController,
            hintText: config.searchHint,
            onSearch: _search,
            onClear: _clearSearch,
          ),
          const SizedBox(height: 28),
          if (config.isHealthFacility)
            BlocBuilder<ServiceAccessBloc, ServiceAccessState>(
              builder: (context, state) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: _hasSearched
                      ? _buildSearchResult(config, state)
                      : ServiceAccessSearchEmptyState(
                    key: ValueKey('directory-empty-${widget.serviceTitle}'),
                    title: config.emptyTitle,
                    description: config.emptyDescription,
                    icon: ServiceAccessInitialIcon(type: config.type),
                    height: config.emptyStateHeight,
                  ),
                );
              },
            )
          else
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _hasSearched
                  ? _buildSearchResult(config)
                  : ServiceAccessSearchEmptyState(
                key: ValueKey('directory-empty-${widget.serviceTitle}'),
                title: config.emptyTitle,
                description: config.emptyDescription,
                icon: ServiceAccessInitialIcon(type: config.type),
                height: config.emptyStateHeight,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchResult(
      ServiceAccessSearchConfig config, [
        ServiceAccessState? fasyankesState,
      ]) {
    if (config.isHealthFacility && fasyankesState?.isLoadingList == true) {
      return _buildLoadingState();
    }

    if (config.isHealthFacility && fasyankesState?.hasSearched != true) {
      return _buildLoadingState();
    }

    if (config.isHealthFacility && fasyankesState?.hasListError == true) {
      return _buildErrorState(fasyankesState!.listErrorMessage);
    }

    final sourceItems = config.isHealthFacility
        ? _facilityItemsFromState(fasyankesState ?? ServiceAccessState.initial())
        : _searchMatchedItems;
    final items = config.isHealthFacility
        ? _filterItemsByCategory(sourceItems)
        : _filteredItems;
    final pageCount = max(1, (items.length / _pageSize).ceil());
    final safePage = min(_currentPage, pageCount);
    final startIndex = (safePage - 1) * _pageSize;
    final endIndex = min(startIndex + _pageSize, items.length);
    final visibleItems = items.isEmpty
        ? <Map<String, dynamic>>[]
        : items.sublist(startIndex, endIndex);

    if (config.isBpomProductCheck && _searchMatchedItems.isEmpty) {
      return _buildNoResultState(config);
    }

    return Column(
      key: ValueKey('directory-result-${widget.serviceTitle}'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Menampilkan hasil pencarian untuk',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF777777),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _searchKeyword.isEmpty ? 'Semua fasilitas kesehatan' : _searchKeyword,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF252525),
          ),
        ),
        const SizedBox(height: 18),
        FilterSortRow(
          sortLabel: 'Terbaru',
          onFilterTap: () {},
          onSortTap: () {},
        ),
        const SizedBox(height: 18),
        _buildCategoryList(sourceItems),
        const SizedBox(height: 8),
        if (visibleItems.isEmpty)
          _buildNoResultState(config)
        else
          ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: visibleItems.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return ServiceAccessResultCard(
                type: config.type,
                item: visibleItems[index],
                onItemTap: widget.onItemTap,
                onCopyRegistrationNumber: _copyRegistrationNumber,
              );
            },
          ),
        if (visibleItems.isNotEmpty && pageCount > 1) ...[
          const SizedBox(height: 24),
          AppPagination(
            currentPage: safePage,
            totalPages: pageCount,
            onPageChanged: (page) => _changePage(page, pageCount),
          ),
        ],
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      key: ValueKey('facility-loading-state'),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 70),
        child: CircularProgressIndicator(
          color: Color(0xFF062F5E),
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      key: const ValueKey('facility-error-state'),
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E5E5)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gagal memuat fasilitas kesehatan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF252525),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton.icon(
              onPressed: _retryFacilitySearch,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Coba lagi'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF062F5E),
                side: const BorderSide(color: Color(0xFFE0E0E0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList(List<Map<String, dynamic>> sourceItems) {
    final categories = _categoriesFromItems(sourceItems);

    return FilterChipsRow(
      chips: categories.map((category) {
        return FilterChipItem(
          key: category,
          label: category,
          count: _getCategoryCount(category, sourceItems),
        );
      }).toList(),
      selectedKey: _selectedCategory,
      onSelected: _selectCategory,
    );
  }

  Widget _buildNoResultState(ServiceAccessSearchConfig config) {
    if (config.isBpomProductCheck) {
      return const ServiceAccessSearchEmptyState(
        key: ValueKey('bpom-no-result-state'),
        title: 'Hasil tidak ditemukan',
        description: 'Gunakan kata kunci pencarian lainnya.',
        icon: Icon(
          Icons.search,
          size: 26,
          color: Color(0xFF062F5E),
        ),
        height: 330,
      );
    }

    return ServiceAccessSearchEmptyState(
      key: ValueKey(
        'directory-no-result-${widget.serviceTitle}-$_selectedCategory-$_searchKeyword',
      ),
      title: config.noResultTitle,
      description:
      'Tidak ada ${config.noResultItemLabel} pada kategori $_selectedCategory yang sesuai dengan pencarian.',
      icon: const Icon(
        Icons.search_off_outlined,
        size: 23,
        color: Color(0xFF062F5E),
      ),
      boxed: true,
      height: 250,
    );
  }
}
