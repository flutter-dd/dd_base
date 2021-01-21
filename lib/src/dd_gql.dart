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
