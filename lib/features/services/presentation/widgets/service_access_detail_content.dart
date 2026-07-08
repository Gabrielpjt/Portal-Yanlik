import 'package:flutter/material.dart';

import 'service_access_common_widgets.dart';

class ServiceAccessDetailContent extends StatelessWidget {
  final String serviceTitle;
  final Map<String, dynamic> item;

  const ServiceAccessDetailContent({
    super.key,
    required this.serviceTitle,
    required this.item,
  });

  bool get _isDoctor => serviceTitle == 'Cari Dokter';

  String get _name => item['name'] as String? ?? '-';

  String get _distance => item['distance'] as String? ?? '-';

  String get _description {
    return item['description'] as String? ??
        (_isDoctor
            ? 'Informasi mengenai tenaga medis belum tersedia.'
            : 'Informasi mengenai fasilitas kesehatan belum tersedia.');
  }

  String get _phone => item['phone'] as String? ?? '-';

  String get _doctorSpecialization {
    return item['specialization'] as String? ?? '-';
  }

  String get _doctorHospital => item['hospital'] as String? ?? '-';

  String get _doctorSchedule {
    return item['detailSchedule'] as String? ??
        item['schedule'] as String? ??
        '-';
  }

  List<Map<String, dynamic>> get _doctorEducation {
    final education = item['education'];

    if (education is List) {
      return education.whereType<Map<String, dynamic>>().toList();
    }

    return const [];
  }

  String get _facilityAddress => item['address'] as String? ?? '-';

  String get _facilityOperationalHours {
    return item['operationalHours'] as String? ?? '-';
  }

  bool get _facilityAcceptsBpjs => item['bpjs'] == true;

  List<String> get _facilityServices {
    final services = item['services'];

    if (services is List) {
      return services.map((service) => service.toString()).toList();
    }

    return const ['Umum'];
  }

  void _showMessage(
      BuildContext context,
      String message,
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ServiceAccessBackButton(
            label: serviceTitle,
          ),
          const SizedBox(height: 22),
          _buildOverviewCard(context),
          const SizedBox(height: 26),
          if (_isDoctor) ...[
            _buildDoctorAboutSection(),
            const Divider(
              height: 38,
              thickness: 0.4,
            ),
            _buildDoctorPracticeSection(),
            const Divider(
              height: 38,
              thickness: 0.4,
            ),
            _buildDoctorEducationSection(),
          ] else ...[
            _buildFacilityAboutSection(),
            const Divider(
              height: 38,
              thickness: 0.4,
            ),
            _buildFacilityContactSection(),
            const Divider(
              height: 38,
              thickness: 0.4,
            ),
            _buildFacilityServicesSection(),
            const Divider(
              height: 38,
              thickness: 0.4,
            ),
            _buildFacilityComplaintSection(context),
          ],
        ],
      ),
    );
  }

  Widget _buildOverviewCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE1E1E1),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _name,
            style: const TextStyle(
              fontSize: 24,
              height: 1.3,
              fontWeight: FontWeight.w800,
              color: Color(0xFF252525),
            ),
          ),
          const SizedBox(height: 10),
          _buildBadge(),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.map_outlined,
                size: 17,
                color: Color(0xFF888888),
              ),
              const SizedBox(width: 6),
              const Text(
                'Jarak',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF777777),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                _distance,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2E9E4F),
                ),
              ),
              const SizedBox(width: 4),
              const Expanded(
                child: Text(
                  'dari lokasi Anda',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF777777),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: OutlinedButton.icon(
              onPressed: () {
                _showMessage(
                  context,
                  'Fitur lokasi belum dihubungkan.',
                );
              },
              icon: const Icon(
                Icons.location_on_outlined,
                size: 19,
              ),
              label: const Text('Lihat lokasi'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF062F5E),
                side: const BorderSide(
                  color: Color(0xFFE0E0E0),
                ),
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
              onPressed: () {
                _showMessage(
                  context,
                  'Fitur telepon belum dihubungkan.',
                );
              },
              icon: const Icon(
                Icons.phone_outlined,
                size: 18,
              ),
              label: const Text('Hubungi'),
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

  Widget _buildBadge() {
    if (_isDoctor) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF3FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          _doctorSpecialization,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Color(0xFF2471D9),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: _facilityAcceptsBpjs
            ? const Color(0xFFEAF3FF)
            : const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _facilityAcceptsBpjs ? 'BPJS' : 'Non BPJS',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: _facilityAcceptsBpjs
              ? const Color(0xFF2471D9)
              : const Color(0xFF444444),
        ),
      ),
    );
  }

  Widget _buildDoctorAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ServiceAccessSectionTitle(
          title: 'Tentang Tenaga Medis',
        ),
        const SizedBox(height: 14),
        _buildDescription(),
      ],
    );
  }

  Widget _buildDoctorPracticeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ServiceAccessSectionTitle(
          title: 'Lokasi Praktik',
        ),
        const SizedBox(height: 20),
        ServiceAccessInformationItem(
          label: 'Alamat',
          value: _doctorHospital,
        ),
        const SizedBox(height: 20),
        ServiceAccessInformationItem(
          label: 'No. Telp',
          value: _phone,
        ),
        const SizedBox(height: 20),
        ServiceAccessInformationItem(
          label: 'Jam Praktik',
          value: _doctorSchedule,
        ),
      ],
    );
  }

  Widget _buildDoctorEducationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ServiceAccessSectionTitle(
          title: 'Pendidikan',
        ),
        const SizedBox(height: 20),
        if (_doctorEducation.isEmpty)
          const Text(
            'Informasi pendidikan belum tersedia.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF777777),
            ),
          )
        else
          ...List.generate(_doctorEducation.length, (index) {
            final education = _doctorEducation[index];

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == _doctorEducation.length - 1 ? 0 : 22,
              ),
              child: ServiceAccessInformationItem(
                label: '',
                value: education['degree'] as String? ?? '-',
                secondaryValue:
                education['institution'] as String? ?? '-',
              ),
            );
          }),
      ],
    );
  }

  Widget _buildFacilityAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ServiceAccessSectionTitle(
          title: 'Tentang Fasilitas Kesehatan',
        ),
        const SizedBox(height: 14),
        _buildDescription(),
      ],
    );
  }

  Widget _buildFacilityContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ServiceAccessSectionTitle(
          title: 'Informasi Kontak',
        ),
        const SizedBox(height: 20),
        ServiceAccessInformationItem(
          label: 'Alamat',
          value: _facilityAddress,
        ),
        const SizedBox(height: 20),
        ServiceAccessInformationItem(
          label: 'No. Telp',
          value: _phone,
        ),
        const SizedBox(height: 20),
        ServiceAccessInformationItem(
          label: 'Jam Operasional',
          value: _facilityOperationalHours,
        ),
      ],
    );
  }

  Widget _buildFacilityServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ServiceAccessSectionTitle(
          title: 'Layanan Yang Tersedia',
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _facilityServices.map((service) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFE0E0E0),
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                service,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF444444),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFacilityComplaintSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ServiceAccessSectionTitle(
          title: 'Kanal Pengaduan',
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _ExternalLinkButton(
              label: 'Website Official',
              onTap: () {
                _showMessage(
                  context,
                  'Website resmi belum dihubungkan.',
                );
              },
            ),
            _ExternalLinkButton(
              label: 'Whatsapp',
              onTap: () {
                _showMessage(
                  context,
                  'Whatsapp belum dihubungkan.',
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      _description,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.55,
        color: Color(0xFF505050),
      ),
    );
  }
}

class _ExternalLinkButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ExternalLinkButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF444444),
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 12,
        ),
        side: const BorderSide(
          color: Color(0xFFE0E0E0),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.arrow_outward,
            size: 15,
            color: Color(0xFF999999),
          ),
        ],
      ),
    );
  }
}
