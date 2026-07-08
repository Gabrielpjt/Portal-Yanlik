import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final TextEditingController _controller;
  Timer? _timer;
  int _currentIndex = 0;

  static const List<String> _placeholderTexts = [
    'Cara Perpanjang SIM',
    'Pengajuan dokumen akta kelahiran',
    'Pembayaran pajak kendaraan',
    'Lowongan pekerjaan',
  ];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_onTextChanged);
    _startTimer();
  }

  void _onTextChanged() {
    setState(() {});
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _placeholderTexts.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentHintText = _placeholderTexts[_currentIndex];

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokePrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Layanan apa yang Anda butuhkan hari ini?',
            style: TextStyle(
              color: AppColors.brandPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            child: SizedBox(
              height: 48,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  TextField(
                    controller: _controller,
                    style: const TextStyle(
                      color: AppColors.contentPrimary,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      suffixIcon: Container(
                        width: 48,
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.brandPrimary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColors.strokePrimary,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColors.strokePrimary,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColors.brandPrimary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  if (_controller.text.isEmpty)
                    IgnorePointer(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 60.0),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                            return Stack(
                              alignment: Alignment.centerLeft,
                              children: <Widget>[
                                ...previousChildren,
                                if (currentChild != null) currentChild,
                              ],
                            );
                          },
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            final isIncoming = (child.key == ValueKey<String>(currentHintText));
                            final position = isIncoming
                                ? Tween<Offset>(
                                    begin: const Offset(0.0, 1.0),
                                    end: Offset.zero,
                                  ).animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeInOut,
                                    ),
                                  )
                                : Tween<Offset>(
                                    begin: const Offset(0.0, -1.0),
                                    end: Offset.zero,
                                  ).animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeInOut,
                                    ),
                                  );

                            return ClipRect(
                              child: SlideTransition(
                                position: position,
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            key: ValueKey<String>(currentHintText),
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              currentHintText,
                              style: const TextStyle(
                                color: AppColors.contentSecondary,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
