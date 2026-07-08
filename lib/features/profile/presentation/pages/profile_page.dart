import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/app_footer.dart';
import '../../../../shared/widgets/breadcrumb_widget.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_detail_akun_tab.dart';
import '../widgets/profile_e_dokumen_tab.dart';
import '../widgets/profile_info_card.dart';
import '../widgets/profile_settings_tab.dart';
import '../widgets/profile_status_tab.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback? onLogout;
  final VoidCallback? onMenuTap;
  final VoidCallback? onBerandaTap;
  final int initialTabIndex;

  const ProfilePage({
    super.key,
    this.onLogout,
    this.onMenuTap,
    this.onBerandaTap,
    this.initialTabIndex = 0,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const int _tabLength = 4;

  int _safeTabIndex(int index) {
    if (index < 0 || index >= _tabLength) return 0;
    return index;
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: _tabLength,
      vsync: this,
      initialIndex: _safeTabIndex(widget.initialTabIndex),
    );
  }

  @override
  void didUpdateWidget(ProfilePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialTabIndex != widget.initialTabIndex) {
      _tabController.animateTo(_safeTabIndex(widget.initialTabIndex));
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _displayName(UserProfileEntity? profile) {
    if (profile == null) {
      return 'Pengguna';
    }

    if (profile.username.trim().isNotEmpty) {
      return profile.username;
    }

    if (profile.email.trim().isNotEmpty) {
      return profile.email;
    }

    return 'Pengguna';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(const LoadProfileRequested()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message.isEmpty
                      ? 'Gagal memuat profil.'
                      : state.message,
                ),
              ),
            );
          }

          if (state.status == ProfileStatus.logoutSuccess) {
            widget.onLogout?.call();
          }
        },
        builder: (context, state) {
          final profile = state.profile;
          final isLoading =
              state.status == ProfileStatus.loading && profile == null;

          return Scaffold(
            backgroundColor: AppColors.backgroundSecondary,
            body: Column(
              children: [
                AppHeader(
                  onMenuTap: widget.onMenuTap,
                  isLoggedIn: true,
                  showLoginButton: false,
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        child: BreadcrumbWidget(
                          items: [
                            BreadcrumbItem(
                              label: 'Beranda',
                              onTap: widget.onBerandaTap,
                            ),
                            const BreadcrumbItem(label: 'Akun Saya'),
                          ],
                        ),
                      ),
                      ProfileInfoCard(
                        name: _displayName(profile),
                        joinDate: isLoading
                            ? 'Memuat data akun...'
                            : 'Data akun dari server',
                        avatarUrl: '',
                      ),
                      if (isLoading)
                        const LinearProgressIndicator(
                          minHeight: 2,
                          color: AppColors.brandPrimary,
                          backgroundColor: AppColors.backgroundSecondary,
                        ),
                      const SizedBox(height: 8),
                      _buildTabSection(
                        context: context,
                        profile: profile,
                      ),
                      const AppFooter(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabSection({
    required BuildContext context,
    required UserProfileEntity? profile,
  }) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            padding: EdgeInsets.zero,
            labelPadding: const EdgeInsets.only(left: 16, right: 16),
            labelColor: AppColors.guide600,
            unselectedLabelColor: AppColors.contentSecondary,
            indicatorColor: AppColors.guide600,
            indicatorWeight: 2.5,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      size: 18,
                    ),
                    SizedBox(width: 6),
                    Text('Detail Akun'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.folder_shared_outlined,
                      size: 18,
                    ),
                    SizedBox(width: 6),
                    Text('E-Dokumen'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.workspace_premium_outlined,
                      size: 18,
                    ),
                    SizedBox(width: 6),
                    Text('Status'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.settings_outlined,
                      size: 18,
                    ),
                    SizedBox(width: 6),
                    Text('Pengaturan'),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _tabController,
          builder: (context, _) {
            switch (_tabController.index) {
              case 1:
                return const ProfileEDokumenTab();
              case 2:
                return ProfileStatusTab(
                  onMenuTap: widget.onMenuTap,
                );
              case 3:
                return const ProfileSettingsTab();
              default:
                return ProfileDetailAkunTab(
                  profile: profile,
                  onLogout: () {
                    context.read<ProfileBloc>().add(
                      const LogoutRequested(),
                    );
                  },
                );
            }
          },
        ),
      ],
    );
  }
}
