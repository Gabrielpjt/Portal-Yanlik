import 'package:flutter/material.dart';

class ServiceApplicationBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const ServiceApplicationBackButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back,
                size: 18,
                color: Color(0xFF062F5E),
              ),
              SizedBox(width: 8),
              Text(
                'Kembali',
                style: TextStyle(
                  color: Color(0xFF062F5E),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceApplicationSubsectionTitle extends StatelessWidget {
  final String title;

  const ServiceApplicationSubsectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF333333),
        fontSize: 16,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class ServiceApplicationInformationBanner extends StatelessWidget {
  final String? message;
  final InlineSpan? richMessage;

  const ServiceApplicationInformationBanner({
    super.key,
    this.message,
    this.richMessage,
  }) : assert(
  message != null || richMessage != null,
  'message atau richMessage harus diisi',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F9FF),
        border: Border.all(
          color: const Color(0xFF3C80FF),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info,
            size: 16,
            color: Color(0xFF216BF3),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              richMessage ?? TextSpan(text: message),
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                color: Color(0xFF333333),
                height: 1.4,
              ),
            )
          ),
        ],
      ),
    );
  }
}

class ServiceApplicationDocumentValidationCard extends StatelessWidget {
  final String title;
  final String category;
  final String documentNumber;
  final String statusLabel;

  const ServiceApplicationDocumentValidationCard({
    super.key,
    required this.title,
    required this.category,
    required this.documentNumber,
    this.statusLabel = 'Valid',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border.all(
          color: const Color(0xFFE5E5E5),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF062F5E),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: const TextStyle(
                    color: Color(0xFF777777),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  documentNumber,
                  style: const TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 7,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE4F6E8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 13,
                  color: Color(0xFF2C9142),
                ),
                const SizedBox(width: 3),
                Text(
                  statusLabel,
                  style: const TextStyle(
                    color: Color(0xFF2C9142),
                    fontSize:12,
                    fontWeight: FontWeight.w600,
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

class ServiceApplicationLabeledTextField extends StatelessWidget {
  final String label;
  final bool requiredField;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? suffixText;
  final Widget? suffixIcon;
  final String? hintText;
  final String? errorText;
  final int maxLines;
  final bool readOnly;
  final bool enabled;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;

  const ServiceApplicationLabeledTextField({
    super.key,
    required this.label,
    required this.controller,
    this.requiredField = false,
    this.keyboardType,
    this.suffixText,
    this.suffixIcon,
    this.hintText,
    this.errorText,
    this.maxLines = 1,
    this.readOnly = false,
    this.enabled = true,
    this.onTap,
    this.onChanged,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ServiceApplicationFieldLabel(
          label: label,
          requiredField: requiredField,
        ),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          readOnly: readOnly,
          enabled: enabled,
          onTap: onTap,
          onChanged: onChanged,
          textInputAction: textInputAction,
          style: const TextStyle(
            color: Color(0xFF444444),
            fontSize: 14,
          ),
          decoration: serviceApplicationFieldDecoration(
            suffixText: suffixText,
            suffixIcon: suffixIcon,
            hintText: hintText,
            errorText: errorText,
            enabled: enabled,
          ),
        ),
      ],
    );
  }
}

class ServiceApplicationDropdownField<T> extends StatelessWidget {
  final String label;
  final bool requiredField;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final bool enabled;

  const ServiceApplicationDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    this.onChanged,
    this.requiredField = false,
    this.hintText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ServiceApplicationFieldLabel(
          label: label,
          requiredField: requiredField,
        ),
        const SizedBox(height: 7),
        DropdownButtonFormField<T>(
          value: value,
          isExpanded: true,
          hint: hintText == null
              ? null
              : Text(
            hintText!,
            style: const TextStyle(
              color: Color(0xFFAAAAAA),
              fontSize: 13,
            ),
          ),
          decoration: serviceApplicationFieldDecoration(
            enabled: enabled,
          ),
          items: items,
          onChanged: enabled ? onChanged : null,
          style: const TextStyle(
            color: Color(0xFF444444),
            fontSize: 12,
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 20,
          ),
        ),
      ],
    );
  }
}

class ServiceApplicationPersonValidationCard extends StatelessWidget {
  final String name;
  final String familyNumber;
  final String citizenship;

  const ServiceApplicationPersonValidationCard({
    super.key,
    required this.name,
    required this.familyNumber,
    this.citizenship = 'Indonesia',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border.all(
          color: const Color(0xFFE6E6E6),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _ServiceApplicationSmallInformation(
                  label: 'Nama',
                  value: name,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ServiceApplicationSmallInformation(
                  label: 'No. Kartu Keluarga',
                  value: familyNumber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: _ServiceApplicationSmallInformation(
              label: 'Kewarganegaraan',
              value: citizenship,
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceApplicationSummaryData {
  final String label;
  final String value;

  const ServiceApplicationSummaryData({
    required this.label,
    required this.value,
  });
}

class ServiceApplicationSummaryGroup extends StatelessWidget {
  final String title;
  final List<ServiceApplicationSummaryData> rows;

  const ServiceApplicationSummaryGroup({
    super.key,
    required this.title,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE5E5E5),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF062F5E),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: rows.map((row) {
              return SizedBox(
                width: 132,
                child: _ServiceApplicationSmallInformation(
                  label: row.label,
                  value: row.value,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ServiceApplicationActions extends StatelessWidget {
  final String? primaryLabel;
  final VoidCallback? onPrimaryPressed;
  final String? secondaryLabel;
  final VoidCallback? onSecondaryPressed;
  final String? cancelLabel;
  final VoidCallback? onCancelPressed;

  const ServiceApplicationActions({
    super.key,
    this.primaryLabel = 'Selanjutnya',
    this.onPrimaryPressed,
    this.secondaryLabel = 'Sebelumnya',
    this.onSecondaryPressed,
    this.cancelLabel = 'Batal',
    this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = <Widget>[];

    if (primaryLabel != null) {
      buttons.add(
        _ServiceApplicationPrimaryButton(
          label: primaryLabel!,
          onPressed: onPrimaryPressed,
        ),
      );
    }

    if (secondaryLabel != null) {
      buttons.add(
        _ServiceApplicationSecondaryButton(
          label: secondaryLabel!,
          onPressed: onSecondaryPressed,
        ),
      );
    }

    if (cancelLabel != null) {
      buttons.add(
        _ServiceApplicationSecondaryButton(
          label: cancelLabel!,
          onPressed: onCancelPressed,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int index = 0; index < buttons.length; index++) ...[
          if (index > 0) const SizedBox(height: 9),
          buttons[index],
        ],
      ],
    );
  }
}

class ServiceApplicationSuccessView extends StatelessWidget {
  final String title;
  final String description;
  final String statusButtonLabel;
  final String returnButtonLabel;
  final VoidCallback onStatusPressed;
  final VoidCallback onReturnPressed;

  const ServiceApplicationSuccessView({
    super.key,
    required this.title,
    required this.description,
    required this.onStatusPressed,
    required this.onReturnPressed,
    this.statusButtonLabel = 'Lihat status',
    this.returnButtonLabel = 'Kembali ke Layanan',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 6),
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF27883B),
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 36,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF062F5E),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF666666),
              fontSize: 15,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: _ServiceApplicationSecondaryButton(
            label: statusButtonLabel,
            onPressed: onStatusPressed,
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: onReturnPressed,
          child: Text(
            returnButtonLabel,
            style: const TextStyle(
              color: Color(0xFF062F5E),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

Future<bool?> showServiceApplicationConfirmationDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  String confirmLabel = 'Ya',
  String cancelLabel = 'Tidak',
  bool barrierDismissible = false,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (dialogContext) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 420,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              16,
              18,
              18,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.of(dialogContext).pop(false);
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: const Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                content,
                const SizedBox(height: 18),
                ServiceApplicationActions(
                  primaryLabel: confirmLabel,
                  onPrimaryPressed: () {
                    Navigator.of(dialogContext).pop(true);
                  },
                  secondaryLabel: cancelLabel,
                  onSecondaryPressed: () {
                    Navigator.of(dialogContext).pop(false);
                  },
                  cancelLabel: null,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

InputDecoration serviceApplicationFieldDecoration({
  String? suffixText,
  Widget? suffixIcon,
  String? hintText,
  String? errorText,
  bool enabled = true,
}) {
  return InputDecoration(
    isDense: true,
    suffixText: suffixText,
    suffixIcon: suffixIcon,
    hintText: hintText,
    errorText: errorText,
    filled: !enabled,
    fillColor: enabled
        ? Colors.white
        : const Color(0xFFF5F5F5),
    hintStyle: const TextStyle(
      color: Color(0xFFAAAAAA),
      fontSize: 13,
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 13,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: const BorderSide(
        color: Color(0xFFE0E3E7),
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: const BorderSide(
        color: Color(0xFFE5E5E5),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: const BorderSide(
        color: Color(0xFF216BF3),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: const BorderSide(
        color: Color(0xFFE33B3B),
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: const BorderSide(
        color: Color(0xFFE33B3B),
      ),
    ),
  );
}

class _ServiceApplicationFieldLabel extends StatelessWidget {
  final String label;
  final bool requiredField;

  const _ServiceApplicationFieldLabel({
    required this.label,
    required this.requiredField,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(text: label),
          if (requiredField)
            const TextSpan(
              text: ' *',
              style: TextStyle(
                color: Color(0xFFE33B3B),
              ),
            ),
        ],
      ),
    );
  }
}

class _ServiceApplicationSmallInformation extends StatelessWidget {
  final String label;
  final String value;

  const _ServiceApplicationSmallInformation({
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
            color: Color(0xFF888888),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF062F5E),
            fontSize: 14,
            height: 1.3,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ServiceApplicationPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _ServiceApplicationPrimaryButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF062F5E),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFECECEC),
          disabledForegroundColor: const Color(0xFFAAAAAA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _ServiceApplicationSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _ServiceApplicationSecondaryButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF333333),
          disabledForegroundColor: const Color(0xFFAAAAAA),
          backgroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFF4F4F4),
          side: const BorderSide(
            color: Color(0xFFE0E0E0),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
