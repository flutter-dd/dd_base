part of dd_base;

class UserDefault {
  static init({@required String baseUrl}) {
    SpUtil.getInstance().then((spUtil) {
      UserDefault.baseUrl = baseUrl;
    });
  }

  static String get baseUrl => SpUtil.getString(UserDefaultKey.baseUrl);
  static set baseUrl(String v) => SpUtil.putString(UserDefaultKey.baseUrl, v);

  static bool get isGuideFinished =>
      SpUtil.getBool(UserDefaultKey.isGuideFinished);
  static set isGuideFinished(bool v) =>
      SpUtil.putBool(UserDefaultKey.isGuideFinished, v);

  static String get token => SpUtil.getString(UserDefaultKey.token);
  static set token(String v) => SpUtil.putString(UserDefaultKey.token, v);

  static int get sealRows =>
      SpUtil.getInt(UserDefaultKey.sealRows, defValue: 3);
  static set sealRows(int v) => SpUtil.putInt(UserDefaultKey.sealRows, v);

  static int get sealLines =>
      SpUtil.getInt(UserDefaultKey.sealLines, defValue: 3);
  static set sealLines(int v) => SpUtil.putInt(UserDefaultKey.sealLines, v);

  static int get sealAxisCount =>
      SpUtil.getInt(UserDefaultKey.sealAxisCount, defValue: 4);
  static set sealAxisCount(int v) =>
      SpUtil.putInt(UserDefaultKey.sealAxisCount, v);

  static double get sealLeft =>
      SpUtil.getDouble(UserDefaultKey.sealLeft, defValue: 10);
  static set sealLeft(double v) => SpUtil.putDouble(UserDefaultKey.sealLeft, v);

  static double get sealRight =>
      SpUtil.getDouble(UserDefaultKey.sealRight, defValue: 10);
  static set sealRight(double v) =>
      SpUtil.putDouble(UserDefaultKey.sealRight, v);

  static double get sealTop =>
      SpUtil.getDouble(UserDefaultKey.sealTop, defValue: 10);
  static set sealTop(double v) => SpUtil.putDouble(UserDefaultKey.sealTop, v);

  static double get sealBottom =>
      SpUtil.getDouble(UserDefaultKey.sealBottom, defValue: 10);
  static set sealBottom(double v) =>
      SpUtil.putDouble(UserDefaultKey.sealBottom, v);

  static int get loginCounts => SpUtil.getInt(UserDefaultKey.loginCounts);
  static set loginCounts(int v) => SpUtil.putInt(UserDefaultKey.loginCounts, v);
}

class UserDefaultKey {
  static String baseUrl = "user.default.baseUrl";
  static String isGuideFinished = "user.default.isGuideFinished";
  static String token = "user.default.token";

  static String sealRows = "user.default.sealRows";
  static String sealLines = "user.default.sealLines";
  static String sealAxisCount = "user.default.sealAxisCount";
  static String sealLeft = "user.default.sealLeft";
  static String sealRight = "user.default.sealRight";
  static String sealTop = "user.default.sealTop";
  static String sealBottom = "user.default.sealBottom";
  static String loginCounts = "user.default.loginCounts";
}
