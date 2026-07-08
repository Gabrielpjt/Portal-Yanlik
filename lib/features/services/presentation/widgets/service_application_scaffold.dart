import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_footer.dart';
import '../../../../shared/widgets/app_header.dart';
import 'service_application_common_widgets.dart';

class ServiceApplicationScaffold extends StatefulWidget {
  final String title;
  final String description;
  final int currentStep;
  final int totalSteps;
  final String stepTitle;
  final Widget content;
  final Object? contentKey;
  final VoidCallback onBack;
  final bool showProgress;
  final bool isLoggedIn;
  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;

  const ServiceApplicationScaffold({
    super.key,
    required this.title,
    required this.description,
    required this.currentStep,
    required this.totalSteps,
    required this.stepTitle,
    required this.content,
    required this.onBack,
    this.contentKey,
    this.showProgress = true,
    this.isLoggedIn = false,
    this.onMenuTap,
    this.onLoginTap,
  });

  @override
  State<ServiceApplicationScaffold> createState() {
    return _ServiceApplicationScaffoldState();
  }
}

class _ServiceApplicationScaffoldState
    extends State<ServiceApplicationScaffold> {
  final ScrollController _scrollController = ScrollController();

  double get _progress {
    if (widget.totalSteps <= 0) {
      return 0;
    }

    return ((widget.currentStep + 1) / widget.totalSteps)
        .clamp(0, 1)
        .toDouble();
  }

  @override
  void didUpdateWidget(
      covariant ServiceApplicationScaffold oldWidget,
      ) {
    super.didUpdateWidget(oldWidget);

    final stepChanged =
        oldWidget.currentStep != widget.currentStep;
    final contentChanged =
        oldWidget.contentKey != widget.contentKey;
    final progressVisibilityChanged =
        oldWidget.showProgress != widget.showProgress;

    if (stepChanged ||
        contentChanged ||
        progressVisibilityChanged) {
      _scrollToTop();
    }
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) {
        return;
      }

      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  void _runParentAction(VoidCallback callback) {
    final navigator = Navigator.of(context);

    if (navigator.canPop()) {
      navigator.pop(false);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppHeader(
            isLoggedIn: widget.isLoggedIn,
            onMenuTap: widget.onMenuTap == null
                ? null
                : () {
              _runParentAction(
                widget.onMenuTap!,
              );
            },
            onLoginTap: widget.onLoginTap == null
                ? null
                : () {
              _runParentAction(
                widget.onLoginTap!,
              );
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      18,
                      16,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                      children: [
                        ServiceApplicationBackButton(
                          onTap: widget.onBack,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Color(0xFF252525),
                            fontSize: 20,
                            height: 1.3,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.description,
                          style: const TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 14,
                            height: 1.45,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (widget.showProgress) ...[
                          const SizedBox(height: 18),
                          _buildProgressSection(),
                        ],
                        const SizedBox(height: 22),
                        AnimatedSwitcher(
                          duration:
                          const Duration(milliseconds: 220),
                          child: KeyedSubtree(
                            key: ValueKey(
                              widget.contentKey ??
                                  widget.currentStep,
                            ),
                            child: widget.content,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const AppFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: LinearProgressIndicator(
            value: _progress,
            minHeight: 5,
            backgroundColor: const Color(0xFFE8EDF3),
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFF062F5E),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                widget.stepTitle,
                style: const TextStyle(
                  color: Color(0xFF062F5E),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              '${widget.currentStep + 1}/${widget.totalSteps} tahap',
              style: const TextStyle(
                color: Color(0xFF555555),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
