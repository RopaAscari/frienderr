import 'package:flutter/material.dart';
import 'package:frienderr/core/services/services.dart';
import 'package:frienderr/features/presentation/navigation/app_router.dart';

class PopupMenuContainer<T> extends StatefulWidget {
  final Widget child;
  final List<PopupMenuEntry<T>> items;
  final void Function(T?) onItemSelected;

  const PopupMenuContainer(
      {required this.items,
      required this.child,
      required this.onItemSelected,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => PopupMenuContainerState<T>();
}

class PopupMenuContainerState<T> extends State<PopupMenuContainer<T>> {
  final Late<Offset> _tapDownPosition = Late();

  void _handlePress() async {
    final RenderBox? overlay =
        Overlay.of(context)?.context.findRenderObject() as RenderBox;

    if (overlay == null) {
      return;
    }

    T? value = await showMenu<T>(
      context: context,
      items: widget.items,
      color: Theme.of(context).canvasColor,
      constraints: const BoxConstraints(minWidth: 300),
      position: RelativeRect.fromLTRB(
        _tapDownPosition.value.dx,
        _tapDownPosition.value.dy,
        overlay.size.width - _tapDownPosition.value.dx,
        overlay.size.height - _tapDownPosition.value.dy,
      ),
    );

    widget.onItemSelected(value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (TapDownDetails details) {
          _tapDownPosition.value = details.globalPosition;
        },
        onTap: _handlePress,
        onLongPress: _handlePress,
        child: widget.child);
  }
}
