import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/inputs/custom_text_field.dart';
import '../../../../shared/widgets/breadcrumb_widget.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/app_footer.dart';
import '../../../main_navigation_page.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/divider_with_label.dart';
import '../widgets/form_field_label.dart';
import '../widgets/garuda_emblem.dart';
import '../widgets/store_button.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? onLoginSuccess;
  final VoidCallback? onNavigateHome;
  final VoidCallback? onMenuTap;

  const LoginPage({
    super.key,
    this.onLoginSuccess,
    this.onNavigateHome,
    this.onMenuTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin(BuildContext context) {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username/NIK dan PIN wajib diisi.'),
        ),
      );
      return;
    }

    context.read<ProfileBloc>().add(
      LoginSubmitted(
        username: username,
        password: password,
      ),
    );
  }

  void _goToHomeAfterLogin() {
    if (widget.onLoginSuccess != null) {
      widget.onLoginSuccess!();
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const MainNavigationPage(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>(),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.loginSuccess) {
            _goToHomeAfterLogin();
          }

          if (state.status == ProfileStatus.otpRequired) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message.isEmpty
                      ? 'Akun membutuhkan verifikasi OTP.'
                      : state.message,
                ),
              ),
            );
          }

          if (state.status == ProfileStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message.isEmpty
                      ? 'Login gagal. Silakan coba lagi.'
                      : state.message,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.isLoading;

          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                AppHeader(
                  onMenuTap: widget.onMenuTap,
                  showLoginButton: false,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            BreadcrumbWidget(
                              items: [
                                BreadcrumbItem(
                                  label: 'Beranda',
                                  onTap: () {
                                    if (widget.onNavigateHome != null) {
                                      widget.onNavigateHome!();
                                    } else {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                                const BreadcrumbItem(label: 'Masuk Akun'),
                              ],
                            ),

                            const SizedBox(height: 8),
                            const Center(child: GarudaEmblem()),

                            const SizedBox(height: 16),

                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Masuk ke akun Anda',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.brandPrimary,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                'Gunakan akun Identitas Kependudukan Digital Anda '
                                    'untuk akses cepat dan aman.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.contentSecondary,
                                  fontSize: 13.5,
                                  height: 1.5,
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),

                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const FormFieldLabel(
                                    label: 'NIK / Username',
                                    isRequired: true,
                                  ),
                                  const SizedBox(height: 6),
                                  CustomTextField(
                                    controller: _usernameController,
                                    hintText:
                                    'Masukkan NIK atau username akun',
                                    keyboardType: TextInputType.text,
                                    maxLength: 100,
                                  ),

                                  const SizedBox(height: 16),

                                  const FormFieldLabel(
                                    label: 'PIN / Password',
                                    isRequired: true,
                                  ),
                                  const SizedBox(height: 6),
                                  CustomTextField(
                                    controller: _passwordController,
                                    hintText: 'Masukkan PIN atau password',
                                    keyboardType: TextInputType.visiblePassword,
                                    maxLength: 100,
                                    obscureText: _obscurePassword,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: AppColors.contentSecondary,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword =
                                          !_obscurePassword;
                                        });
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: isLoading
                                          ? null
                                          : () => _submitLogin(context),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        AppColors.brandPrimary,
                                        foregroundColor: Colors.white,
                                        disabledBackgroundColor:
                                        AppColors.brandPrimary
                                            .withOpacity(0.55),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: isLoading
                                          ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child:
                                        CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                          : const Text(
                                        'Masuk ke akun IKD',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  Center(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: const TextStyle(
                                          color:
                                          AppColors.contentSecondary,
                                          fontSize: 13,
                                          height: 1.5,
                                        ),
                                        children: [
                                          const TextSpan(
                                            text:
                                            'Dengan masuk ke akun IKD, Anda '
                                                'telah menyetujui ',
                                          ),
                                          TextSpan(
                                            text: 'Syarat dan Ketentuan',
                                            style: const TextStyle(
                                              color:
                                              AppColors.brandPrimary,
                                              fontWeight: FontWeight.w700,
                                              decoration:
                                              TextDecoration.underline,
                                            ),
                                            recognizer:
                                            TapGestureRecognizer()
                                              ..onTap = () {},
                                          ),
                                          const TextSpan(text: ' kami.'),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 28),

                                  const DividerWithLabel(
                                    label:
                                    'Dapatkan aplikasi IKD melalui',
                                  ),

                                  const SizedBox(height: 16),

                                  StoreButton(
                                    type: StoreType.googlePlay,
                                    onTap: () {},
                                  ),
                                  const SizedBox(height: 10),
                                  StoreButton(
                                    type: StoreType.appleStore,
                                    onTap: () {},
                                  ),
                                  const SizedBox(height: 32),
                                ],
                              ),
                            ),

                            const AppFooter(),
                          ],
                        ),
                      ),
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
}