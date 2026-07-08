import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/navigation/custom_app_bar.dart';
import '../../../../core/widgets/layout/custom_card.dart';
import '../../../../core/widgets/buttons/custom_button.dart';
import '../../../../core/di/injection_container.dart';
import '../bloc/post_detail/post_detail_bloc.dart';
import '../bloc/post_detail/post_detail_event.dart';
import '../bloc/post_detail/post_detail_state.dart';
import '../bloc/user_list/user_list_bloc.dart';
import '../bloc/user_list/user_list_event.dart';
import '../bloc/user_list/user_list_state.dart';
import '../bloc/post_list/post_list_bloc.dart';
import '../bloc/post_list/post_list_event.dart';
import '../bloc/post_list/post_list_state.dart';

/// API Test Page — Developer tool for testing API connectivity.
///
/// Demonstrates three patterns:
/// 1. Single JSON fetch (post by ID)
/// 2. Simple list fetch without pagination (users)
/// 3. Paginated list fetch (posts with load more)
///
/// Access via: Hamburger menu → Developer → API Test
class ApiTestPage extends StatelessWidget {
  const ApiTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<PostDetailBloc>()),
        BlocProvider(create: (_) => getIt<UserListBloc>()),
        BlocProvider(create: (_) => getIt<PostListBloc>()),
      ],
      child: Scaffold(
        appBar: const CustomAppBar(title: 'API Test'),
        body: const _ApiTestBody(),
      ),
    );
  }
}

class _ApiTestBody extends StatelessWidget {
  const _ApiTestBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Text(
            'API Connectivity Test',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.contentPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Using JSONPlaceholder (jsonplaceholder.typicode.com)',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.contentSecondary,
            ),
          ),
          const SizedBox(height: 24),

          // ── Section 1: Single Post Fetch ──
          _buildSectionHeader(
            '1. Single JSON Fetch',
            'GET /posts/1 — Fetch a single post by ID',
          ),
          const SizedBox(height: 12),
          const _SinglePostSection(),
          const SizedBox(height: 32),

          // ── Section 2: Users List (No Pagination) ──
          _buildSectionHeader(
            '2. List Fetch (No Pagination)',
            'GET /users — Fetch all users at once',
          ),
          const SizedBox(height: 12),
          const _UserListSection(),
          const SizedBox(height: 32),

          // ── Section 3: Paginated Posts ──
          _buildSectionHeader(
            '3. Paginated List Fetch',
            'GET /posts?_page=N&_limit=10 — Load posts page by page',
          ),
          const SizedBox(height: 12),
          const _PaginatedPostsSection(),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.brandPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.contentSecondary,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

// ───────────────────────────────────────────────
// Section 1: Single Post Fetch
// ───────────────────────────────────────────────
class _SinglePostSection extends StatelessWidget {
  const _SinglePostSection();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomButton(
            text: 'Fetch Post #1',
            icon: const Icon(Icons.download, color: Colors.white, size: 18),
            onPressed: () {
              context.read<PostDetailBloc>().add(const FetchPostById(1));
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<PostDetailBloc, PostDetailState>(
            builder: (context, state) {
              switch (state.status) {
                case PostDetailStatus.initial:
                  return const _StatusMessage(
                    icon: Icons.touch_app,
                    text: 'Tap the button above to fetch a post',
                  );
                case PostDetailStatus.loading:
                  return const _LoadingIndicator();
                case PostDetailStatus.error:
                  return _ErrorMessage(message: state.errorMessage);
                case PostDetailStatus.loaded:
                  final post = state.post!;
                  return _JsonDisplay(
                    data: {
                      'id': post.id,
                      'userId': post.userId,
                      'title': post.title,
                      'body': post.body,
                    },
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────
// Section 2: Users List (No Pagination)
// ───────────────────────────────────────────────
class _UserListSection extends StatelessWidget {
  const _UserListSection();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomButton(
            text: 'Fetch All Users',
            type: CustomButtonType.secondary,
            icon: const Icon(Icons.people, color: AppColors.brandPrimary, size: 18),
            onPressed: () {
              context.read<UserListBloc>().add(const FetchUsers());
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<UserListBloc, UserListState>(
            builder: (context, state) {
              switch (state.status) {
                case UserListStatus.initial:
                  return const _StatusMessage(
                    icon: Icons.touch_app,
                    text: 'Tap the button above to fetch users',
                  );
                case UserListStatus.loading:
                  return const _LoadingIndicator();
                case UserListStatus.error:
                  return _ErrorMessage(message: state.errorMessage);
                case UserListStatus.loaded:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${state.users.length} users loaded',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.positive600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...state.users.map(
                        (user) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundSecondary,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.strokePrimary,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColors.contentPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '@${user.username}  •  ${user.email}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.contentSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────
// Section 3: Paginated Posts
// ───────────────────────────────────────────────
class _PaginatedPostsSection extends StatelessWidget {
  const _PaginatedPostsSection();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Load Page 1',
                  type: CustomButtonType.outline,
                  icon: const Icon(Icons.refresh, color: AppColors.brandPrimary, size: 18),
                  onPressed: () {
                    context.read<PostListBloc>().add(const FetchPosts());
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: BlocBuilder<PostListBloc, PostListState>(
                  builder: (context, state) {
                    return CustomButton(
                      text: 'Load More',
                      icon: const Icon(Icons.add, color: Colors.white, size: 18),
                      onPressed: state.hasNextPage
                          ? () {
                              context
                                  .read<PostListBloc>()
                                  .add(const FetchNextPage());
                            }
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<PostListBloc, PostListState>(
            builder: (context, state) {
              switch (state.status) {
                case PostListStatus.initial:
                  return const _StatusMessage(
                    icon: Icons.touch_app,
                    text: 'Tap "Load Page 1" to start',
                  );
                case PostListStatus.loading:
                  return const _LoadingIndicator();
                case PostListStatus.error:
                  return _ErrorMessage(message: state.errorMessage);
                case PostListStatus.loaded:
                case PostListStatus.loadingMore:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Page info
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.guide100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Page ${state.currentPage}/${state.totalPages}  •  '
                          '${state.posts.length}/${state.totalItems} items loaded',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.guide600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Posts
                      ...state.posts.map(
                        (post) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundSecondary,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.strokePrimary,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '#${post.id}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.guide600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  post.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: AppColors.contentPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Loading more indicator
                      if (state.status == PostListStatus.loadingMore)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.brandPrimary,
                              ),
                            ),
                          ),
                        ),
                      // No more pages message
                      if (!state.hasNextPage &&
                          state.status == PostListStatus.loaded)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Center(
                            child: Text(
                              'All posts loaded ✓',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.positive600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────
// Shared UI Helpers
// ───────────────────────────────────────────────

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.brandPrimary,
          ),
        ),
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  final String message;
  const _ErrorMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade600, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 13,
                color: Colors.red.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusMessage extends StatelessWidget {
  final IconData icon;
  final String text;
  const _StatusMessage({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: AppColors.contentSecondary),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.contentSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _JsonDisplay extends StatelessWidget {
  final Map<String, dynamic> data;
  const _JsonDisplay({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.positive100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.positive600.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Response ✓',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.positive600,
            ),
          ),
          const SizedBox(height: 8),
          ...data.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                  children: [
                    TextSpan(
                      text: '"${entry.key}": ',
                      style: const TextStyle(color: AppColors.guide600),
                    ),
                    TextSpan(
                      text: '${entry.value}',
                      style: const TextStyle(
                        color: AppColors.contentPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
