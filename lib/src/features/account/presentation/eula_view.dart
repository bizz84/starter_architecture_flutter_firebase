import 'package:flutter_starter_base_app/src/common_widgets/action_text_button.dart';
import 'package:flutter_starter_base_app/src/common_widgets/primary_button.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter_starter_base_app/src/constants/theme_data.dart';
import 'package:flutter_starter_base_app/src/features/account/data/account_provider.dart';
import 'package:flutter_starter_base_app/src/features/account/domain/eula.dart';
import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EulaView extends ConsumerWidget {
  final bool isCancellable;
  final Function(bool acceptEULA) onEULAAccepted;

  const EulaView({super.key, required this.onEULAAccepted, this.isCancellable = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) => SafeArea(
      child: Scaffold(
          body: GestureDetector(
              child: Container(
                  color: primaryColor,
                  child: Container(
                      margin: const EdgeInsets.all(2.0),
                      padding: const EdgeInsets.all(10.0),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(6),
                                margin: const EdgeInsets.only(bottom: 10),
                                width: MediaQuery.of(context).size.width,
                                color: CustomColors().whitecolor,
                                child: SingleChildScrollView(
                                    child: ref
                                        .watch(fetchEULAProvider(
                                            languageCode: PlatformDispatcher.instance.locale.toString()))
                                        .when(
                                            data: (EULA eula) {
                                              WidgetsBinding.instance.addPostFrameCallback(
                                                  (_) => ref.read(eulaProvider.notifier).state = eula);
                                              return RichText(
                                                  text: TextSpan(
                                                      text: 'EULA INFORMATION\n\n',
                                                      style: DanlawTheme()
                                                          .defaultTextStyle(18)
                                                          .copyWith(fontWeight: FontWeight.w600, color: primaryColor),
                                                      children: [
                                                    TextSpan(
                                                        text: eula.text,
                                                        style: const TextStyle(fontSize: 16, color: primaryColor))
                                                  ]));
                                            },
                                            error: (error, stackTrace) => Text(
                                                'EULA INFORMATION\n\nCannot fetch EULA at this time. Please try again later.',
                                                style: DanlawTheme().defaultTextStyle(18)),
                                            loading: () => Container())))),
                        SizedBox(

                            ///XXX:
                            height: MediaQuery.of(context).size.height * 0.13,
                            width: MediaQuery.of(context).size.width,
                            child: Column(mainAxisSize: MainAxisSize.min, children: [
                              PrimaryButton(
                                  text: "I have read and accept the EULA",
                                  onPressed: () async {
                                    onEULAAccepted(true);
                                    if (!isCancellable) context.goNamed(AppRoute.eulaTransition.name);
                                  },
                                  backgroundColor: CustomColors().lightblueColor),
                              if (isCancellable) ActionTextButton(text: "Cancel", onPressed: () => context.pop(false))
                            ]))
                      ]))))));
}
