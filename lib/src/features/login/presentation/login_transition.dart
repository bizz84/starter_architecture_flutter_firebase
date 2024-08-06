import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter_starter_base_app/src/common_widgets/circular_loading_animation.dart';
import 'package:go_router/go_router.dart';

class LoginPageTransition extends ConsumerWidget {
  final String username, password;
  const LoginPageTransition({super.key, required this.password, required this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(loginProvider(username: username, password: password)).when(
          loading: () => const LoadingAnimation(),
          data: (_) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (context.mounted) context.goNamed(AppRoute.home.name);
            });
            return const LoadingAnimation();
          },
          error: (error, _) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.canPop()) context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(backgroundColor: CustomColors().darkestGrayBG, content: Center(child: Text('$error'))));
            });
            return Container();
          });
}
