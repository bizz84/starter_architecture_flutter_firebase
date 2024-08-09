import 'package:flutter_starter_base_app/src/features/login/data/providers.dart';
import 'package:flutter_starter_base_app/src/routing/app_router.dart';
import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter_starter_base_app/src/common_widgets/circular_loading_animation.dart';
import 'package:go_router/go_router.dart';

class LogoutPageTransition extends ConsumerWidget {
  const LogoutPageTransition({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => ref.watch(logoutProvider).when(
      loading: () => const LoadingAnimation(),
      data: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(currentMainRouteIndexProvider.notifier).state = 0;
          if (context.mounted) context.goNamed(AppRoute.splash.name);
        });

        return Container();
      },
      error: (error, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: CustomColors().darkestGrayBG, content: Center(child: Text('$error')))));
        return Container();
      });
}
