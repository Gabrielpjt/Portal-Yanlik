import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/service_detail_entity.dart';
import 'service_detail_tab_section.dart';

class ServiceDetailMainContent extends StatelessWidget {
  final ServiceDetailEntity detail;
  final VoidCallback? onHealthFacilityTap;
  final VoidCallback? onAccessServiceTap;


  const ServiceDetailMainContent({
    super.key,
    required this.detail,
    this.onHealthFacilityTap,
    this.onAccessServiceTap,
  });

  String get _serviceTitle => detail.nama;

  bool get _isHealthFacility {
    return _serviceTitle == 'Cek Fasilitas Kesehatan' ||
        _serviceTitle == 'Cari Fasilitas Kesehatan' ||
        _serviceTitle == 'Cari Dokter dan Fasilitas Kesehatan' ||
        _serviceTitle.startsWith('Pencarian Layanan Keseha');
  }

  bool get _isDoctor {
    return _serviceTitle == 'Cari Dokter';
  }

  bool get _isHealthDirectory {
    return _isDoctor || _isHealthFacility;
  }

  bool get _isBpjsMembership {
    return _serviceTitle == 'Informasi Kepesertaan BPJS';
  }

  bool get _isBpjsMembershipAddition {
    return _serviceTitle == 'Penambahan Kepesertaan BPJS';
  }

  bool get _isQueueRegistration {
    return _serviceTitle == 'Pendaftaran Pelayanan BPJS (Antrean)' ||
        _serviceTitle == 'Pendaftaran Pelayanan (Antrean)';
  }

  bool get _isBirthCertificate {
    return _serviceTitle == 'Penerbitan Akta Kelahiran' ||
        _serviceTitle == 'Pengurusan Akta Kelahiran';
  }

  bool get _isBansosCheck {
    return _serviceTitle == 'Mengecek Bantuan Sosial' ||
        _serviceTitle == 'Cek Bantuan Sosial' ||
        _serviceTitle == 'Pengecekan Bantuan Sosial';
  }

  bool get _isBpomProductCheck {
    return _serviceTitle == 'Pengecekan Produk BPOM' ||
        _serviceTitle == 'Cek Produk BPOM' ||
        _serviceTitle == 'Mengecek Produk BPOM';
  }

  bool get _canOpenInternalAccess {
    return _isHealthDirectory ||
        _isBpjsMembership ||
        _isBpjsMembershipAddition ||
        _isQueueRegistration ||
        _isBirthCertificate ||
        _isBansosCheck ||
        _isBpomProductCheck;
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
            fontSize: 14,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 24),
        ServiceDetailTabSection(
          persyaratan: detail.persyaratan,
          caraMengakses: detail.caraMengakses,
          informasiTambahan: detail.informasiTambahan,
        ),
        const SizedBox(height: 30),
        _ServiceAccessLinks(
          serviceTitle: _serviceTitle,
          accesses: detail.akses,
          canOpenInternalAccess: _canOpenInternalAccess,
          isHealthDirectory: _isHealthDirectory,
          onHealthFacilityTap: onHealthFacilityTap,
          onAccessServiceTap: onAccessServiceTap,
        ),
        const Divider(
          height: 38,
          thickness: 0.4,
        ),
        _OtherDetailSection(
          detail: detail,
          isHealthDirectory: _isHealthDirectory,
          isBirthCertificate: _isBirthCertificate,
          isBpjsMembership: _isBpjsMembership,
          isQueueRegistration: _isQueueRegistration,
          isBpjsMembershipAddition: _isBpjsMembershipAddition,
        ),
      ],
    );
  }

  String get _description {
    if (detail.deskripsi.trim().isNotEmpty) {
      return detail.deskripsi;
    }

    return 'Temukan informasi dan panduan lengkap untuk mengakses layanan '
        '$_serviceTitle.';
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
  final List<ServiceAccessEntity> accesses;
  final bool canOpenInternalAccess;
  final bool isHealthDirectory;
  final VoidCallback? onHealthFacilityTap;
  final VoidCallback? onAccessServiceTap;

  const _ServiceAccessLinks({
    required this.serviceTitle,
    required this.accesses,
    required this.canOpenInternalAccess,
    required this.isHealthDirectory,
    this.onHealthFacilityTap,
    this.onAccessServiceTap,
  });

  List<ServiceAccessEntity> get _items {
    if (accesses.isNotEmpty) {
      return accesses;
    }

    return [
      ServiceAccessEntity(
        id: 0,
        judul: 'Akses $serviceTitle',
        deskripsi: '',
        tipe: 'LAINNYA',
        isPrimary: true,
      ),
    ];
  }

  VoidCallback _getLinkAction(ServiceAccessEntity item) {
    final label = item.judul.toLowerCase();

    if (isHealthDirectory &&
        (label.contains('fasilitas') || label.contains('dokter'))) {
      return onHealthFacilityTap ?? () {};
    }

    if (canOpenInternalAccess && item.isPrimary) {
      return onAccessServiceTap ?? () {};
    }

    if (canOpenInternalAccess &&
        (label.contains('form') ||
            label.contains('cek') ||
            label.contains('cari') ||
            label.contains('informasi kepesertaan') ||
            label.contains('pendaftaran') ||
            label.contains('akses'))) {
      return onAccessServiceTap ?? () {};
    }

    return () {
    };
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
          children: _items.map((item) {
            final label = item.judul.trim().isNotEmpty
                ? item.judul.trim()
                : item.tipe.trim();

            return _AccessLinkButton(
              label: label.isNotEmpty ? label : 'Akses layanan',
              onTap: _getLinkAction(item),
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
                fontSize: 13,
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
  final ServiceDetailEntity detail;
  final bool isHealthDirectory;
  final bool isBirthCertificate;
  final bool isBpjsMembership;
  final bool isQueueRegistration;
  final bool isBpjsMembershipAddition;

  const _OtherDetailSection({
    required this.detail,
    required this.isHealthDirectory,
    required this.isBirthCertificate,
    required this.isBpjsMembership,
    required this.isQueueRegistration,
    required this.isBpjsMembershipAddition,
  });

  String get _coverage {
    final apiCoverage = detail.cakupan.trim();

    if (apiCoverage.isNotEmpty) {
      return apiCoverage;
    }

    return '-';
  }

  String get _accessMethod {
    if (detail.aksesLayanan.isNotEmpty) {
      return detail.aksesLayanan.join(', ');
    }

    if (isBirthCertificate) {
      return 'Online melalui IKD dan offline melalui Dukcapil';
    }

    return 'Online, Offline, Mobile Apps';
  }

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

    final kategori = detail.kategoriLayanan?.nama.trim() ?? '';
    if (kategori.isNotEmpty) {
      return kategori;
    }

    return 'Instansi pemerintah terkait';
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
        _DetailItem(
          label: 'Cakupan Layanan / Program',
          value: _coverage,
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
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.contentPrimary,
            fontSize: 14,
            height: 1.4,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
