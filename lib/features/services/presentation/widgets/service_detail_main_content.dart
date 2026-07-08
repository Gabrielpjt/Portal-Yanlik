import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import 'service_detail_tab_section.dart';

class ServiceDetailMainContent extends StatelessWidget {
  final String serviceTitle;
  final VoidCallback? onHealthFacilityTap;
  final VoidCallback? onAccessServiceTap;

  const ServiceDetailMainContent({
    super.key,
    required this.serviceTitle,
    this.onHealthFacilityTap,
    this.onAccessServiceTap,
  });

  bool get _isHealthFacility {
    return serviceTitle == 'Cari Fasilitas Kesehatan' ||
        serviceTitle == 'Cari Dokter dan Fasilitas Kesehatan' ||
        serviceTitle.startsWith('Pencarian Layanan Keseha');
  }

  bool get _isDoctor {
    return serviceTitle == 'Cari Dokter';
  }

  bool get _isHealthDirectory {
    return _isDoctor || _isHealthFacility;
  }

  bool get _isBpjsMembership {
    return serviceTitle == 'Informasi Kepesertaan BPJS';
  }

  bool get _isBpjsMembershipAddition {
    return serviceTitle == 'Penambahan Kepesertaan BPJS';
  }

  bool get _isQueueRegistration {
    return serviceTitle ==
        'Pendaftaran Pelayanan BPJS (Antrean)' ||
        serviceTitle == 'Pendaftaran Pelayanan (Antrean)';
  }

  bool get _isBirthCertificate {
    return serviceTitle == 'Penerbitan Akta Kelahiran' ||
        serviceTitle == 'Pengurusan Akta Kelahiran';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionTitle(
          title: 'Deskripsi layanan',
        ),
        const SizedBox(height: 12),
        Text(
          _description,
          style: const TextStyle(
            color: AppColors.contentPrimary,
            fontSize: 13,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 24),
        const ServiceDetailTabSection(),
        const SizedBox(height: 30),
        _ServiceAccessLinks(
          serviceTitle: serviceTitle,
          isHealthDirectory: _isHealthDirectory,
          isDoctor: _isDoctor,
          isBirthCertificate: _isBirthCertificate,
          isBpjsMembership: _isBpjsMembership,
          isQueueRegistration: _isQueueRegistration,
          isBpjsMembershipAddition:
          _isBpjsMembershipAddition,
          onHealthFacilityTap: onHealthFacilityTap,
          onAccessServiceTap: onAccessServiceTap,
        ),
        const Divider(
          height: 38,
          thickness: 0.4,
        ),
        _OtherDetailSection(
          isHealthDirectory: _isHealthDirectory,
          isBirthCertificate: _isBirthCertificate,
          isBpjsMembership: _isBpjsMembership,
          isQueueRegistration: _isQueueRegistration,
          isBpjsMembershipAddition:
          _isBpjsMembershipAddition,
        ),
      ],
    );
  }

  String get _description {
    if (_isDoctor) {
      return 'Temukan dokter sesuai kebutuhan Anda berdasarkan nama, '
          'spesialisasi, lokasi praktik, dan jadwal pelayanan.';
    }

    if (_isHealthFacility) {
      return 'Temukan rumah sakit, puskesmas, atau klinik di sekitar Anda '
          'berdasarkan lokasi dan jenis layanan.';
    }

    if (_isBpjsMembership) {
      return 'Fitur Info Peserta BPJS Kesehatan memungkinkan Anda mengecek '
          'status keaktifan, iuran, kelas rawat, dan data pribadi seperti '
          'NIK dan faskes secara real-time.';
    }

    if (_isBpjsMembershipAddition) {
      return 'Fitur penambahan kepesertaan BPJS Kesehatan '
          'memungkinkan pengguna menambahkan anggota keluarga '
          'baru, memilih fasilitas kesehatan tingkat pertama, '
          'menentukan kelas pelayanan, serta melakukan verifikasi '
          'nomor telepon dan email secara daring.';
    }

    if (_isQueueRegistration) {
      return 'Fitur pendaftaran pelayanan BPJS Kesehatan paling utama '
          'terdapat pada aplikasi Mobile JKN, yang memungkinkan peserta '
          'mengambil antrean online di FKTP (Puskesmas/Klinik) atau '
          'Rumah Sakit secara mandiri. Fitur ini memudahkan pendaftaran, '
          'pengecekan jadwal dokter, dan check-in tanpa harus antre lama '
          'di faskes.';
    }

    if (_isBirthCertificate) {
      return 'Ajukan pembuatan akta kelahiran untuk mencatat kelahiran anak '
          'secara resmi yang terhubung dengan data kependudukan melalui '
          'Identitas Kependudukan Digital (IKD).';
    }

    return 'Temukan informasi dan panduan lengkap untuk mengakses layanan '
        '$serviceTitle.';
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.contentPrimary,
        fontSize: 20,
        height: 1.3,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ServiceAccessLinks extends StatelessWidget {
  final String serviceTitle;
  final bool isHealthDirectory;
  final bool isDoctor;
  final bool isBirthCertificate;
  final bool isBpjsMembership;
  final bool isQueueRegistration;
  final bool isBpjsMembershipAddition;
  final VoidCallback? onHealthFacilityTap;
  final VoidCallback? onAccessServiceTap;

  const _ServiceAccessLinks({
    required this.serviceTitle,
    required this.isHealthDirectory,
    required this.isDoctor,
    required this.isBirthCertificate,
    required this.isBpjsMembership,
    required this.isQueueRegistration,
    required this.isBpjsMembershipAddition,
    this.onHealthFacilityTap,
    this.onAccessServiceTap,
  });

  List<String> get _links {
    if (isDoctor) {
      return const [
        'Cari Dokter',
        'Satu Sehat',
      ];
    }

    if (isHealthDirectory) {
      return const [
        'Cari Fasilitas Kesehatan',
        'Satu Sehat',
      ];
    }

    if (isBirthCertificate) {
      return const [
        'Form Penerbitan Akta Kelahiran',
        'Website Official',
      ];
    }

    if (isBpjsMembership) {
      return const [
        'Informasi Kepesertaan',
        'Website Official BPJS',
      ];
    }

    if (isBpjsMembershipAddition) {
      return const [
        'Form Penambahan Kepesertaan',
        'Website Official BPJS',
      ];
    }

    if (isQueueRegistration) {
      return const [
        'Form Pendaftaran Pelayanan',
        'Website Official BPJS',
      ];
    }

    return [
      'Akses $serviceTitle',
      'Website Official',
    ];
  }

  VoidCallback _getLinkAction(String label) {
    if (isHealthDirectory &&
        (label == 'Cari Fasilitas Kesehatan' ||
            label == 'Cari Dokter')) {
      return onHealthFacilityTap ?? () {};
    }

    if (isBirthCertificate &&
        label == 'Form Penerbitan Akta Kelahiran') {
      return onAccessServiceTap ?? () {};
    }

    if (isBpjsMembership &&
        label == 'Informasi Kepesertaan') {
      return onAccessServiceTap ?? () {};
    }

    if (isBpjsMembershipAddition &&
        label == 'Form Penambahan Kepesertaan') {
      return onAccessServiceTap ?? () {};
    }

    if (isQueueRegistration &&
        label == 'Form Pendaftaran Pelayanan') {
      return onAccessServiceTap ?? () {};
    }

    if (label == 'Satu Sehat') {
      return () {
        // Tambahkan navigasi menuju Satu Sehat di sini.
      };
    }

    if (label == 'Website Official' ||
        label == 'Website Official BPJS') {
      return () {
        // Tambahkan pembukaan website resmi di sini.
      };
    }

    return onAccessServiceTap ?? () {};
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionTitle(
          title: 'Akses Ke Layanan',
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _links.map((label) {
            return _AccessLinkButton(
              label: label,
              onTap: _getLinkAction(label),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _AccessLinkButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _AccessLinkButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.contentPrimary,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
        side: const BorderSide(
          color: AppColors.strokePrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 7),
          const Icon(
            Icons.arrow_outward,
            size: 14,
            color: AppColors.contentSecondary,
          ),
        ],
      ),
    );
  }
}

class _OtherDetailSection extends StatelessWidget {
  final bool isHealthDirectory;
  final bool isBirthCertificate;
  final bool isBpjsMembership;
  final bool isQueueRegistration;
  final bool isBpjsMembershipAddition;

  const _OtherDetailSection({
    required this.isHealthDirectory,
    required this.isBirthCertificate,
    required this.isBpjsMembership,
    required this.isQueueRegistration,
    required this.isBpjsMembershipAddition,
  });

  String get _responsibleAgency {
    if (isHealthDirectory) {
      return 'Kementerian Kesehatan, BPJS Kesehatan';
    }

    if (isBpjsMembership ||
        isQueueRegistration ||
        isBpjsMembershipAddition) {
      return 'BPJS Kesehatan, Kementerian Kesehatan, '
          'Rumah Sakit/Fasilitas Kesehatan';
    }

    if (isBirthCertificate) {
      return 'Kementerian Dalam Negeri, Dinas Kependudukan dan '
          'Pencatatan Sipil, Kementerian Kesehatan, '
          'Rumah Sakit/Fasilitas Kesehatan';
    }

    return 'Instansi pemerintah terkait';
  }

  String get _accessMethod {
    if (isBirthCertificate) {
      return 'Online melalui IKD dan offline melalui Dukcapil';
    }

    return 'Online, Offline, Mobile Apps';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionTitle(
          title: 'Detail Lainnya',
        ),
        const SizedBox(height: 18),
        const _DetailItem(
          label: 'Cakupan Layanan / Program',
          value: 'Nasional, Daerah',
        ),
        const SizedBox(height: 18),
        _DetailItem(
          label: 'Cara Akses',
          value: _accessMethod,
        ),
        const SizedBox(height: 18),
        _DetailItem(
          label: 'Instansi Penanggung Jawab',
          value: _responsibleAgency,
        ),
      ],
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;

  const _DetailItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.contentSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.contentPrimary,
            fontSize: 13,
            height: 1.4,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
