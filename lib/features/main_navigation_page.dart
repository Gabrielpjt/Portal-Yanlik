import 'package:flutter/material.dart';

import '../app/router/app_router.dart';
import '../app/theme/app_colors.dart';
import '../core/widgets/navigation/sidebar/app_drawer.dart';
import '../shared/navigation/main_navigation_controller.dart';
import 'home/presentation/pages/home_page.dart';
import 'informasi_layanan/presentation/pages/informasi_layanan_page.dart';
import 'profile/presentation/pages/login_page.dart';
import 'profile/presentation/pages/profile_page.dart';
import 'profile/presentation/widgets/profile_status_tab.dart';
import 'search/presentation/pages/search_page.dart';
import 'services/presentation/pages/services_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({
    super.key,
  });

  @override
  State<MainNavigationPage> createState() {
    return _MainNavigationPageState();
  }
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
  GlobalKey<ScaffoldState>();

  int _currentIndex = 0;
  int _profileInitialTab = 0;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    MainNavigationController.instance.attach(
      onHome: _onNavigateHome,
      onServices: _openServicesTab,
      onLogin: _openLoginTab,
      onProfile: _openProfileTab,
      onProfileStatus: _openProfileStatusTab,
      onOpenMenu: _openDrawer,
    );
  }

  @override
  void dispose() {
    MainNavigationController.instance.detach();
    super.dispose();
  }

  void _closeDrawerIfNeeded() {
    final scaffoldState = _scaffoldKey.currentState;

    if (scaffoldState?.isDrawerOpen ?? false) {
      scaffoldState?.closeDrawer();
    }
  }

  void _popToMainNavigation() {
    _closeDrawerIfNeeded();

    Navigator.of(
      context,
      rootNavigator: true,
    ).popUntil((route) => route.isFirst);
  }

  void _openMainTab(
      int index, {
        int profileTab = 0,
      }) {
    _popToMainNavigation();

    if (!mounted) {
      return;
    }

    setState(() {
      _currentIndex = index;

      if (index == 3) {
        _profileInitialTab = profileTab;
      }
    });
  }

  void _onLoginSuccess() {
    _popToMainNavigation();

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoggedIn = true;
      _profileInitialTab = 0;
      _currentIndex = 3;
    });
  }

  void _onLogout() {
    ProfileStatusStore.clear();
    _popToMainNavigation();

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoggedIn = false;
      _currentIndex = 0;
      _profileInitialTab = 0;
    });
  }

  void _onNavigateHome() {
    _openMainTab(0);
  }

  void _openServicesTab() {
    _openMainTab(2);
  }

  void _openLoginTab() {
    _openMainTab(3);
  }

  void _openProfileTab() {
    _openMainTab(
      3,
      profileTab: 0,
    );
  }

  void _openProfileEdokumenTab() {
    _openMainTab(
      3,
      profileTab: 1,
    );
  }

  void _openProfileStatusTab() {
    _openMainTab(
      3,
      profileTab: 2,
    );
  }

  void _openDrawer() {
    final mainRouteIsVisible =
        ModalRoute.of(context)?.isCurrent ?? false;

    if (mainRouteIsVisible) {
      _scaffoldKey.currentState?.openDrawer();
      return;
    }

    showGeneralDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierLabel: 'Menu navigasi',
      barrierColor: Colors.black.withValues(
        alpha: 0.45,
      ),
      transitionDuration: const Duration(
        milliseconds: 220,
      ),
      pageBuilder: (
          dialogContext,
          animation,
          secondaryAnimation,
          ) {
        return SafeArea(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: MediaQuery.sizeOf(dialogContext).width * 0.86,
                height: double.infinity,
                child: _buildAppDrawer(),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
          ) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
          ),
          child: child,
        );
      },
    );
  }

  void _openInformasiLayananPage() {
    _popToMainNavigation();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => InformasiLayananPage(
          isLoggedIn: _isLoggedIn,
          onLoginTap: _openLoginTab,
          onBerandaTap: _onNavigateHome,
          onAkunSayaTap: _openProfileTab,
          onKeluarAkunTap: _onLogout,
        ),
      ),
    );
  }

  void _handleBottomNavigationTap(int index) {
    if (index == 3) {
      if (_isLoggedIn) {
        _openProfileTab();
      } else {
        _openLoginTab();
      }

      return;
    }

    _openMainTab(index);
  }

  Widget _buildAppDrawer() {
    return AppDrawer(
      isLoggedIn: _isLoggedIn,
      onBerandaTap: _onNavigateHome,
      onAkunSayaTap: _openProfileTab,
      onNotifikasiTap: () {},
      onPengaturanTap: () {},
      onInformasiLayananTap: _openInformasiLayananPage,
      onApiTestTap: () {
        _popToMainNavigation();
        Navigator.of(context).pushNamed(AppRouter.apiTest);
      },
      onKeluarAkunTap: _onLogout,
    );
  }

  List<Widget> _buildPages() {
    return [
      HomePage(
        onMenuTap: _openDrawer,
        onLoginTap: _openLoginTab,
        onServicesTap: _openServicesTab,
        onEdokumenTap: _openProfileEdokumenTab,
        onAkunSayaTap: _openLoginTab,
        onKeluarAkunTap: _onLogout,
        isLoggedIn: _isLoggedIn,
      ),
      SearchPage(
        onMenuTap: _openDrawer,
        onLoginTap: _openLoginTab,
        isLoggedIn: _isLoggedIn,
      ),
      ServicesPage(
        onMenuTap: _openDrawer,
        onLoginTap: _openLoginTab,
        onServicesTap: _openServicesTab,
        onProfileTap: _openProfileTab,
        isLoggedIn: _isLoggedIn,
      ),
      _isLoggedIn
          ? ProfilePage(
        key: ValueKey<int>(_profileInitialTab),
        onLogout: _onLogout,
        onMenuTap: _openDrawer,
        onBerandaTap: _onNavigateHome,
        initialTabIndex: _profileInitialTab,
      )
          : LoginPage(
        onLoginSuccess: _onLoginSuccess,
        onNavigateHome: _onNavigateHome,
        onMenuTap: _openDrawer,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pages = _buildPages();

    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      drawer: _buildAppDrawer(),
      body: IndexedStack(
        index: _currentIndex < pages.length
            ? _currentIndex
            : 0,
        children: pages,
      ),
      bottomNavigationBar: _buildFloatingNavBar(),
    );
  }

  Widget _buildFloatingNavBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        24,
        0,
        24,
        20,
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: AppColors.brandPrimary,
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.15,
                ),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              _buildNavItem(
                index: 0,
                label: 'Beranda',
                iconData: Icons.home_outlined,
                iconSize: 24,
              ),
              _buildNavItem(
                index: 1,
                label: 'Cari',
                iconData: Icons.search_rounded,
                iconSize: 24,
              ),
              _buildNavItem(
                index: 2,
                label: 'Layanan',
                iconData: Icons.dashboard_customize_outlined,
                iconSize: 24,
              ),
              _buildNavItem(
                index: 3,
                label: 'Profil',
                iconData: Icons.account_circle_outlined,
                iconSize: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required IconData iconData,
    required double iconSize,
  }) {
    final isSelected = _currentIndex == index;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _handleBottomNavigationTap(index);
          },
          borderRadius: BorderRadius.circular(32),
          splashColor: Colors.white.withValues(
            alpha: 0.08,
          ),
          highlightColor: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 180,
            ),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withValues(
                alpha: 0.13,
              )
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  size: iconSize,
                  color: Colors.white,
                ),
                const SizedBox(height: 3),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withValues(
                      alpha: 0.88,
                    ),
                    fontSize: 12,
                    height: 1.1,
                    letterSpacing: 0,
                    fontWeight: isSelected
                        ? FontWeight.w800
                        : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
