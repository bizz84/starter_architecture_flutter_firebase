import 'package:flutter_starter_base_app/src/common_widgets/circular_loading_animation.dart';
import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class CheckEULA extends ConsumerWidget {
  const CheckEULA({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => ref.watch(fetchEULAStatusProvider).when(
      data: (bool acceptedEULA) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            acceptedEULA ? context.goNamed(AppRoute.home.name) : context.pushNamed(AppRoute.acceptEULA.name);
          }
        });
        return Container();
      },
      error: (error, stackTrace) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) context.goNamed(AppRoute.splash.name);
        });
        return Container();
      },
      loading: () => const LoadingAnimation());
}
