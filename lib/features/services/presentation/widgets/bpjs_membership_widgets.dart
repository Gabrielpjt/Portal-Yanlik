import 'package:flutter/material.dart';

class BpjsMembershipSearchField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onClear;

  const BpjsMembershipSearchField({
    required this.controller,
    required this.onSearch,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return TextField(
          controller: controller,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => onSearch(),
          decoration: InputDecoration(
            hintText: 'Cari nama atau nomor kepesertaan',
            hintStyle: const TextStyle(
              fontSize: 13,
              color: Color(0xFFAAAAAA),
            ),
            prefixIcon: const Icon(
              Icons.search,
              size: 20,
              color: Color(0xFF999999),
            ),
            suffixIcon: value.text.trim().isEmpty
                ? null
                : IconButton(
              onPressed: onClear,
              icon: const Icon(
                Icons.cancel,
                size: 18,
                color: Color(0xFFAAAAAA),
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFE1E1E1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF2D7FF0),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BpjsMembershipSortButton extends StatelessWidget {
  final String selectedValue;
  final ValueChanged<String> onSelected;

  const BpjsMembershipSortButton({
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: 'Terbaru',
            child: Text('Terbaru'),
          ),
          PopupMenuItem(
            value: 'Terlama',
            child: Text('Terlama'),
          ),
        ];
      },
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE1E1E1),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedValue,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF062F5E),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 19,
              color: Color(0xFF062F5E),
            ),
          ],
        ),
      ),
    );
  }
}

class BpjsInformationBanner extends StatelessWidget {
  final VoidCallback onWhatsappTap;
  final VoidCallback onCareCenterTap;

  const BpjsInformationBanner({
    required this.onWhatsappTap,
    required this.onCareCenterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFF),
        border: Border.all(
          color: const Color(0xFF2D7FF0),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            size: 19,
            color: Color(0xFF1769E0),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Jika terdapat ketidaksesuaian data, peserta dapat menyampaikan perubahan data melalui kanal yang tersedia dengan menyediakan dokumen terbaru.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                    color: Color(0xFF444444),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 14,
                  runSpacing: 8,
                  children: [
                    _TextLink(
                      label: 'Whatsapp Pandawa',
                      onTap: onWhatsappTap,
                    ),
                    _TextLink(
                      label: 'BPJS Care Center',
                      onTap: onCareCenterTap,
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

class _TextLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _TextLink({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
          color: Color(0xFF1769E0),
        ),
      ),
    );
  }
}

class BpjsMembershipCard extends StatelessWidget {
  final Map<String, dynamic> membership;
  final VoidCallback onCopyNumber;

  const BpjsMembershipCard({
    required this.membership,
    required this.onCopyNumber,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = membership['active'] == true;
    final borderColor = isActive
        ? const Color(0xFF48A65D)
        : const Color(0xFFE7E7E7);
    final backgroundColor = isActive
        ? const Color(0xFFFCFFFC)
        : const Color(0xFFF8F8F8);
    final primaryTextColor = isActive
        ? const Color(0xFF164775)
        : const Color(0xFF777777);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _MembershipStatusBadge(isActive: isActive),
              const Spacer(),
              if (!isActive)
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 14,
                        color: Color(0xFFE53935),
                      ),
                      Flexible(
                        child: Text(
                          membership['inactiveReason'] as String? ??
                              'Kepesertaan tidak aktif',
                          maxLines: 2,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                            color: Color(0xFFE53935),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.person,
                  size: 22,
                  color: isActive
                      ? const Color(0xFFE87B2A)
                      : const Color(0xFFAAAAAA),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      membership['name'] as String? ?? '-',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: primaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            membership['number'] as String? ?? '-',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: isActive
                                  ? const Color(0xFF777777)
                                  : const Color(0xFFAAAAAA),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        InkWell(
                          onTap: onCopyNumber,
                          borderRadius: BorderRadius.circular(4),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(
                              Icons.copy_outlined,
                              size: 13,
                              color: isActive
                                  ? const Color(0xFF164775)
                                  : const Color(0xFFAAAAAA),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _MembershipDetailItem(
            label: 'Tipe Kepesertaan',
            value: membership['membershipType'] as String? ?? '-',
            enabled: isActive,
          ),
          const SizedBox(height: 12),
          _MembershipDetailItem(
            label: 'Kelompok',
            value: membership['group'] as String? ?? '-',
            enabled: isActive,
          ),
          const SizedBox(height: 12),
          _MembershipDetailItem(
            label: 'Faskes Umum',
            value: membership['facility'] as String? ?? '-',
            enabled: isActive,
          ),
        ],
      ),
    );
  }
}

class _MembershipStatusBadge extends StatelessWidget {
  final bool isActive;

  const _MembershipStatusBadge({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFFE9F8E9)
            : const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        isActive ? 'Aktif' : 'Tidak aktif',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: isActive
              ? const Color(0xFF2E9E4F)
              : const Color(0xFF777777),
        ),
      ),
    );
  }
}

class _MembershipDetailItem extends StatelessWidget {
  final String label;
  final String value;
  final bool enabled;

  const _MembershipDetailItem({
    required this.label,
    required this.value,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: enabled
                ? const Color(0xFF888888)
                : const Color(0xFFB0B0B0),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            height: 1.45,
            fontWeight: FontWeight.w600,
            color: enabled
                ? const Color(0xFF164775)
                : const Color(0xFF8E8E8E),
          ),
        ),
      ],
    );
  }
}
