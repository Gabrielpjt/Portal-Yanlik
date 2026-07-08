import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';
import '../core/di/injection_container.dart';
import '../core/bloc/app_loading/app_loading_bloc.dart';
import '../core/bloc/notification/notification_bloc.dart';
import '../core/bloc/user_session/user_session_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AppLoadingBloc>()),
        BlocProvider(create: (_) => getIt<NotificationBloc>()),
        BlocProvider(create: (_) => getIt<UserSessionBloc>()),
      ],
      child: MaterialApp(
        title: 'Portal Layanan Publik',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRouter.main,
      ),
    );
  }
}
