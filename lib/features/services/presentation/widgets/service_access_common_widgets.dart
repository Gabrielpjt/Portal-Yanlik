import 'package:flutter/material.dart';

class ServiceAccessBackButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const ServiceAccessBackButton({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.of(context).pop(),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.arrow_back,
              size: 19,
              color: Color(0xFF082F5B),
            ),
            const SizedBox(width: 9),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF082F5B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceAccessSearchBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onSearch;
  final VoidCallback onClear;

  const ServiceAccessSearchBox({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSearch,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        border: Border.all(
          color: const Color(0xFFE2E2E2),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, child) {
          final hasText = value.text.trim().isNotEmpty;
          final suffixWidth = hasText ? 104.0 : 56.0;

          return TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => onSearch(),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFFAAAAAA),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.only(
                left: 14,
                top: 14,
                bottom: 14,
              ),
              suffixIconConstraints: BoxConstraints(
                minWidth: suffixWidth,
                maxWidth: suffixWidth,
                minHeight: 56,
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasText)
                    SizedBox(
                      width: 48,
                      child: IconButton(
                        onPressed: onClear,
                        icon: const Icon(
                          Icons.cancel,
                          size: 19,
                          color: Color(0xFFAAAAAA),
                        ),
                      ),
                    ),
                  Container(
                    margin: const EdgeInsets.all(4),
                    child: Material(
                      color: const Color(0xFF062F5E),
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: onSearch,
                        borderRadius: BorderRadius.circular(8),
                        child: const SizedBox(
                          width: 48,
                          height: 48,
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                  color: Color(0xFF062F5E),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ServiceAccessSearchEmptyState extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;
  final double height;
  final bool boxed;

  const ServiceAccessSearchEmptyState({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.height = 250,
    this.boxed = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = SizedBox(
      width: double.infinity,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFF0F0F0),
              ),
            ),
            child: Container(
              width: 76,
              height: 76,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFE8E8E8),
                ),
              ),
              child: Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF8F8F8),
                  border: Border.all(
                    color: const Color(0xFFE0E0E0),
                  ),
                ),
                child: icon,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              height: 1.3,
              fontWeight: FontWeight.w700,
              color: Color(0xFF252525),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Color(0xFF666666),
              ),
            ),
          ),
        ],
      ),
    );

    if (!boxed) {
      return content;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE5E5E5),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: content,
    );
  }
}

class ServiceAccessSearchActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const ServiceAccessSearchActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(46),
        foregroundColor: const Color(0xFF062F5E),
        side: const BorderSide(
          color: Color(0xFFE0E0E0),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            icon,
            size: 18,
          ),
        ],
      ),
    );
  }
}

class ServiceAccessCategoryChip extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  const ServiceAccessCategoryChip({
    super.key,
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF062F5E)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected
                  ? const Color(0xFF062F5E)
                  : const Color(0xFFE0E0E0),
            ),
          ),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: selected
                      ? Colors.white
                      : const Color(0xFF062F5E),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                constraints: const BoxConstraints(
                  minWidth: 19,
                  minHeight: 19,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  color: selected
                      ? Colors.white
                      : const Color(0xFFF0F0F0),
                ),
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF062F5E),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceAccessSectionTitle extends StatelessWidget {
  final String title;

  const ServiceAccessSectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        height: 1.3,
        fontWeight: FontWeight.w800,
        color: Color(0xFF252525),
      ),
    );
  }
}

class ServiceAccessInformationItem extends StatelessWidget {
  final String label;
  final String value;
  final String? secondaryValue;

  const ServiceAccessInformationItem({
    super.key,
    required this.label,
    required this.value,
    this.secondaryValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF888888),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 6),
        ],
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            height: 1.4,
            fontWeight: FontWeight.w700,
            color: Color(0xFF333333),
          ),
        ),
        if (secondaryValue != null) ...[
          const SizedBox(height: 4),
          Text(
            secondaryValue!,
            style: const TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Color(0xFF888888),
            ),
          ),
        ],
      ],
    );
  }
}
