import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import 'sidebar_search_field.dart';
import 'sidebar_menu_item.dart';
import 'sidebar_section_header.dart';
import 'sidebar_footer.dart';

/// The main application drawer widget that composes all sidebar
/// sub-components into the full navigation panel.
///
/// This widget is designed to be supplied to [Scaffold.drawer].
///
/// Callbacks are exposed for every interactive element so that
/// routing / state management can be wired externally.
class AppDrawer extends StatelessWidget {
  /// Authentication status: whether the user is logged in
  final bool isLoggedIn;

  // Navigation callbacks
  final VoidCallback? onBerandaTap;
  final VoidCallback? onInformasiLayananTap;
  final VoidCallback? onAkunSayaTap;
  final VoidCallback? onNotifikasiTap;
  final VoidCallback? onPengaturanTap;
  final VoidCallback? onKeluarAkunTap;
  final VoidCallback? onApiTestTap;

  // Footer callbacks
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;

  // Search callback
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onSearchSubmitted;

  const AppDrawer({
    super.key,
    this.isLoggedIn = false,
    this.onBerandaTap,
    this.onInformasiLayananTap,
    this.onAkunSayaTap,
    this.onNotifikasiTap,
    this.onPengaturanTap,
    this.onKeluarAkunTap,
    this.onApiTestTap,
    this.onTermsTap,
    this.onPrivacyTap,
    this.onSearchChanged,
    this.onSearchSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * 0.82,
      backgroundColor: AppColors.backgroundPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: SafeArea(
        child: Column(
          children: [
            // ── Header: Logo + Close button ──
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 12, 0),
              child: Row(
                children: [
                  // Logo
                  Image.asset(
                    AppAssets.logoInaku,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text(
                        'INAKU',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.brandPrimary,
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  // Close button
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: AppColors.contentPrimary,
                    iconSize: 24,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Search field ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SidebarSearchField(
                onChanged: onSearchChanged,
                onSubmitted: onSearchSubmitted,
              ),
            ),

            const SizedBox(height: 8),

            // ── Scrollable menu content ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // ── Main navigation items ──
                    SidebarMenuItem(
                      iconData: Icons.home_outlined,
                      label: 'Beranda',
                      onTap: () {
                        Navigator.of(context).pop();
                        onBerandaTap?.call();
                      },
                    ),

                    SidebarMenuItem(
                      iconData: Icons.dashboard_customize_outlined,
                      label: 'Layanan Publik',
                      isExpandable: true,
                      children: const [],
                    ),

                    SidebarMenuItem(
                      iconData: Icons.info_outline,
                      label: 'Informasi Layanan',
                      onTap: () {
                        Navigator.of(context).pop();
                        onInformasiLayananTap?.call();
                      },
                    ),

                    SidebarMenuItem(
                      iconData: Icons.support_agent_outlined,
                      label: 'Aduan dan Bantuan',
                      isExpandable: true,
                      children: const [],
                    ),

                    if (isLoggedIn) ...[
                      const SizedBox(height: 8),

                      // ── Profile section ──
                      const SidebarSectionHeader(title: 'Profil Anda'),

                      SidebarMenuItem(
                        leadingWidget: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.backgroundSecondary,
                            border: Border.all(
                              color: AppColors.strokePrimary,
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: AppColors.contentSecondary,
                            size: 18,
                          ),
                        ),
                        label: 'Akun Saya',
                        onTap: () {
                          Navigator.of(context).pop();
                          onAkunSayaTap?.call();
                        },
                      ),

                      SidebarMenuItem(
                        iconData: Icons.chat_bubble_outline,
                        label: 'Notifikasi',
                        onTap: () {
                          Navigator.of(context).pop();
                          onNotifikasiTap?.call();
                        },
                      ),

                      SidebarMenuItem(
                        iconData: Icons.settings_outlined,
                        label: 'Pengaturan',
                        onTap: () {
                          Navigator.of(context).pop();
                          onPengaturanTap?.call();
                        },
                      ),

                      const SizedBox(height: 4),

                      SidebarMenuItem(
                        iconData: Icons.logout,
                        label: 'Keluar Akun',
                        labelColor: Colors.red,
                        iconColor: Colors.red,
                        onTap: () {
                          Navigator.of(context).pop();
                          onKeluarAkunTap?.call();
                        },
                      ),
                    ],

                    const SizedBox(height: 16),
                    const SidebarSectionHeader(title: 'Developer'),
                    SidebarMenuItem(
                      iconData: Icons.bug_report_outlined,
                      label: 'API Test',
                      onTap: () {
                        Navigator.of(context).pop();
                        onApiTestTap?.call();
                      },
                    ),
                  ],
                ),
              ),
            ),

            // ── Footer ──
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
              child: SidebarFooter(
                onTermsTap: onTermsTap,
                onPrivacyTap: onPrivacyTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
