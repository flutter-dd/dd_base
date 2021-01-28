part of dd_base;

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

abstract class BaseStatelessPage extends StatelessWidget {
  const BaseStatelessPage({Key key}) : super(key: key);

  String get title => "${this.runtimeType.toString()}";
  Widget get leading => Icon(CupertinoIcons.back);
  Widget get middle => Text(title);
  Widget get trailing => Container();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: isVertical(context) ? null : appBar(context),
      child: SafeArea(child: content(context)),
    );
  }

  CupertinoNavigationBar appBar(BuildContext context) => CupertinoNavigationBar(
      border: Border.all(color: Color(0x00FFFFFF), width: 0),
      leading: canPop(context)
          ? GestureDetector(
        child: leading,
        onTap: Navigator.of(context).maybePop,
      )
          : Container(),
      trailing: trailing,
      middle: middle);

  Widget content(BuildContext context) => Container();
}

abstract class BaseStatefulPage extends StatefulWidget {
  const BaseStatefulPage({Key key}) : super(key: key);
}

abstract class BaseState<T extends BaseStatefulPage> extends State<T>
    with RouteAware {
  bool _isInitial = false;
  String get title => "${widget.runtimeType.toString()}";
  bool get lockUpAndDown => false;
  Widget get leading => Icon(CupertinoIcons.back);
  Widget get middle => Text(title);
  Widget get trailing => Container();

  @override
  void initState() {
    super.initState();
    if (lockUpAndDown) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitial) return;
    _isInitial = true;
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
      border: Border.all(color: Color(0x00FFFFFF), width: 0),
      leading: canPop
          ? GestureDetector(
        child: leading,
        onTap: Navigator.of(context).maybePop,
      )
          : Container(),
      trailing: trailing,
      middle: middle);

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }
}
