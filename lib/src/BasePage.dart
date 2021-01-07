part of dd_base;

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

abstract class BaseStatelessPage extends StatelessWidget {
  const BaseStatelessPage({Key key}) : super(key: key);

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

  Object arguments(BuildContext context) =>
      ModalRoute.of(context).settings.arguments;

  bool isVertical(BuildContext context) =>
      MediaQuery.of(context).orientation.index == 1;

  String get title => "${this.runtimeType.toString()}";

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: isVertical(context) ? null : appBar(context),
      child: SafeArea(child: content(context)),
    );
  }

  CupertinoNavigationBar appBar(BuildContext context) =>
      CupertinoNavigationBar(middle: Text(title));
  Widget content(BuildContext context) => Container();
}

abstract class BaseStatefulPage extends StatefulWidget {
  const BaseStatefulPage({Key key}) : super(key: key);

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

abstract class BaseState<T extends BaseStatefulPage> extends State<T>
    with RouteAware {
  Object get arguments => ModalRoute.of(context).settings.arguments;
  bool get isVertical => MediaQuery.of(context).orientation.index == 1;
  bool _isInitaled = false;
  String get title => "${widget.runtimeType.toString()}";

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitaled) return;
    _isInitaled = true;
    FocusScope.of(context).requestFocus(FocusNode());
    onContextReady();
    routeObserver.subscribe(this, ModalRoute.of(context));
    loadDate();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: !isVertical,
        navigationBar: isVertical ? null : appBar(),
        child: SafeArea(
            child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: content())));
  }

  CupertinoNavigationBar appBar() =>
      CupertinoNavigationBar(middle: Text(title));
  Widget content() => Container();
  void onContextReady() {}
  Future<void> loadDate() async {}

  @override
  void didPop() {
    super.didPop();
    viewDisappear();
  }

  @override
  void didPush() {
    super.didPush();
    viewAppear();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    viewAppear();
  }

  @override
  void didPushNext() {
    super.didPushNext();
    viewDisappear();
  }

  void viewDisappear() {}

  void viewAppear() {}

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
