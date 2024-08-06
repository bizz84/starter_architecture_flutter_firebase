import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../domain/item.dart';

class SelectBuilder extends StatefulWidget {
  const SelectBuilder({
    super.key,
    required this.onSelect,
    required this.items,
    this.initialSelection,
    this.multiSelect = false,
  });

  final void Function(List<Item>) onSelect;
  final List<Item> items;
  final List<Item>? initialSelection;
  final bool multiSelect;

  @override
  State<SelectBuilder> createState() => _SelectBuilderState();
}

class _SelectBuilderState extends State<SelectBuilder> {
  Set<Item> _selectedItems = {};

  @override
  void initState() {
    super.initState();
    if (widget.initialSelection != null) {
      _selectedItems = Set.from(widget.initialSelection!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(color: Colors.grey.shade900, height: 2),
      itemCount: widget.items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final isSelected = _selectedItems.any((element) => element.value == item.value);

        return ListTile(
          contentPadding: EdgeInsets.zero,
          minVerticalPadding: 11,
          minTileHeight: 11,
          title: Text(item.label, style: DanlawTheme().defaultTextStyle(17)),
          trailing: isSelected ? Icon(CupertinoIcons.check_mark, color: CustomColors().primaryTextColor) : null,
          onTap: () => _onItemTap(item),
        );
      },
    );
  }

  void _onItemTap(Item item) {
    setState(() {
      if (widget.multiSelect) {
        if (_selectedItems.any((element) => element.value == item.value)) {
          _selectedItems.removeWhere((element) => element.value == item.value);
        } else {
          _selectedItems.add(item);
        }
      } else {
        _selectedItems = {item};
      }
    });
    widget.onSelect(_selectedItems.toList());
  }
}
