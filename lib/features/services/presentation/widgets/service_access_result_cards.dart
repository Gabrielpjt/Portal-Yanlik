import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/entities/service_access_type.dart';

class ServiceAccessResultCard extends StatelessWidget {
  final ServiceAccessSearchType type;
  final Map<String, dynamic> item;
  final ValueChanged<Map<String, dynamic>>? onItemTap;
  final ValueChanged<String>? onCopyRegistrationNumber;

  const ServiceAccessResultCard({
    super.key,
    required this.type,
    required this.item,
    this.onItemTap,
    this.onCopyRegistrationNumber,
  });

  @override
  Widget build(BuildContext context) {
    final config = _ServiceAccessCardConfig.fromType(
      type: type,
      item: item,
      onCopyRegistrationNumber: onCopyRegistrationNumber,
    );

    return _ServiceAccessGenericResultCard(
      config: config,
      onTap: () => onItemTap?.call(item),
    );
  }
}

class _ServiceAccessGenericResultCard extends StatelessWidget {
  final _ServiceAccessCardConfig config;
  final VoidCallback? onTap;

  const _ServiceAccessGenericResultCard({
    required this.config,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(_ServiceAccessCardTokens.radius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_ServiceAccessCardTokens.radius),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(_ServiceAccessCardTokens.cardPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: _ServiceAccessCardTokens.borderColor),
            borderRadius: BorderRadius.circular(_ServiceAccessCardTokens.radius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (config.headerIcon != null) ...[
                _ServiceAccessCardHeader(icon: config.headerIcon!),
                const SizedBox(height: 18),
              ],

              if (config.titleLabel != null) ...[
                Text(
                  config.titleLabel!,
                  style: _ServiceAccessCardTokens.labelTextStyle,
                ),
                const SizedBox(height: 4),
              ],

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      config.title,
                      style: _ServiceAccessCardTokens.titleTextStyle,
                    ),
                  ),
                  if (config.headerIcon == null) ...[
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.north_east,
                      size: 18,
                      color: _ServiceAccessCardTokens.primaryColor,
                    ),
                  ],
                ],
              ),
              if (config.subtitle != null || config.subtitleTrailing != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (config.subtitle != null)
                      Flexible(
                        child: Text(
                          config.subtitle!,
                          style: _ServiceAccessCardTokens.subtitleTextStyle,
                        ),
                      ),
                    if (config.subtitleTrailing != null) ...[
                      const SizedBox(width: 8),
                      config.subtitleTrailing!,
                    ],
                  ],
                ),
              ],
              if (config.badges.isNotEmpty) ...[
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: config.badges
                      .map((badge) => _ServiceAccessResultBadge(badge: badge))
                      .toList(),
                ),
              ],
              if (config.fields.isNotEmpty) ...[
                const SizedBox(height: 22),
                ...List.generate(config.fields.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == config.fields.length - 1 ? 0 : 18,
                    ),
                    child: _ServiceAccessInfoField(field: config.fields[index]),
                  );
                }),
              ],
              if (config.footerTitle != null || config.footerSubtitle != null) ...[
                const SizedBox(height: 16),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: _ServiceAccessCardTokens.dividerColor,
                ),
                const SizedBox(height: 16),
                if (config.footerTitle != null)
                  Text(
                    config.footerTitle!,
                    style: _ServiceAccessCardTokens.footerTitleTextStyle,
                  ),
                if (config.footerSubtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    config.footerSubtitle!,
                    style: _ServiceAccessCardTokens.footerSubtitleTextStyle,
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceAccessCardHeader extends StatelessWidget {
  final Widget? icon;

  const _ServiceAccessCardHeader({
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: _ServiceAccessCardTokens.iconBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: icon),
        ),
        const Spacer(),
        const Icon(
          Icons.north_east,
          size: 18,
          color: _ServiceAccessCardTokens.primaryColor,
        ),
      ],
    );
  }
}

class _ServiceAccessInfoField extends StatelessWidget {
  final _ServiceAccessCardField field;

  const _ServiceAccessInfoField({
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field.label,
          style: _ServiceAccessCardTokens.labelTextStyle,
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    field.value,
                    style: _ServiceAccessCardTokens.valueTextStyle,
                  ),
                  if (field.subValue != null && field.subValue!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      field.subValue!,
                      style: _ServiceAccessCardTokens.subValueTextStyle,
                    ),
                  ],
                ],
              ),
            ),
            if (field.trailing != null) ...[
              const SizedBox(width: 10),
              field.trailing!,
            ] else if (field.icon != null) ...[
              const SizedBox(width: 12),
              Icon(
                field.icon,
                size: 21,
                color: _ServiceAccessCardTokens.mutedIconColor,
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _ServiceAccessResultBadge extends StatelessWidget {
  final _ServiceAccessCardBadge badge;

  const _ServiceAccessResultBadge({
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: badge.backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        badge.text,
        style: TextStyle(
          fontSize: _ServiceAccessCardTokens.badgeFontSize,
          height: 1,
          fontWeight: FontWeight.w600,
          color: badge.textColor,
        ),
      ),
    );
  }
}

class _ServiceAccessCopyButton extends StatelessWidget {
  final String value;
  final ValueChanged<String>? onCopy;

  const _ServiceAccessCopyButton({
    required this.value,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onCopy == null ? null : () => onCopy!(value),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        minWidth: 30,
        minHeight: 30,
      ),
      icon: const Icon(
        Icons.copy_outlined,
        size: 17,
        color: _ServiceAccessCardTokens.primaryColor,
      ),
    );
  }
}

class _ServiceAccessCardConfig {
  final Widget? headerIcon;
  final String? titleLabel;
  final String title;
  final String? subtitle;
  final Widget? subtitleTrailing;
  final List<_ServiceAccessCardBadge> badges;
  final List<_ServiceAccessCardField> fields;
  final String? footerTitle;
  final String? footerSubtitle;

  const _ServiceAccessCardConfig({
    this.headerIcon,
    this.titleLabel,
    required this.title,
    this.subtitle,
    this.subtitleTrailing,
    this.badges = const [],
    this.fields = const [],
    this.footerTitle,
    this.footerSubtitle,
  });

  factory _ServiceAccessCardConfig.fromType({
    required ServiceAccessSearchType type,
    required Map<String, dynamic> item,
    ValueChanged<String>? onCopyRegistrationNumber,
  }) {
    switch (type) {
      case ServiceAccessSearchType.bpomProduct:
        return _ServiceAccessCardConfig._bpom(item);

      case ServiceAccessSearchType.doctor:
        return _ServiceAccessCardConfig._doctor(
          item,
          onCopyRegistrationNumber: onCopyRegistrationNumber,
        );

      case ServiceAccessSearchType.healthFacility:
        return _ServiceAccessCardConfig._facility(item);
    }
  }

  factory _ServiceAccessCardConfig._bpom(Map<String, dynamic> product) {
    return _ServiceAccessCardConfig(
      title: _textValue(product, ['productName', 'name', 'nama_produk']),
      subtitle: _textValue(product, ['registrationNumber', 'nie', 'nomor_ijin_edar']),
      subtitleTrailing: const Icon(
        Icons.check_circle,
        size: 18,
        color: _ServiceAccessCardTokens.successColor,
      ),
      fields: [
        _ServiceAccessCardField(
          label: 'Terbit',
          value: _textValue(product, ['issuedDate', 'tanggalTerbit', 'tanggal_terbit']),
        ),
        _ServiceAccessCardField(
          label: 'Masa berlaku',
          value: _textValue(product, ['validUntil', 'masaBerlaku', 'masa_berlaku']),
        ),
        _ServiceAccessCardField(
          label: 'Merek',
          value: _textValue(product, ['brand', 'merek']),
        ),
        _ServiceAccessCardField(
          label: 'Tipe',
          value: _textValue(product, ['type', 'tipe', 'category', 'kategori']),
        ),
        _ServiceAccessCardField(
          label: 'Kemasan',
          value: _textValue(product, ['packaging', 'kemasan']),
        ),
      ],
      footerTitle: _textValue(product, ['registrant', 'pendaftar']),
      footerSubtitle: _textValue(product, ['location', 'lokasi', 'alamat_pendaftar']),
    );
  }

  factory _ServiceAccessCardConfig._doctor(
      Map<String, dynamic> doctor, {
        ValueChanged<String>? onCopyRegistrationNumber,
      }) {
    final registrationNumber = _textValue(doctor, ['registrationNumber', 'str']);

    return _ServiceAccessCardConfig(
      headerIcon: const FaIcon(
        FontAwesomeIcons.stethoscope,
        size: 20,
        color: _ServiceAccessCardTokens.iconColor,
      ),
      titleLabel: 'Tenaga Medis',
      title: _textValue(doctor, ['name', 'nama']),
      fields: [
        _ServiceAccessCardField(
          label: 'Surat Tanda Registrasi',
          value: registrationNumber,
          trailing: _ServiceAccessCopyButton(
            value: registrationNumber,
            onCopy: onCopyRegistrationNumber,
          ),
        ),
        _ServiceAccessCardField(
          label: 'Spesialis',
          value: _textValue(doctor, ['specialization', 'spesialisasi']),
        ),
        _ServiceAccessCardField(
          label: 'Jadwal Praktik',
          value: _textValue(doctor, ['schedule', 'jadwal']),
          trailing: _ServiceAccessResultBadge(
            badge: _ServiceAccessCardBadge.success(
              _textValue(doctor, ['status'], 'Buka'),
            ),
          ),
        ),
        _ServiceAccessCardField(
          label: 'Tempat Praktik',
          value: _textValue(doctor, ['hospital', 'rumahSakit', 'tempatPraktik']),
          subValue: _textValue(doctor, ['city', 'kota'], ''),
          icon: Icons.location_on_outlined,
        ),
        _ServiceAccessCardField(
          label: 'No. Telepon',
          value: _textValue(doctor, ['phone', 'telp', 'telepon']),
          icon: Icons.phone_outlined,
        ),
      ],
    );
  }

  factory _ServiceAccessCardConfig._facility(Map<String, dynamic> facility) {
    final facilityType = _optionalTextValue(
      facility,
      ['facilityType', 'typeLabel', 'jenis_sarana_name', 'type'],
    );

    final kodeSarana = _optionalTextValue(
      facility,
      ['kode_sarana', 'kodeSarana'],
    );

    final facilityClass = _optionalTextValue(
      facility,
      ['facilityClass', 'class', 'kelas', 'kelas_sarana'],
      ignoredValues: {
        if (kodeSarana != null) kodeSarana,
      },
    );

    final operationalStatus = _optionalTextValue(
      facility,
      [
        'operationalStatus',
        'operational_status',
        'status_operasional',
        'status_aktif',
        'statusAktif',
        'status',
      ],
    );

    return _ServiceAccessCardConfig(
      headerIcon: const FaIcon(
        FontAwesomeIcons.hospital,
        size: 20,
        color: _ServiceAccessCardTokens.iconColor,
      ),
      title: _textValue(facility, ['name', 'nama']),
      badges: [
        if (facilityType != null) _ServiceAccessCardBadge.info(facilityType),
        if (facilityClass != null) _ServiceAccessCardBadge.info(facilityClass),
        if (operationalStatus != null)
          _ServiceAccessCardBadge.success(operationalStatus),
      ],
      fields: [
        _ServiceAccessCardField(
          label: 'Alamat',
          value: _textValue(facility, ['address', 'alamat']),
          icon: Icons.location_on_outlined,
        ),
        _ServiceAccessCardField(
          label: 'No. Telepon',
          value: _textValue(facility, ['phone', 'telp', 'telepon']),
          icon: Icons.phone_outlined,
        ),
      ],
    );
  }
}

class _ServiceAccessCardField {
  final String label;
  final String value;
  final String? subValue;
  final IconData? icon;
  final Widget? trailing;

  const _ServiceAccessCardField({
    required this.label,
    required this.value,
    this.subValue,
    this.icon,
    this.trailing,
  });
}

class _ServiceAccessCardBadge {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const _ServiceAccessCardBadge({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  factory _ServiceAccessCardBadge.info(String text) {
    return _ServiceAccessCardBadge(
      text: text,
      backgroundColor: _ServiceAccessCardTokens.infoBadgeBackgroundColor,
      textColor: _ServiceAccessCardTokens.infoBadgeTextColor,
    );
  }

  factory _ServiceAccessCardBadge.success(String text) {
    return _ServiceAccessCardBadge(
      text: text,
      backgroundColor: _ServiceAccessCardTokens.successBadgeBackgroundColor,
      textColor: _ServiceAccessCardTokens.successBadgeTextColor,
    );
  }
}

class _ServiceAccessCardTokens {
  static const double radius = 14;
  static const double cardPadding = 18;
  static const double titleFontSize = 17;
  static const double subtitleFontSize = 14;
  static const double labelFontSize = 13;
  static const double valueFontSize = 14;
  static const double subValueFontSize = 12;
  static const double badgeFontSize = 13;
  static const double footerTitleFontSize = 15;
  static const double footerSubtitleFontSize = 13;

  static const Color primaryColor = Color(0xFF062F5E);
  static const Color contentColor = Color(0xFF252525);
  static const Color labelColor = Color(0xFF777777);
  static const Color mutedColor = Color(0xFFAAAAAA);
  static const Color borderColor = Color(0xFFE5E5E5);
  static const Color dividerColor = Color(0xFFE7E7E7);
  static const Color iconBackgroundColor = Color(0xFFF5F5F5);
  static const Color iconColor = Color(0xFF333333);
  static const Color mutedIconColor = Color(0xFFAAAAAA);
  static const Color successColor = Color(0xFF279A4B);
  static const Color infoBadgeBackgroundColor = Color(0xFFEAF3FF);
  static const Color infoBadgeTextColor = Color(0xFF2471D9);
  static const Color successBadgeBackgroundColor = Color(0xFFE9F9E9);
  static const Color successBadgeTextColor = Color(0xFF2E9E4F);

  static const TextStyle titleTextStyle = TextStyle(
    fontSize: titleFontSize,
    height: 1.3,
    fontWeight: FontWeight.w800,
    color: primaryColor,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: subtitleFontSize,
    height: 1.35,
    color: Color(0xFF666666),
  );

  static const TextStyle labelTextStyle = TextStyle(
    fontSize: labelFontSize,
    color: labelColor,
  );

  static const TextStyle valueTextStyle = TextStyle(
    fontSize: valueFontSize,
    height: 1.4,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );

  static const TextStyle subValueTextStyle = TextStyle(
    fontSize: subValueFontSize,
    color: mutedColor,
  );

  static const TextStyle footerTitleTextStyle = TextStyle(
    fontSize: footerTitleFontSize,
    height: 1.35,
    fontWeight: FontWeight.w600,
    color: contentColor,
  );

  static const TextStyle footerSubtitleTextStyle = TextStyle(
    fontSize: footerSubtitleFontSize,
    height: 1.4,
    color: labelColor,
  );
}

String _textValue(
    Map<String, dynamic> item,
    List<String> keys, [
      String fallback = '-',
    ]) {
  return _optionalTextValue(item, keys) ?? fallback;
}

String? _optionalTextValue(
    Map<String, dynamic> item,
    List<String> keys, {
      Set<String> ignoredValues = const {},
    }) {
  final ignoredNormalized = ignoredValues.map(_normalizeValue).toSet();

  for (final key in keys) {
    final rawValue = item[key];
    if (rawValue == null) continue;

    final value = rawValue.toString().trim();
    if (_isEmptyDisplayValue(value)) continue;
    if (ignoredNormalized.contains(_normalizeValue(value))) continue;

    return value;
  }

  return null;
}

bool _isEmptyDisplayValue(String value) {
  final normalized = _normalizeValue(value);

  return normalized.isEmpty ||
      normalized == '-' ||
      normalized == 'null' ||
      normalized == 'string';
}

String _normalizeValue(String value) {
  return value.trim().toLowerCase();
}

class BpomProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final ValueChanged<Map<String, dynamic>>? onTap;

  const BpomProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _ServiceAccessGenericResultCard(
      config: _ServiceAccessCardConfig._bpom(product),
      onTap: () => onTap?.call(product),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final ValueChanged<Map<String, dynamic>>? onTap;
  final ValueChanged<String>? onCopyRegistrationNumber;

  const DoctorCard({
    super.key,
    required this.doctor,
    this.onTap,
    this.onCopyRegistrationNumber,
  });

  @override
  Widget build(BuildContext context) {
    return _ServiceAccessGenericResultCard(
      config: _ServiceAccessCardConfig._doctor(
        doctor,
        onCopyRegistrationNumber: onCopyRegistrationNumber,
      ),
      onTap: () => onTap?.call(doctor),
    );
  }
}

class FacilityCard extends StatelessWidget {
  final Map<String, dynamic> facility;
  final ValueChanged<Map<String, dynamic>>? onTap;

  const FacilityCard({
    super.key,
    required this.facility,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _ServiceAccessGenericResultCard(
      config: _ServiceAccessCardConfig._facility(facility),
      onTap: () => onTap?.call(facility),
    );
  }
}

class BpomProductInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const BpomProductInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return _ServiceAccessInfoField(
      field: _ServiceAccessCardField(
        label: label,
        value: value,
      ),
    );
  }
}
