import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter/widgets.dart';

class BarBackgroud extends StatelessWidget {
  const BarBackgroud({super.key});

  @override
  Widget build(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
          5,
          (_) => Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(color: CustomColors().lightGrayText),
                          bottom: BorderSide(color: CustomColors().lightGrayText),
                          right: BorderSide(color: CustomColors().lightGrayText)))))));
}
