import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/features/report/domain/report_by.dart';
import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/features/report/data/report_providers.dart';

class EllipticButton extends ConsumerWidget {
  final ReportBy setReportByTo;
  final String text;
  final bool mirror;
  const EllipticButton({super.key, required this.setReportByTo, required this.text, this.mirror = false});
  @override
  Widget build(BuildContext context, WidgetRef ref) => Transform.flip(
      flipX: mirror,
      child: InkWell(
          onTap: () {
            ref.read(reportBy.notifier).state = setReportByTo;
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => ref.read(triggerPage.notifier).state = ref.read(currentlySelectedVehicleList));
          },
          child: Container(
              height: 30,
              width: 60,
              decoration: BoxDecoration(
                  color: ref.watch(reportBy) == setReportByTo ? CustomColors().reportByButtonBG : Colors.transparent,
                  border: Border.all(color: CustomColors().lightGrayText),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.elliptical(100, 70), bottomLeft: Radius.elliptical(100, 70))),
              child: Transform.flip(
                  flipX: mirror,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ref.watch(reportBy) == setReportByTo
                            ? Row(children: [
                                Icon(Icons.check, color: CustomColors().whitecolor, size: 15),
                                const SizedBox(width: 5)
                              ])
                            : Container(),
                        Text(text,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: CustomColors().whitecolor, fontSize: 11))
                      ])))));
}
