import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

/// A reusable sidebar menu item that supports:
/// - A leading icon (via [IconData] or a custom [Widget])
/// - A label
/// - An optional trailing expand/collapse chevron for sub-menus
/// - An optional custom text color (e.g. red for "Keluar Akun")
///
/// When [isExpandable] is true and [children] are provided, tapping
/// the item toggles a sub-menu. Otherwise, [onTap] is invoked.
class SidebarMenuItem extends StatefulWidget {
  final IconData? iconData;
  final Widget? leadingWidget;
  final String label;
  final VoidCallback? onTap;
  final bool isExpandable;
  final List<SidebarMenuItem>? children;
  final Color? labelColor;
  final Color? iconColor;

  const SidebarMenuItem({
    super.key,
    this.iconData,
    this.leadingWidget,
    required this.label,
    this.onTap,
    this.isExpandable = false,
    this.children,
    this.labelColor,
    this.iconColor,
  }) : assert(
          iconData != null || leadingWidget != null,
          'Either iconData or leadingWidget must be provided',
        );

  @override
  State<SidebarMenuItem> createState() => _SidebarMenuItemState();
}

class _SidebarMenuItemState extends State<SidebarMenuItem>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _animationController;
  late final Animation<double> _rotationAnimation;
  late final Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.isExpandable) {
      setState(() {
        _isExpanded = !_isExpanded;
        if (_isExpanded) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      });
    } else {
      widget.onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final resolvedIconColor =
        widget.iconColor ?? AppColors.contentPrimary;
    final resolvedLabelColor =
        widget.labelColor ?? AppColors.contentPrimary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main menu row
        InkWell(
          onTap: _handleTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 16,
            ),
            child: Row(
              children: [
                // Leading icon or widget
                if (widget.leadingWidget != null)
                  SizedBox(width: 28, height: 28, child: widget.leadingWidget!)
                else
                  Icon(
                    widget.iconData,
                    color: resolvedIconColor,
                    size: 24,
                  ),

                const SizedBox(width: 16),

                // Label
                Expanded(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      color: resolvedLabelColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Trailing chevron (expandable items only)
                if (widget.isExpandable)
                  RotationTransition(
                    turns: _rotationAnimation,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.contentPrimary,
                      size: 24,
                    ),
                  ),
              ],
            ),
          ),
        ),

        // Expandable children
        if (widget.isExpandable && widget.children != null)
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Column(
                children: widget.children!,
              ),
            ),
          ),
      ],
    );
  }
}
