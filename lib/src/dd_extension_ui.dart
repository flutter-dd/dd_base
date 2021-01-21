part of dd_base;

extension BuildContextDD on BuildContext {
  double get screenW => MediaQuery.of(this).size.width;
  double get screenH => MediaQuery.of(this).size.height;
  double get width => min(screenW, screenH);
  double get height => max(screenW, screenH);
  bool get isVertical => MediaQuery.of(this).orientation.index == 1;
}

extension StatelessWidgetDD on StatelessWidget {

  bool isVertical(BuildContext context) =>
      MediaQuery.of(context).orientation.index == 1;

  Object arguments(BuildContext context) =>
      ModalRoute.of(context).settings.arguments;

  Map<String, WidgetBuilder> get route =>
      {'${runtimeType.toString()}': (context) => this};

  Future<T> push<T extends Object>(BuildContext context,
      {Object arguments}) async {
    return Navigator.of(context)
        .pushNamed(this.runtimeType.toString(), arguments: arguments);
  }

  Future<T> pushReplace<T extends Object>(BuildContext context,
      {Object arguments}) async {
    return Navigator.of(context).pushReplacementNamed(
        this.runtimeType.toString(),
        arguments: arguments);
  }

  Future<void> popRoot(BuildContext context) async {
    return Navigator.of(context).popUntil((route) {
      print(route);
      return route.isFirst;
    });
  }

  Future<dynamic> pop(BuildContext context) async {
    if (Navigator.of(context).canPop()) {
      return Navigator.of(context).pop();
    }
  }


}

extension StatefulWidgetDD on StatefulWidget {

  Map<String, WidgetBuilder> get route =>
      {'${runtimeType.toString()}': (context) => this};

  Future<T> push<T extends Object>(BuildContext context,
      {Object arguments}) async {
    return Navigator.of(context)
        .pushNamed(this.runtimeType.toString(), arguments: arguments);
  }

  Future<T> pushReplace<T extends Object>(BuildContext context,
      {Object arguments}) async {
    return Navigator.of(context).pushReplacementNamed(
        this.runtimeType.toString(),
        arguments: arguments);
  }

}

extension StateDD on State {
  Object get arguments => ModalRoute.of(context).settings.arguments;
  bool get isVertical => MediaQuery.of(context).orientation.index == 1;

  Future<void> popRoot() async {
    return Navigator.of(context).popUntil((route) {
      print(route.settings.name);
      return route.isFirst;
    });
  }

  Future<void> pop() async {
    if (Navigator.of(context).canPop()) {
      return Navigator.of(context).pop();
    }
  }


}
