part of dd_base;

extension Context on BuildContext {
  double get screenW => MediaQuery.of(this).size.width;
  double get screenH => MediaQuery.of(this).size.height;
  double get width => min(screenW, screenH);
  double get height => max(screenW, screenH);
  bool get isVertical => MediaQuery.of(this).orientation.index == 1;
}
