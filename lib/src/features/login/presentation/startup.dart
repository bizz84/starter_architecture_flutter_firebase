import 'package:flutter_starter_base_app/src/common_widgets/circular_loading_animation.dart';
import 'package:flutter_starter_base_app/src/features/login/data/providers.dart';
import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class Startup extends ConsumerWidget {
  const Startup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => ref.watch(canAuthenticateUserProvider).when(
      data: (bool isAuthenticated) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (context.mounted) context.pushNamed(isAuthenticated ? AppRoute.checkEULA.name : AppRoute.splash.name);
        });
        return const SizedBox();
      },
      error: (error, stackTrace) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) context.goNamed(AppRoute.splash.name);
        });
        return const SizedBox();
      },
      loading: () => const LoadingAnimation());
}
