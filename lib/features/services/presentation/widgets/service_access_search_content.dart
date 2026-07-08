import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'service_access_common_widgets.dart';

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

class _ServiceAccessSearchContentState
    extends State<ServiceAccessSearchContent> {
  static const int _pageSize = 3;

  final TextEditingController _searchController = TextEditingController();

  bool _hasSearched = false;
  String _searchKeyword = '';
  String _selectedCategory = 'Semua';
  int _currentPage = 1;

  bool get _isDoctor => widget.serviceTitle == 'Cari Dokter';

  final List<Map<String, dynamic>> _doctors = [

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

  final List<Map<String, dynamic>> _facilities = [

    {
      'type': 'Rumah Sakit',
      'name': 'RS Graha Bunda',
      'address': 'Jl. Sudirman No. 123, Jakarta Pusat',
      'distance': '1,25 KM',
      'phone': '+62-21-12345678',
      'bpjs': true,
      'description':
      'RS Graha Bunda adalah rumah sakit umum modern yang telah '
          'melayani masyarakat Jakarta sejak tahun 2005. Dilengkapi '
          'dengan peralatan medis canggih dan tenaga medis profesional, '
          'kami berkomitmen memberikan pelayanan kesehatan terbaik '
          'dengan fasilitas rawat inap kelas VIP hingga kelas 3, unit '
          'gawat darurat 24 jam, serta berbagai poliklinik spesialis.',
      'operationalHours': 'Senin - Minggu: 24 Jam',
      'services': [
        'Umum',
        'Kardiologi',
        'Ortopedi',
        'Pediatri',
      ],
    },
    {
      'type': 'Klinik',
      'name': 'Klinik Pratama Medika',
      'address': 'Jl. Gatot Subroto No. 45, Jakarta Selatan',
      'distance': '2 KM',
      'phone': '+62-21-12345678',
      'bpjs': false,
      'description':
      'Klinik Pratama Medika menyediakan layanan kesehatan dasar '
          'bagi masyarakat dengan dukungan dokter dan tenaga kesehatan '
          'yang profesional. Klinik melayani pemeriksaan umum, kesehatan '
          'gigi, pemeriksaan laboratorium, dan konsultasi kesehatan.',
      'operationalHours': 'Senin - Sabtu: 08.00 - 21.00',
      'services': [
        'Umum',
        'Gigi',
        'Laboratorium',
      ],
    },
    {
      'type': 'Rumah Sakit',
      'name': 'RS Cipto Mangunkusumo',
      'address': 'Jl. Diponegoro No. 71, Jakarta Pusat',
      'distance': '3,65 KM',
      'phone': '+62-21-31900001',
      'bpjs': true,
      'description':
      'RS Cipto Mangunkusumo menyediakan berbagai pelayanan '
          'kesehatan umum dan spesialis dengan dukungan fasilitas '
          'medis, tenaga kesehatan profesional, dan pelayanan '
          'kegawatdaruratan selama 24 jam.',
      'operationalHours': 'Senin - Minggu: 24 Jam',
      'services': [
        'Umum',
        'Penyakit Dalam',
        'Bedah',
        'Kardiologi',
      ],
    },
  ];

  List<Map<String, dynamic>> get _sourceItems {
    return _isDoctor ? _doctors : _facilities;
  }

  String get _subtitle {
    return _isDoctor
        ? 'Temukan dokter sesuai dengan kebutuhan Anda.'
        : 'Temukan fasilitas kesehatan yang sesuai dengan kebutuhan Anda.';
  }

  String get _searchHint {
    return _isDoctor
        ? 'Masukkan nama dokter atau spesialisasi'
        : 'Masukkan nama fasilitas kesehatan';
  }

  String get _emptyTitle {
    return _isDoctor
        ? 'Pencarian Dokter'
        : 'Pencarian Fasilitas Kesehatan';
  }

  String get _emptyDescription {
    return _isDoctor
        ? 'Lakukan pencarian dokter dengan\nmemasukkan nama atau spesialisasi.'
        : 'Lakukan pencarian fasilitas kesehatan dengan\nmemasukkan nama atau tipe faskes.';
  }

  Widget get _emptyIcon {
    if (_isDoctor) {
      return const FaIcon(
        FontAwesomeIcons.stethoscope,
        size: 22,
        color: Color(0xFF062F5E),
      );
    }

    return const Icon(
      Icons.medical_services_outlined,
      size: 23,
      color: Color(0xFF062F5E),
    );
  }

  String get _categoryField {
    return _isDoctor ? 'specialization' : 'type';
  }

  List<String> get _searchFields {
    if (_isDoctor) {
      return const [
        'name',
        'registrationNumber',
        'specialization',
        'hospital',
        'city',
      ];
    }

    return const [
      'type',
      'name',
      'address',
    ];
  }

  List<Map<String, dynamic>> get _searchMatchedItems {
    final keyword = _searchKeyword.trim().toLowerCase();

    if (keyword.isEmpty) {
      return List<Map<String, dynamic>>.from(_sourceItems);
    }

    return _sourceItems.where((item) {
      return _searchFields.any((field) {
        final value = item[field]?.toString().toLowerCase() ?? '';
        return value.contains(keyword);
      });
    }).toList();
  }

  List<Map<String, dynamic>> get _filteredItems {
    if (_selectedCategory == 'Semua') {
      return _searchMatchedItems;
    }

    return _searchMatchedItems.where((item) {
      return item[_categoryField] == _selectedCategory;
    }).toList();
  }

  List<String> get _categories {
    final categories = <String>['Semua'];

    for (final item in _searchMatchedItems) {
      final category = item[_categoryField]?.toString() ?? '';

      if (category.isNotEmpty && !categories.contains(category)) {
        categories.add(category);
      }
    }

    return categories;
  }

  int _getCategoryCount(String category) {
    if (category == 'Semua') {
      return _searchMatchedItems.length;
    }

    return _searchMatchedItems.where((item) {
      return item[_categoryField] == category;
    }).length;
  }

  void _search() {
    final keyword = _searchController.text.trim();

    if (keyword.isEmpty) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _searchKeyword = keyword;
      _selectedCategory = 'Semua';
      _currentPage = 1;
      _hasSearched = true;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _searchKeyword = '';
      _selectedCategory = 'Semua';
      _currentPage = 1;
      _hasSearched = false;
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

  void _copyRegistrationNumber(String registrationNumber) {
    Clipboard.setData(
      ClipboardData(text: registrationNumber),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nomor STR berhasil disalin.'),
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
            _subtitle,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 24),
          ServiceAccessSearchBox(
            controller: _searchController,
            hintText: _searchHint,
            onSearch: _search,
            onClear: _clearSearch,
          ),
          const SizedBox(height: 28),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _hasSearched
                ? _buildSearchResult()
                : ServiceAccessSearchEmptyState(
              key: ValueKey('directory-empty-${widget.serviceTitle}'),
              title: _emptyTitle,
              description: _emptyDescription,
              icon: _emptyIcon,
              height: _isDoctor ? 280 : 250,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResult() {
    final items = _filteredItems;
    final pageCount = max(1, (items.length / _pageSize).ceil());
    final safePage = min(_currentPage, pageCount);
    final startIndex = (safePage - 1) * _pageSize;
    final endIndex = min(startIndex + _pageSize, items.length);
    final visibleItems = items.isEmpty
        ? <Map<String, dynamic>>[]
        : items.sublist(startIndex, endIndex);

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
          _searchKeyword,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF252525),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: ServiceAccessSearchActionButton(
                label: 'Filter',
                icon: Icons.filter_alt_outlined,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ServiceAccessSearchActionButton(
                label: 'Terbaru',
                icon: Icons.keyboard_arrow_down,
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _buildCategoryList(),
        const SizedBox(height: 8),
        if (visibleItems.isEmpty)
          _buildNoResultState()
        else
          ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: visibleItems.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return _buildResultCard(visibleItems[index]);
            },
          ),
        if (visibleItems.isNotEmpty && pageCount > 1) ...[
          const SizedBox(height: 24),
          _buildPagination(pageCount),
        ],
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCategoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int index = 0; index < _categories.length; index++) ...[
            ServiceAccessCategoryChip(
              label: _categories[index],
              count: _getCategoryCount(_categories[index]),
              selected: _selectedCategory == _categories[index],
              onTap: () {
                _selectCategory(_categories[index]);
              },
            ),
            if (index != _categories.length - 1)
              const SizedBox(width: 10),
          ],
        ],
      ),
    );
  }

  Widget _buildNoResultState() {
    final itemLabel = _isDoctor ? 'dokter' : 'fasilitas';
    final title = _isDoctor
        ? 'Dokter tidak ditemukan'
        : 'Fasilitas tidak ditemukan';

    return ServiceAccessSearchEmptyState(
      key: ValueKey(
        'directory-no-result-${widget.serviceTitle}-$_selectedCategory-$_searchKeyword',
      ),
      title: title,
      description:
      'Tidak ada $itemLabel pada kategori $_selectedCategory yang sesuai dengan pencarian.',
      icon: const Icon(
        Icons.search_off_outlined,
        size: 23,
        color: Color(0xFF062F5E),
      ),
      boxed: true,
      height: 250,
    );
  }

  Widget _buildResultCard(Map<String, dynamic> item) {
    if (_isDoctor) {
      return _buildDoctorCard(item);
    }

    return _buildFacilityCard(item);
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    final registrationNumber = doctor['registrationNumber'] as String? ?? '-';

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          widget.onItemTap(doctor);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFE5E5E5),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.stethoscope,
                        size: 19,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.north_east,
                    size: 17,
                    color: Color(0xFF062F5E),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'Tenaga Medis',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF777777),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                doctor['name'] as String? ?? '-',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF164775),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Surat Tanda Registrasi',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF777777),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      registrationNumber,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF164775),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _copyRegistrationNumber(registrationNumber);
                    },
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 30,
                      minHeight: 30,
                    ),
                    icon: const Icon(
                      Icons.copy_outlined,
                      size: 17,
                      color: Color(0xFF164775),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'Spesialis',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF777777),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                doctor['specialization'] as String? ?? '-',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF164775),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Jadwal Praktik',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF777777),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      doctor['schedule'] as String? ?? '-',
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF164775),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9F8E9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      doctor['status'] as String? ?? '-',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2E9E4F),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'Tempat Praktik',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF777777),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor['hospital'] as String? ?? '-',
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.4,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF164775),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          doctor['city'] as String? ?? '-',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFAAAAAA),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                    color: Color(0xFFAAAAAA),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'No. Telepon',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF777777),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      doctor['phone'] as String? ?? '-',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF164775),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.phone_outlined,
                    size: 19,
                    color: Color(0xFFAAAAAA),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFacilityCard(Map<String, dynamic> facility) {
    final acceptsBpjs = facility['bpjs'] == true;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          widget.onItemTap(facility);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFE5E5E5),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.hospital,
                        size: 20,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.north_east,
                    size: 17,
                    color: Color(0xFF062F5E),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                facility['type'] as String? ?? '-',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF777777),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      facility['name'] as String? ?? '-',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF062F5E),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: acceptsBpjs
                          ? const Color(0xFFEAF3FF)
                          : const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      acceptsBpjs ? 'BPJS' : 'Non BPJS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: acceptsBpjs
                            ? const Color(0xFF2471D9)
                            : const Color(0xFF444444),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Alamat',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF777777),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      facility['address'] as String? ?? '-',
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF164775),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                    color: Color(0xFFAAAAAA),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                facility['distance'] as String? ?? '-',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2E9E4F),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'No. Telepon',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF777777),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      facility['phone'] as String? ?? '-',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF164775),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.phone_outlined,
                    size: 19,
                    color: Color(0xFFAAAAAA),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPagination(int pageCount) {
    final visiblePages = <int>{
      1,
      pageCount,
      _currentPage - 1,
      _currentPage,
      _currentPage + 1,
    }.where((page) => page >= 1 && page <= pageCount).toList()
      ..sort();

    final pageWidgets = <Widget>[];

    for (int index = 0; index < visiblePages.length; index++) {
      final page = visiblePages[index];

      if (index > 0 && page - visiblePages[index - 1] > 1) {
        pageWidgets.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '...',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
          ),
        );
      }

      pageWidgets.add(
        _buildPageButton(
          page: page,
          pageCount: pageCount,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPaginationIcon(
          icon: Icons.keyboard_double_arrow_left,
          onTap: _currentPage > 1
              ? () => _changePage(1, pageCount)
              : null,
        ),
        _buildPaginationIcon(
          icon: Icons.keyboard_arrow_left,
          onTap: _currentPage > 1
              ? () => _changePage(_currentPage - 1, pageCount)
              : null,
        ),
        ...pageWidgets,
        _buildPaginationIcon(
          icon: Icons.keyboard_arrow_right,
          onTap: _currentPage < pageCount
              ? () => _changePage(_currentPage + 1, pageCount)
              : null,
        ),
        _buildPaginationIcon(
          icon: Icons.keyboard_double_arrow_right,
          onTap: _currentPage < pageCount
              ? () => _changePage(pageCount, pageCount)
              : null,
        ),
      ],
    );
  }

  Widget _buildPageButton({
    required int page,
    required int pageCount,
  }) {
    final selected = page == _currentPage;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: InkWell(
        onTap: () => _changePage(page, pageCount),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: selected
                ? Border.all(
              color: const Color(0xFF555555),
            )
                : null,
          ),
          child: Text(
            page.toString(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: selected
                  ? const Color(0xFF252525)
                  : const Color(0xFF333333),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationIcon({
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return IconButton(
      onPressed: onTap,
      visualDensity: VisualDensity.compact,
      icon: Icon(
        icon,
        size: 18,
        color: onTap == null
            ? const Color(0xFFBBBBBB)
            : const Color(0xFF333333),
      ),
    );
  }
}
