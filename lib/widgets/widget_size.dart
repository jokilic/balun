import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef void OnWidgetSizeChange(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  final OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    final newSize = child!.size;

    if (oldSize == newSize) {
      return;
    }

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) => onChange(newSize));
  }
}

class WidgetSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const WidgetSize({
    required this.onChange,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) => MeasureSizeRenderObject(onChange);
}
