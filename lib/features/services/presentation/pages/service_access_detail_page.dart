import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_footer.dart';
import '../../../../shared/widgets/app_header.dart';
import '../widgets/service_access_detail_content.dart';
import '../widgets/service_review_related_section.dart';

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
                  ServiceAccessDetailContent(
                    serviceTitle: serviceTitle,
                    item: item,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Divider(
                          height: 40,
                          thickness: 0.4,
                        ),
                        ServiceReviewRelatedSection(
                          showRelatedService: false,
                        ),
                        const SizedBox(height: 32),
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
}
