import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_footer.dart';
import '../../../../shared/widgets/app_header.dart';
import '../widgets/bpjs_membership_access_content.dart';
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

  bool get _isBpjsMembership {
    return serviceTitle == 'Informasi Kepesertaan BPJS';
  }

  void _openDetail(
      BuildContext context,
      Map<String, dynamic> item,
      ) {
    Navigator.of(context).push(
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
  }

  Widget _buildContent(BuildContext context) {
    if (_isBpjsMembership) {
      return const BpjsMembershipAccessContent();
    }

    return ServiceAccessSearchContent(
      serviceTitle: serviceTitle,
      onItemTap: (item) {
        _openDetail(
          context,
          item,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  _buildContent(context),
                  const SizedBox(height: 40),
                  const AppFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
