import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../shared/widgets/app_footer.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../domain/repositories/service_access_repository.dart';
import '../bloc/service_access_bloc.dart';
import '../widgets/service_access_detail_content.dart';

class ServiceAccessDetailPage extends StatelessWidget {
  final String serviceTitle;
  final Map<String, dynamic> item;
  final bool isLoggedIn;
  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;

  const ServiceAccessDetailPage({
    super.key,
    required this.serviceTitle,
    required this.item,
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ServiceAccessDetailContent(
                      serviceTitle: serviceTitle,
                      item: item,
                    ),
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
