import 'package:flutter/material.dart';

import '../../../../app/router/app_router.dart';
import '../../../../core/widgets/navigation/sidebar/app_drawer.dart';
import '../../../../shared/widgets/app_footer.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/breadcrumb_widget.dart';
import '../../../../shared/widgets/helpful_review_section.dart';
import '../widgets/informasi_detail_article_body.dart';
import '../widgets/informasi_detail_header.dart';
import '../widgets/informasi_detail_sections.dart';

class InformasiLayananDetailPage extends StatefulWidget {
  final Map<String, dynamic> article;
  final List<Map<String, dynamic>> relatedArticles;
  final VoidCallback? onLoginTap;
  final VoidCallback? onBerandaTap;
  final VoidCallback? onInformasiLayananTap;
  final VoidCallback? onAkunSayaTap;
  final VoidCallback? onKeluarAkunTap;
  final bool isLoggedIn;

  const InformasiLayananDetailPage({
    super.key,
    required this.article,
    this.relatedArticles = const [],
    this.onLoginTap,
    this.onBerandaTap,
    this.onInformasiLayananTap,
    this.onAkunSayaTap,
    this.onKeluarAkunTap,
    this.isLoggedIn = false,
  });

  @override
  State<InformasiLayananDetailPage> createState() {
    return _InformasiLayananDetailPageState();
  }
}

class _InformasiLayananDetailPageState
    extends State<InformasiLayananDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _reviewPage = 1;

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _popPageAndCall(VoidCallback? callback) {
    final nav = Navigator.of(context);

    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      nav.pop();
    }

    if (nav.canPop()) {
      nav.pop();
    }

    if (callback != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        callback();
      });
    }
  }

  void _goToInformasiLayanan() {
    final nav = Navigator.of(context);

    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      nav.pop();
    }

    if (widget.onInformasiLayananTap != null) {
      if (nav.canPop()) {
        nav.pop();
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onInformasiLayananTap?.call();
      });

      return;
    }

    if (nav.canPop()) {
      nav.pop();
    }
  }

  void _openRelatedArticle(Map<String, dynamic> article) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          return InformasiLayananDetailPage(
            article: article,
            relatedArticles: widget.relatedArticles
                .where((item) => item['title'] != article['title'])
                .toList(),
            isLoggedIn: widget.isLoggedIn,
            onLoginTap: widget.onLoginTap,
            onBerandaTap: widget.onBerandaTap,
            onInformasiLayananTap: widget.onInformasiLayananTap,
            onAkunSayaTap: widget.onAkunSayaTap,
            onKeluarAkunTap: widget.onKeluarAkunTap,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: AppDrawer(
        isLoggedIn: widget.isLoggedIn,
        onBerandaTap: () {
          _popPageAndCall(widget.onBerandaTap);
        },
        onInformasiLayananTap: _goToInformasiLayanan,
        onAkunSayaTap: () {
          _popPageAndCall(widget.onAkunSayaTap);
        },
        onKeluarAkunTap: () {
          _popPageAndCall(widget.onKeluarAkunTap);
        },
        onApiTestTap: () {
          Navigator.of(context).pushNamed(AppRouter.apiTest);
        },
      ),
      body: Column(
        children: [
          AppHeader(
            isLoggedIn: widget.isLoggedIn,
            onMenuTap: _openDrawer,
            onLoginTap: widget.onLoginTap,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BreadcrumbWidget(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                    items: [
                      BreadcrumbItem(
                        label: 'Beranda',
                        onTap: () {
                          _popPageAndCall(widget.onBerandaTap);
                        },
                      ),
                      BreadcrumbItem(
                        label: 'Informasi Layanan',
                        onTap: _goToInformasiLayanan,
                      ),
                      const BreadcrumbItem(label: 'Detail Informasi'),
                    ],
                  ),

                  InformasiDetailHeader(
                    article: widget.article,
                  ),

                  const SizedBox(height: 22),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InformasiDetailArticleBody(
                      article: widget.article,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      thickness: 0.4,
                      height: 1,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: HelpfulReviewSection(
                      title: 'Tulis Ulasan',
                      description: 'Jadilah yang pertama memberikan ulasan.',
                      hintText: 'Tulis ulasan disini',
                      buttonLabel: 'Kirim ulasan',
                      initialRating: 3.5,
                      onSubmit: (rating, review) {},
                    ),
                  ),

                  const SizedBox(height: 36),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InformasiReviewsSection(
                      currentPage: _reviewPage,
                      onPageChanged: (page) {
                        setState(() {
                          _reviewPage = page;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 40),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InformasiRelatedSection(
                      articles: widget.relatedArticles,
                      onArticleTap: _openRelatedArticle,
                    ),
                  ),

                  const SizedBox(height: 16),

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