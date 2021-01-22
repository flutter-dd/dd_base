part of dd_base;

ArtemisClient get api => ArtemisClient(UserDefault.baseUrl, httpClient: AuthenticatedClient());

class AuthenticatedClient extends BaseClient {
  final Client _inner = Client();
  Future<StreamedResponse> send(BaseRequest request) async {
    if (UserDefault.token != '') {
      request.headers['Authorization'] = 'JWT ${UserDefault.token}';
    }
    return _inner.send(request);
  }
}

extension API on ArtemisClient {
  Future<T> run<T, U extends JsonSerializable> (GraphQLQuery<T, U> query,) async{
    try {
      final r = await execute(query);
      if (r.hasErrors) {
        throw r.errors.first.message;
      } else {
        return r.data;
      }
    } on SocketException {
      throw "连接中断~";
    } on HttpLinkParserException {
      throw "请求失败~";
    } catch (e) {
      throw e;
    }
  }
}
