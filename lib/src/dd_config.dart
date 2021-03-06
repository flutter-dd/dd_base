part of dd_base;

class Config {
  bool isProduct = bool.fromEnvironment("dart.vm.product");
  final String base;
  final String dev;
  final String ios;
  final String iosDev;
  final String android;
  final String androidDev;
  final String linux;
  final String linuxDev;
  final String mac;
  final String macDev;
  final String win;
  final String winDev;
  final String fuchsia;
  final String fuchsiaDev;

  Config(
      {this.base = "",
        this.dev,
        this.ios,
        this.iosDev,
        this.android,
        this.androidDev,
        this.linux,
        this.linuxDev,
        this.mac,
        this.macDev,
        this.win,
        this.winDev,
        this.fuchsia,
        this.fuchsiaDev});

  String get value {
    if (Platform.isIOS) {
      return isProduct ? ios ?? base : iosDev ?? dev ?? ios ?? base;
    } else if (Platform.isAndroid) {
      return isProduct ? android ?? base : androidDev ?? dev ?? android ?? base;
    } else if (Platform.isLinux) {
      return isProduct ? linux ?? base : linuxDev ?? dev ?? linux ?? base;
    } else if (Platform.isMacOS) {
      return isProduct ? mac ?? base : macDev ?? dev ?? mac ?? base;
    } else if (Platform.isWindows) {
      return isProduct ? win ?? base : winDev ?? dev ?? win ?? base;
    } else if (Platform.isFuchsia) {
      return isProduct ? fuchsia ?? base : fuchsiaDev ?? dev ?? fuchsia ?? base;
    } else {
      return isProduct ? base : dev ?? base;
    }
  }
}
