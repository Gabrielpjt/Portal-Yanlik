import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// Widget paginasi reusable.
///
/// Format:
/// << < 1 2 3 ... 50 > >>
/// << < 1 ... 10 ... 50 > >>
/// << < 1 ... 48 49 50 > >>
class AppPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const AppPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  List<_PaginationItem> _visibleItems() {
    if (totalPages <= 1) {
      return const <_PaginationItem>[];
    }

    if (totalPages <= 5) {
      return List<_PaginationItem>.generate(
        totalPages,
            (index) => _PaginationItem.page(index + 1),
      );
    }

    if (currentPage <= 3) {
      return <_PaginationItem>[
        const _PaginationItem.page(1),
        const _PaginationItem.page(2),
        const _PaginationItem.page(3),
        const _PaginationItem.ellipsis(),
        _PaginationItem.page(totalPages),
      ];
    }

    if (currentPage >= totalPages - 2) {
      return <_PaginationItem>[
        const _PaginationItem.page(1),
        const _PaginationItem.ellipsis(),
        _PaginationItem.page(totalPages - 2),
        _PaginationItem.page(totalPages - 1),
        _PaginationItem.page(totalPages),
      ];
    }

    return <_PaginationItem>[
      const _PaginationItem.page(1),
      const _PaginationItem.ellipsis(),
      _PaginationItem.page(currentPage),
      const _PaginationItem.ellipsis(),
      _PaginationItem.page(totalPages),
    ];
  }

  Future<void> _showJumpPageDialog(BuildContext context) async {
    final selectedPage = await showDialog<int>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return _JumpPageDialog(
          totalPages: totalPages,
          initialPage: currentPage,
        );
      },
    );

    if (selectedPage == null) {
      return;
    }

    if (selectedPage < 1 || selectedPage > totalPages) {
      return;
    }

    onPageChanged(selectedPage);
  }

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) {
      return const SizedBox.shrink();
    }

    final items = _visibleItems();
    final safeCurrentPage = currentPage.clamp(1, totalPages);
    final isFirst = safeCurrentPage == 1;
    final isLast = safeCurrentPage == totalPages;

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _NavBtn(
              icon: Icons.keyboard_double_arrow_left,
              enabled: !isFirst,
              onTap: () => onPageChanged(1),
            ),
            const SizedBox(width: 4),
            _NavBtn(
              icon: Icons.chevron_left,
              enabled: !isFirst,
              onTap: () => onPageChanged(safeCurrentPage - 1),
            ),
            const SizedBox(width: 6),
            ...items.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: item.isEllipsis
                    ? _EllipsisBtn(
                  onTap: () => _showJumpPageDialog(context),
                )
                    : _PageNumBtn(
                  number: item.page!,
                  isActive: item.page == safeCurrentPage,
                  onTap: () => onPageChanged(item.page!),
                ),
              );
            }),
            const SizedBox(width: 6),
            _NavBtn(
              icon: Icons.chevron_right,
              enabled: !isLast,
              onTap: () => onPageChanged(safeCurrentPage + 1),
            ),
            const SizedBox(width: 4),
            _NavBtn(
              icon: Icons.keyboard_double_arrow_right,
              enabled: !isLast,
              onTap: () => onPageChanged(totalPages),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaginationItem {
  final int? page;
  final bool isEllipsis;

  const _PaginationItem.page(this.page) : isEllipsis = false;
  const _PaginationItem.ellipsis()
      : page = null,
        isEllipsis = true;
}

class _NavBtn extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _NavBtn({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.strokePrimary),
          ),
          child: Icon(
            icon,
            size: 18,
            color: enabled
                ? AppColors.contentPrimary
                : AppColors.contentSecondary.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}

class _PageNumBtn extends StatelessWidget {
  final int number;
  final bool isActive;
  final VoidCallback onTap;

  const _PageNumBtn({
    required this.number,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? AppColors.brandPrimary : Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: isActive ? null : onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive ? AppColors.brandPrimary : AppColors.strokePrimary,
            ),
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.contentPrimary,
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EllipsisBtn extends StatelessWidget {
  final VoidCallback onTap;

  const _EllipsisBtn({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.strokePrimary),
          ),
          child: const Center(
            child: Text(
              '...',
              style: TextStyle(
                color: Color(0xFF252525),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _JumpPageDialog extends StatefulWidget {
  final int totalPages;
  final int initialPage;

  const _JumpPageDialog({
    required this.totalPages,
    required this.initialPage,
  });

  @override
  State<_JumpPageDialog> createState() => _JumpPageDialogState();
}

class _JumpPageDialogState extends State<_JumpPageDialog> {
  String _value = '';

  bool get _canSubmit {
    final page = int.tryParse(_value);
    return page != null && page >= 1 && page <= widget.totalPages;
  }

  void _appendDigit(String digit) {
    setState(() {
      final maxLength = widget.totalPages.toString().length;

      if (_value == '0') {
        _value = digit;
        return;
      }

      if (_value.length >= maxLength) {
        return;
      }

      _value += digit;
    });
  }

  void _clearAll() {
    setState(() {
      _value = '';
    });
  }

  void _backspace() {
    if (_value.isEmpty) {
      return;
    }

    setState(() {
      _value = _value.substring(0, _value.length - 1);
    });
  }

  void _submit() {
    final page = int.tryParse(_value);

    if (page == null || page < 1 || page > widget.totalPages) {
      return;
    }

    Navigator.of(context).pop(page);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        width: 340,
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Lompat ke halaman',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF252525),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Pilih halaman antara 1–${widget.totalPages}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF777777),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              height: 56,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF062F5E),
                  width: 2,
                ),
              ),
              child: Text(
                _value.isEmpty ? 'Masukkan halaman' : _value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: _value.isEmpty ? 15 : 20,
                  fontWeight: _value.isEmpty ? FontWeight.w500 : FontWeight.w600,
                  color: _value.isEmpty
                      ? const Color(0xFF9A9A9A)
                      : const Color(0xFF252525),
                ),
              ),
            ),
            const SizedBox(height: 18),
            _JumpPageKeypad(
              onDigitTap: _appendDigit,
              onClearTap: _clearAll,
              onBackspaceTap: _backspace,
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _canSubmit ? _submit : null,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF062F5E),
                  disabledBackgroundColor: const Color(0xFFBFC8D4),
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Lompat',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Batal',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF777777),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JumpPageKeypad extends StatelessWidget {
  final ValueChanged<String> onDigitTap;
  final VoidCallback onClearTap;
  final VoidCallback onBackspaceTap;

  const _JumpPageKeypad({
    required this.onDigitTap,
    required this.onClearTap,
    required this.onBackspaceTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _KeypadButton(label: '1', onTap: () => onDigitTap('1')),
            const SizedBox(width: 10),
            _KeypadButton(label: '2', onTap: () => onDigitTap('2')),
            const SizedBox(width: 10),
            _KeypadButton(label: '3', onTap: () => onDigitTap('3')),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _KeypadButton(label: '4', onTap: () => onDigitTap('4')),
            const SizedBox(width: 10),
            _KeypadButton(label: '5', onTap: () => onDigitTap('5')),
            const SizedBox(width: 10),
            _KeypadButton(label: '6', onTap: () => onDigitTap('6')),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _KeypadButton(label: '7', onTap: () => onDigitTap('7')),
            const SizedBox(width: 10),
            _KeypadButton(label: '8', onTap: () => onDigitTap('8')),
            const SizedBox(width: 10),
            _KeypadButton(label: '9', onTap: () => onDigitTap('9')),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _KeypadButton(
              label: 'Hapus',
              onTap: onClearTap,
              isSecondary: true,
            ),
            const SizedBox(width: 10),
            _KeypadButton(label: '0', onTap: () => onDigitTap('0')),
            const SizedBox(width: 10),
            _KeypadIconButton(
              icon: Icons.backspace_outlined,
              onTap: onBackspaceTap,
            ),
          ],
        ),
      ],
    );
  }
}

class _KeypadButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSecondary;

  const _KeypadButton({
    required this.label,
    required this.onTap,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            height: 56,
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: isSecondary ? 15 : 20,
                fontWeight: isSecondary ? FontWeight.w600 : FontWeight.w500,
                color: isSecondary
                    ? const Color(0xFF8A8A8A)
                    : const Color(0xFF252525),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _KeypadIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _KeypadIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            height: 56,
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 22,
              color: const Color(0xFF6B7280),
            ),
          ),
        ),
      ),
    );
  }
}