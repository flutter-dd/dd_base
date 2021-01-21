part of dd_base;

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

abstract class BaseStatelessPage extends StatelessWidget {
  const BaseStatelessPage({Key key}) : super(key: key);

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
}

abstract class BaseState<T extends BaseStatefulPage> extends State<T>
    with RouteAware {
  bool _isInitaled = false;
  String get title => "${widget.runtimeType.toString()}";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitaled) return;
    _isInitaled = true;
    routeObserver.subscribe(this, ModalRoute.of(context));
    onContextReady();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: CupertinoPageScaffold(
          resizeToAvoidBottomInset: !isVertical,
          navigationBar: isVertical ? null : appBar(),
          child: SafeArea(child: content())),
    );
  }

  CupertinoNavigationBar appBar() => CupertinoNavigationBar(
      previousPageTitle: "返回",
      border: Border.all(color: Color(0x00FFFFFF), width: 0),
      middle: Text(title));

  Widget content() => Container();

  void onContextReady() {}

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

  void viewDisappear() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void viewAppear() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
