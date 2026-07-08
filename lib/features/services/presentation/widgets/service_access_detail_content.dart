import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/bloc/user_session/user_session_bloc.dart';
import '../../domain/entities/service_access_item_entity.dart';
import '../../domain/entities/service_access_type.dart';
import '../bloc/service_access_bloc.dart';
import '../bloc/service_access_event.dart';
import '../bloc/service_access_state.dart';
import 'service_access_common_widgets.dart';

class ServiceAccessDetailContent extends StatefulWidget {
  final String serviceTitle;
  final Map<String, dynamic> item;

  const ServiceAccessDetailContent({
    super.key,
    required this.serviceTitle,
    required this.item,
  });

  @override
  State<ServiceAccessDetailContent> createState() {
    return _ServiceAccessDetailContentState();
  }
}

class _ServiceAccessDetailContentState extends State<ServiceAccessDetailContent> {
  bool get _isDoctor => widget.serviceTitle.toLowerCase().contains('dokter');

  bool get _isBpom {
    final title = widget.serviceTitle.toLowerCase();
    return title.contains('bpom') || title.contains('produk');
  }

  bool get _isFacility => !_isDoctor && !_isBpom;

  @override
  void initState() {
    super.initState();
    _loadFacilityDetail();
  }

  @override
  void didUpdateWidget(ServiceAccessDetailContent oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.serviceTitle != widget.serviceTitle ||
        oldWidget.item['id'] != widget.item['id']) {
      _loadFacilityDetail();
    }
  }

  void _loadFacilityDetail() {
    if (!_isFacility) return;

    final id = widget.item['id']?.toString() ?? '';
    context.read<ServiceAccessBloc>().add(
      ServiceAccessDetailRequested(
        type: ServiceAccessSearchType.healthFacility,
        token: context.read<UserSessionBloc>().state.token,
        id: id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isFacility) {
      return _ServiceAccessDetailBody(
        serviceTitle: widget.serviceTitle,
        item: widget.item,
      );
    }

    return BlocBuilder<ServiceAccessBloc, ServiceAccessState>(
      builder: (context, state) {
        if (state.isLoadingDetail ||
            (state.detail == null && !state.hasDetailError)) {
          return _buildLoadingState();
        }

        if (state.hasDetailError) {
          return _buildErrorState(state.detailErrorMessage);
        }

        final ServiceAccessItemEntity? detail = state.detail;
        final detailItem = <String, dynamic>{
          ...widget.item,
          ...?detail?.toMap(),
        };

        return _ServiceAccessDetailBody(
          serviceTitle: widget.serviceTitle,
          item: detailItem,
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ServiceAccessBackButton(label: widget.serviceTitle),
          const SizedBox(height: 70),
          const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF062F5E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ServiceAccessBackButton(label: widget.serviceTitle),
          const SizedBox(height: 22),
          Container(
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
                  'Gagal memuat detail fasilitas kesehatan',
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
                    onPressed: _loadFacilityDetail,
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
          ),
        ],
      ),
    );
  }
}

class _ServiceAccessDetailBody extends StatelessWidget {
  final String serviceTitle;
  final Map<String, dynamic> item;

  const _ServiceAccessDetailBody({
    required this.serviceTitle,
    required this.item,
  });

  bool get _isDoctor => serviceTitle.toLowerCase().contains('dokter');

  bool get _isBpom {
    final title = serviceTitle.toLowerCase();
    return title.contains('bpom') || title.contains('produk');
  }

  bool get _isFacility => !_isDoctor && !_isBpom;

  static const Map<String, dynamic> _staticDoctor = {
    'name': 'Dr. Ahmad Wijaya, Sp.JP',
    'specialization': 'Spesialis Jantung',
    'updatedAt': 'Diperbarui 9 Apr 2026',
    'description':
    'Dr. Ahmad Wijaya, Sp.JP adalah seorang spesialis jantung. Lulus dari Universitas Indonesia, beliau telah menangani pasien dengan dedikasi tinggi dan profesionalisme.',
    'shortProfile': {
      'Surat Tanda Registrasi': '1000261953',
      'Spesialisasi': 'Jantung',
      'No. Telepon': '0811514307',
    },
    'practiceLocations': [
      {
        'name': 'Rumah Sakit Fatmawati',
        'schedules': {
          'Senin': '08.00-12.00 WIB',
          'Selasa': '08.00-12.00 WIB',
          'Rabu': '08.00-12.00 WIB',
        },
      },
      {
        'name': 'Rumah Hasan Sadikin',
        'schedules': {
          'Senin': '12.00 - 16.00 WIB',
          'Selasa': '12.00 - 16.00 WIB',
          'Rabu': '12.00 - 16.00 WIB',
        },
      },
    ],
    'education': [
      {
        'year': '2015',
        'degree': 'Spesialisasi Spesialis Jantung',
        'institution': 'Universitas Indonesia',
      },
      {
        'year': '2005',
        'degree': 'Sarjana Kedokteran',
        'institution': 'Universitas Indonesia',
      },
    ],
  };

  static const Map<String, dynamic> _staticBpomProduct = {
    'name': '7 Flowers Shampoo',
    'nieShort': 'NIE 123456789012',
    'status': 'Berlaku',
    'identification': {
      'Nomor Aju': 'ERBA348106202500043',
      'Nama Produk': '7 Flowers Shampoo',
      'Brand': 'Selsun',
    },
    'regulation': {
      'Tanggal Pembaharuan': '2026-06-02T03:00:39.000Z',
      'Nomor Ijin Edar (NIE)': 'MD 222871005300986',
      'Kode QR': '(90)MD222871005300986',
      'Tanggal Terbit': '2026-02-02',
      'Masa Berlaku': '2031-02-02',
    },
    'productSpecification': {
      'Nama Komoditi': 'Kosmetik',
      'Bentuk Sediaan': '-',
      'Kemasan': 'Botol Plastik PET (160 g)',
      'Komposisi': '-',
      'Khasiat': '-',
    },
    'registrantSpecification': {
      'Pendaftar': 'PT. Rohto Laboratories Indonesia, Tbk',
      'Negara Pendaftar': 'Indonesia',
      'Diterbitkan Oleh': 'Direktorat Registrasi Pangan Olahan',
    },
  };

  Map<String, dynamic> get _data {
    if (_isDoctor) return <String, dynamic>{..._staticDoctor, ...item};
    if (_isBpom) return <String, dynamic>{..._staticBpomProduct, ...item};
    return item;
  }

  String _value(String key, [String fallback = '-']) {
    return _optionalValue([key]) ?? fallback;
  }

  String? _optionalValue(List<String> keys) {
    final aliases = <String, List<String>>{
      'name': ['nama', 'productName'],
      'description': ['deskripsi'],
      'updatedAt': ['updated_at', 'updatedAt', 'tanggal_update', 'versi_data'],
      'specialization': ['jenis_sarana_name'],
      'phone': ['telp', 'telepon'],
      'address': ['alamat'],
      'email': ['email'],
      'website': ['website'],
      'facilityClass': ['kelas', 'kelas_sarana', 'class'],
      'operationalStatus': [
        'operationalStatus',
        'operational_status',
        'status_operasional',
        'status_aktif',
        'statusAktif',
        'status',
      ],
      'statusSarana': ['status_sarana', 'statusSarana'],
      'statusAktif': ['status_aktif', 'statusAktif'],
      'jenisGedung': ['jenis_gedung', 'jenisGedung'],
      'subJenis': ['sub_jenis', 'subJenis'],
      'kabKota': ['kab_kota', 'kabupaten_kota', 'kabKota', 'kota'],
      'provinsi': ['provinsi', 'province'],
    };

    final resolvedKeys = <String>[];
    for (final key in keys) {
      resolvedKeys.add(key);
      resolvedKeys.addAll(aliases[key] ?? const []);
    }

    for (final currentKey in resolvedKeys) {
      final value = _data[currentKey];
      if (value == null) continue;

      final text = value.toString().trim();
      if (!_isEmptyDisplayValue(text)) {
        return text;
      }
    }

    return null;
  }

  bool _isEmptyDisplayValue(String value) {
    final normalized = value.trim().toLowerCase();

    return normalized.isEmpty ||
        normalized == '-' ||
        normalized == 'null' ||
        normalized == 'string';
  }

  String _updatedInfoText() {
    final updatedAt = _optionalValue(['updatedAt']);

    if (updatedAt == null) {
      return 'Diperbarui -';
    }

    if (updatedAt.toLowerCase().startsWith('diperbarui')) {
      return updatedAt;
    }

    return 'Diperbarui $updatedAt';
  }

  String _normalizeWebsiteUrl(String website) {
    final value = website.trim();
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }

    return 'https://$value';
  }

  void _copyText(BuildContext context, String value, String label) {
    if (!_hasActionableValue(value)) {
      _showMessage(context, '$label belum tersedia.');
      return;
    }

    Clipboard.setData(ClipboardData(text: value));
    _showMessage(context, '$label berhasil disalin.');
  }

  Future<void> _openWebsite(BuildContext context, String website) async {
    if (!_hasActionableValue(website)) {
      _showMessage(context, 'Website belum tersedia.');
      return;
    }

    final uri = Uri.parse(_normalizeWebsiteUrl(website));
    final opened = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!opened) {
      _showMessage(context, 'Website tidak dapat dibuka.');
    }
  }

  String _coordinatesText() {
    final latitude = _value('latitude', '');
    final longitude = _value('longitude', '');

    if (latitude.isEmpty || longitude.isEmpty) {
      return '-';
    }

    return '$latitude, $longitude';
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }


  bool _hasActionableValue(String value) {
    final text = value.trim().toLowerCase();
    return text.isNotEmpty && text != '-' && text != 'string';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ServiceAccessBackButton(
            label: _isBpom ? 'Kembali' : serviceTitle,
          ),
          const SizedBox(height: 22),

          if (_isDoctor) _buildDoctorHero(context),
          if (_isFacility) _buildFacilityHero(context),
          if (_isBpom) _buildBpomHero(context),

          const SizedBox(height: 26),

          if (_isDoctor) ...[
            _buildAboutSection('Tentang Tenaga Medis'),
            const SizedBox(height: 28),
            _buildDoctorProfileSection(),
            const SizedBox(height: 28),
            _buildDoctorPracticeScheduleSection(),
            const SizedBox(height: 28),
            _buildDoctorEducationSection(),
          ],

          if (_isFacility) _buildFacilityDetailSections(),

          if (_isBpom) _buildBpomDetailSections(),
        ],
      ),
    );
  }

  Widget _buildDoctorHero(BuildContext context) {
    return _HeroCard(
      title: _value('name'),
      badges: [
        _BadgeData(
          text: _value('specialization'),
          backgroundColor: const Color(0xFFEAF3FF),
          textColor: const Color(0xFF2471D9),
        ),
      ],
      infoText: _value('updatedAt'),
      secondaryButtonLabel: 'Lihat lokasi',
      secondaryButtonIcon: Icons.location_on_outlined,
      primaryButtonLabel: 'Hubungi',
      primaryButtonIcon: Icons.phone_outlined,
      onSecondaryTap: () {
        _showMessage(context, 'Fitur lokasi belum dihubungkan.');
      },
      onPrimaryTap: () {
        _showMessage(context, 'Fitur telepon belum dihubungkan.');
      },
    );
  }

  Widget _buildFacilityHero(BuildContext context) {
    final facilityType = _optionalValue(['jenis_sarana_name']);
    final kodeSarana = _optionalValue(['kode_sarana', 'kodeSarana']);
    final facilityClass = _optionalValue(['facilityClass']);
    final operationalStatus = _optionalValue(['operationalStatus']);

    final badges = <_BadgeData>[
      if (facilityType != null)
        _BadgeData(
          text: facilityType,
          backgroundColor: const Color(0xFFEAF3FF),
          textColor: const Color(0xFF2471D9),
        ),
      if (facilityClass != null && facilityClass != kodeSarana)
        _BadgeData(
          text: facilityClass,
          backgroundColor: const Color(0xFFEAF3FF),
          textColor: const Color(0xFF2471D9),
        ),
      if (operationalStatus != null)
        _BadgeData(
          text: operationalStatus,
          backgroundColor: const Color(0xFFE9F9E9),
          textColor: const Color(0xFF2E9E4F),
        ),
    ];

    return _HeroCard(
      title: _value('name'),
      badges: badges,
      infoText: _updatedInfoText(),
      secondaryButtonLabel: 'Lihat lokasi',
      secondaryButtonIcon: Icons.location_on_outlined,
      primaryButtonLabel: 'Hubungi',
      primaryButtonIcon: Icons.phone_outlined,
      onSecondaryTap: () {
        final coordinates = _coordinatesText();
        _showMessage(
          context,
          coordinates == '-'
              ? 'Koordinat lokasi belum tersedia.'
              : 'Koordinat: $coordinates',
        );
      },
      onPrimaryTap: () {
        final phone = _value('phone');
        _showMessage(
          context,
          phone == '-' ? 'Nomor telepon belum tersedia.' : 'Telepon: $phone',
        );
      },
    );
  }

  Widget _buildBpomHero(BuildContext context) {
    final nie = _value('nieShort');

    return _BpomHeroCard(
      title: _value('name'),
      nieShort: nie,
      status: _value('status'),
      onCopyNieTap: () {
        if (!_hasActionableValue(nie)) {
          _showMessage(context, 'Nomor NIE belum tersedia.');
          return;
        }

        Clipboard.setData(
          ClipboardData(text: nie),
        );

        _showMessage(context, 'NIE berhasil disalin.');
      },
      onShareTap: () {
        _showMessage(context, 'Fitur bagikan belum dihubungkan.');
      },
    );
  }

  Widget _buildAboutSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServiceAccessSectionTitle(title: title),
        const SizedBox(height: 14),
        Text(
          _value('description'),
          style: const TextStyle(
            fontSize: 15,
            height: 1.55,
            color: Color(0xFF505050),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorProfileSection() {
    final profile = (_staticDoctor['shortProfile'] as Map).cast<String, String>();

    return ServiceAccessInfoSection(
      title: 'Profil Singkat',
      children: profile.entries.map((entry) {
        return ServiceAccessInfoTile(
          label: entry.key,
          trailing: entry.key == 'Surat Tanda Registrasi'
              ? const Icon(
            Icons.copy,
            size: 18,
            color: Color(0xFF062F5E),
          )
              : entry.key == 'No. Telepon'
              ? const Icon(
            Icons.arrow_outward,
            size: 18,
            color: Color(0xFF062F5E),
          )
              : null,
          child: _boldText(entry.value),
        );
      }).toList(),
    );
  }

  Widget _buildDoctorPracticeScheduleSection() {
    final practiceLocations =
    (_staticDoctor['practiceLocations'] as List).cast<Map>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ServiceAccessSectionTitle(title: 'Lokasi & Jadwal Praktik'),
        const SizedBox(height: 16),
        ...List.generate(practiceLocations.length, (index) {
          final location = practiceLocations[index];

          return Padding(
            padding: EdgeInsets.only(
              bottom: index == practiceLocations.length - 1 ? 0 : 16,
            ),
            child: _PracticeLocationCard(
              title: location['name'] as String? ?? '-',
              schedules:
              (location['schedules'] as Map?)?.cast<String, String>() ??
                  const {},
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDoctorEducationSection() {
    final education = (_staticDoctor['education'] as List).cast<Map>();

    return ServiceAccessInfoSection(
      title: 'Pendidikan',
      children: education.map((item) {
        return ServiceAccessInfoTile(
          label: item['year'] as String? ?? '-',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['degree'] as String? ?? '-',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item['institution'] as String? ?? '-',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF555555),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFacilityDetailSections() {
    final summary = <String, String>{
      'Kode Satu Sehat': _value('kode_satu_sehat'),
      'Kode Sarana': _value('kode_sarana'),
      'Status Sarana': _value('statusSarana'),
      'Status Aktif': _value('statusAktif'),
    };

    final classification = <String, String>{
      'Jenis Sarana': _value('jenis_sarana_name'),
      'Jenis Gedung': _value('jenisGedung'),
      'Sub jenis': _value('subJenis'),
      'Kelas': _value('facilityClass'),
      'Kategori': 'Fasyankes',
    };

    final location = <String, String>{
      'Alamat': _value('address'),
      'Kab/Kota': _value('kabKota'),
      'Provinsi': _value('provinsi'),
      'Koordinat': _coordinatesText(),
    };

    final contact = <String, String>{
      'Telepon': _value('phone'),
      'Email': _value('email'),
      'Website': _value('website'),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildMapSection(
          'Ringkasan Umum',
          summary,
          copyLabels: const {
            'Kode Satu Sehat',
            'Kode Sarana',
          },
        ),
        const SizedBox(height: 32),
        _buildMapSection('Klasifikasi', classification),
        const SizedBox(height: 32),
        _buildMapSection('Lokasi', location),
        const SizedBox(height: 32),
        _buildMapSection(
          'Kontak',
          contact,
          externalLinkLabel: 'Website',
        ),
      ],
    );
  }

  Widget _buildBpomDetailSections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildMapSection(
          'Identifikasi Produk',
          (_staticBpomProduct['identification'] as Map).cast<String, String>(),
          copyLabels: const {
            'Nomor Aju',
            'Nama Produk',
            'Brand',
          },
        ),
        const SizedBox(height: 32),
        _buildMapSection(
          'Informasi Regulasi',
          (_staticBpomProduct['regulation'] as Map).cast<String, String>(),
          copyLabels: const {
            'Nomor Ijin Edar (NIE)',
            'Kode QR',
          },
        ),
        const SizedBox(height: 32),
        _buildMapSection(
          'Spesifikasi Produk',
          (_staticBpomProduct['productSpecification'] as Map)
              .cast<String, String>(),
        ),
        const SizedBox(height: 32),
        _buildMapSection(
          'Spesifikasi Produk',
          (_staticBpomProduct['registrantSpecification'] as Map)
              .cast<String, String>(),
        ),
      ],
    );
  }

  Widget _buildMapSection(
      String title,
      Map<String, String> rows, {
        String? externalLinkLabel,
        Set<String> copyLabels = const {},
      }) {
    return ServiceAccessInfoSection(
      title: title,
      children: rows.entries.map((entry) {
        final isStatus = entry.value == 'Valid' || entry.value == 'Aktif';
        final isValid = entry.value == 'Valid';
        final hasValue = _hasActionableValue(entry.value);
        final isExternalLink = entry.key == externalLinkLabel && hasValue;
        final isCopyValue =
            (entry.key.contains('Kode') || copyLabels.contains(entry.key)) &&
                hasValue;

        return ServiceAccessInfoTile(
          label: entry.key,
          trailing: Builder(
            builder: (context) {
              if (isExternalLink) {
                return IconButton(
                  onPressed: () => _openWebsite(context, entry.value),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 30,
                    minHeight: 30,
                  ),
                  icon: const Icon(
                    Icons.arrow_outward,
                    size: 18,
                    color: Color(0xFF062F5E),
                  ),
                );
              }

              if (isCopyValue) {
                return IconButton(
                  onPressed: () => _copyText(context, entry.value, entry.key),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 30,
                    minHeight: 30,
                  ),
                  icon: const Icon(
                    Icons.copy,
                    size: 18,
                    color: Color(0xFF062F5E),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
          child: isStatus
              ? ServiceAccessStatusBadge(
            text: entry.value,
            backgroundColor: isValid
                ? const Color(0xFFEAF3FF)
                : const Color(0xFFE9F9E9),
            textColor: isValid
                ? const Color(0xFF2471D9)
                : const Color(0xFF2E9E4F),
          )
              : _boldText(entry.value),
        );
      }).toList(),
    );
  }

  Widget _boldText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF333333),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final String title;
  final List<_BadgeData> badges;
  final String? infoText;
  final String secondaryButtonLabel;
  final IconData secondaryButtonIcon;
  final String primaryButtonLabel;
  final IconData primaryButtonIcon;
  final VoidCallback onSecondaryTap;
  final VoidCallback onPrimaryTap;

  const _HeroCard({
    required this.title,
    required this.badges,
    this.infoText,
    required this.secondaryButtonLabel,
    required this.secondaryButtonIcon,
    required this.primaryButtonLabel,
    required this.primaryButtonIcon,
    required this.onSecondaryTap,
    required this.onPrimaryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE1E1E1)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              height: 1.3,
              fontWeight: FontWeight.w800,
              color: Color(0xFF252525),
            ),
          ),
          if (badges.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: badges.map((badge) {
                return ServiceAccessStatusBadge(
                  text: badge.text,
                  backgroundColor: badge.backgroundColor,
                  textColor: badge.textColor,
                );
              }).toList(),
            ),
          ],
          if (infoText != null && infoText!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              infoText!,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF777777),
              ),
            ),
          ],
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: OutlinedButton.icon(
              onPressed: onSecondaryTap,
              icon: Icon(secondaryButtonIcon, size: 19),
              label: Text(secondaryButtonLabel),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF062F5E),
                side: const BorderSide(color: Color(0xFFE0E0E0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              onPressed: onPrimaryTap,
              icon: Icon(primaryButtonIcon, size: 18),
              label: Text(primaryButtonLabel),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF062F5E),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BpomHeroCard extends StatelessWidget {
  final String title;
  final String nieShort;
  final String status;
  final VoidCallback onCopyNieTap;
  final VoidCallback onShareTap;

  const _BpomHeroCard({
    required this.title,
    required this.nieShort,
    required this.status,
    required this.onCopyNieTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE1E1E1)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              height: 1.3,
              fontWeight: FontWeight.w800,
              color: Color(0xFF252525),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                nieShort,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF555555),
                ),
              ),
              const SizedBox(width: 8),
              ServiceAccessStatusBadge(
                text: '✓ $status',
                backgroundColor: const Color(0xFFE9F9E9),
                textColor: const Color(0xFF2E9E4F),
              ),
            ],
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton.icon(
              onPressed: onCopyNieTap,
              icon: const Icon(
                Icons.copy_outlined,
                size: 16,
                color: Color(0xFF333333),
              ),
              label: const Text(
                'Salin NIE',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF333333),
                side: const BorderSide(color: Color(0xFFE0E0E0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton.icon(
              onPressed: onShareTap,
              icon: const Icon(
                Icons.share_outlined,
                size: 16,
              ),
              label: const Text(
                'Bagikan',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF062F5E),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PracticeLocationCard extends StatelessWidget {
  final String title;
  final Map<String, String> schedules;

  const _PracticeLocationCard({
    required this.title,
    required this.schedules,
  });

  @override
  Widget build(BuildContext context) {
    final entries = schedules.entries.toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE6E6E6)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF333333),
              ),
            ),
          ),
          ...List.generate(entries.length, (index) {
            final entry = entries[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF888888),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        entry.value,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ],
                  ),
                ),
                if (index != entries.length - 1)
                  const Divider(
                    height: 1,
                    thickness: .5,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _BadgeData {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const _BadgeData({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });
}