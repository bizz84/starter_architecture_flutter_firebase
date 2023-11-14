import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/common_widgets/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder({
    super.key,
    required this.data,
    required this.itemBuilder,
  });
  final AsyncValue<List<T>> data;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    return data.when(
      data: (items) => items.isNotEmpty
          ? ListView.separated(
              itemCount: items.length + 2,
              separatorBuilder: (context, index) => const Divider(height: 0.5),
              itemBuilder: (context, index) {
                if (index == 0 || index == items.length + 1) {
                  return const SizedBox.shrink();
                }
                return itemBuilder(context, items[index - 1]);
              },
            )
          : const EmptyContent(),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      ),
    );
  }
}
