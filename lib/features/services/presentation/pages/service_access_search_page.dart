import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../shared/widgets/app_footer.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../domain/repositories/service_access_repository.dart';
import '../bloc/service_access_bloc.dart';
import '../widgets/service_access_search_content.dart';
import 'service_access_detail_page.dart';

class ServiceAccessSearchPage extends StatelessWidget {
  final String serviceTitle;
  final bool isLoggedIn;
  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;

  const ServiceAccessSearchPage({
    super.key,
    required this.serviceTitle,
    this.isLoggedIn = false,
    this.onMenuTap,
    this.onLoginTap,
  });

  ServiceAccessBloc _createServiceAccessBloc() {
    return ServiceAccessBloc(
      repository: getIt<ServiceAccessRepository>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceAccessBloc>(
      create: (_) => _createServiceAccessBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            AppHeader(
              isLoggedIn: isLoggedIn,
              onMenuTap: onMenuTap,
              onLoginTap: onLoginTap,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ServiceAccessSearchContent(
                      serviceTitle: serviceTitle,
                      onItemTap: (item) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ServiceAccessDetailPage(
                              serviceTitle: serviceTitle,
                              item: item,
                              isLoggedIn: isLoggedIn,
                              onMenuTap: onMenuTap,
                              onLoginTap: onLoginTap,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    const AppFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
