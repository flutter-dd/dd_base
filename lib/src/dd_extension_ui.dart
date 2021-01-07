part of dd_base;

extension Context on BuildContext {
  double get screenW => MediaQuery.of(this).size.width;
  double get screenH => MediaQuery.of(this).size.height;
  double get width => max(screenW, screenH);
  double get height => min(screenW, screenH);
  bool get isVertical => MediaQuery.of(this).orientation.index == 1;
}
