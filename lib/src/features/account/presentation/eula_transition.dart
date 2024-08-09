import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/constants/theme_data.dart';
import 'package:flutter_starter_base_app/src/features/account/data/account_provider.dart';
import 'package:flutter_starter_base_app/src/common_widgets/circular_loading_animation.dart';

class EULATransition extends ConsumerWidget {
  const EULATransition({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(submitEULAProvider(agreementId: ref.read(eulaProvider)?.agreementId ?? '')).when(
        data: (bool isSuccesful) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.goNamed(isSuccesful ? AppRoute.home.name : AppRoute.splash.name);
          });
          return Container();
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error', style: DefaultTheme().defaultTextStyle(20))),
        loading: () => const LoadingAnimation());
  }
}
