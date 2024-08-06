import 'package:flutter_starter_base_app/src/domain/label_value.dart';
import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter_starter_base_app/src/constants/svg_loader.dart';
import 'package:flutter_starter_base_app/src/constants/theme_data.dart';
import 'package:flutter_starter_base_app/src/features/report/domain/report_frame.dart';
import 'package:flutter_starter_base_app/src/features/report/data/report_providers.dart';

class TimeWindowSingleSelect extends ConsumerWidget {
  final String text;
  final String value;
  final String description;
  const TimeWindowSingleSelect({super.key, required this.text, required this.value, required this.description});
  @override
  Widget build(BuildContext context, WidgetRef ref) => Container(
      padding: const EdgeInsets.only(top: 7, bottom: 7, left: 17, right: 17),
      child: Row(children: [
        Text(text, style: DanlawTheme().defaultTextStyle(18)),
        Tooltip(
            message: description,
            child: Container(padding: const EdgeInsets.only(left: 10), child: SVGLoader().questionMark)),
        const Spacer(),
        Text( ref.watch(currentTimeWindow).localizationKey.tr(),
            style: DanlawTheme().defaultTextStyle(17).copyWith(color: CustomColors().darkGrayText)),
        InkWell(
            child: InkWell(
                child: Container(padding: const EdgeInsets.only(left: 10), child: SVGLoader().rightArrow),
                onTap: () async {
                  LabelValuePair? labelValuePairOrNull = await context.pushNamed(AppRoute.reportTimeWindowSelect.name,
                      extra: <dynamic>[text, CustomColors().darkGray, TimeWindow.values, ref.read(currentTimeWindow)]);
                  if (labelValuePairOrNull != null) {
                    ref.watch(currentTimeWindow.notifier).state = TimeWindow.fromLabelValuePair(labelValuePairOrNull);
                    WidgetsBinding.instance.addPostFrameCallback(
                        (_) => ref.read(triggerPage.notifier).state = ref.read(currentTimeWindow));
                  }
                }))
      ]));
}
