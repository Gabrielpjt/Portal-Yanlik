import 'package:flutter/foundation.dart';

class MainNavigationController {
  MainNavigationController._();

  static final MainNavigationController instance =
  MainNavigationController._();

  VoidCallback? _onHome;
  VoidCallback? _onServices;
  VoidCallback? _onLogin;
  VoidCallback? _onProfile;
  VoidCallback? _onProfileStatus;
  VoidCallback? _onOpenMenu;

  bool get isAttached {
    return _onHome != null;
  }

  void attach({
    required VoidCallback onHome,
    required VoidCallback onServices,
    required VoidCallback onLogin,
    required VoidCallback onProfile,
    required VoidCallback onProfileStatus,
    required VoidCallback onOpenMenu,
  }) {
    _onHome = onHome;
    _onServices = onServices;
    _onLogin = onLogin;
    _onProfile = onProfile;
    _onProfileStatus = onProfileStatus;
    _onOpenMenu = onOpenMenu;
  }

  void detach() {
    _onHome = null;
    _onServices = null;
    _onLogin = null;
    _onProfile = null;
    _onProfileStatus = null;
    _onOpenMenu = null;
  }

  void goHome() {
    _onHome?.call();
  }

  void goServices() {
    _onServices?.call();
  }

  void goLogin() {
    _onLogin?.call();
  }

  void goProfile() {
    _onProfile?.call();
  }

  void goProfileStatus() {
    _onProfileStatus?.call();
  }

  void openMenu() {
    _onOpenMenu?.call();
  }
}
