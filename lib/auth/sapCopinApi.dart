import 'dart:async';
import 'package:simple_auth/simple_auth.dart';
import "package:http/http.dart" as http;



class SapCopinApi extends OAuthApi {
  SapCopinApi(String identifier, String clientId, String clientSecret,
      String redirectUrl, String tokenUrl, String authUrl, bool scopesRequired,
      {List<String> scopes,
        http.Client client,
        Converter converter,
        AuthStorage authStorage})
      : super(
      identifier,
      clientId,
      clientSecret,
      tokenUrl,
      authUrl,
      redirectUrl,
      client: client,
      scopes: scopes,
      converter: converter,
      authStorage: authStorage) {
    this.scopes = scopes ?? null;
    this.scopesRequired = scopesRequired;
  }

  Authenticator getAuthenticator() => SapAuthenticator(identifier,
      clientId, clientSecret, tokenUrl, authorizationUrl, redirectUrl, scopes);

}

class SapAuthenticator extends OAuthAuthenticator {
  Uri redirectUri;
  bool useEmbeddedBrowser = true; // w/o this setting to true it didn't worked
  SapAuthenticator(String identifier, String clientId, String clientSecret,
      String tokenUrl, String baseUrl, String redirectUrl, List<String> scopes)
      : super(identifier, clientId, clientSecret, tokenUrl, baseUrl,
      redirectUrl) {
    print("-- SapAuthenticator instantiated --");
  }
  int expiration;
  @override
  Future<Map<String, dynamic>> getTokenPostData(String clientSecret) async {
    print("-- SapAuthenticator.getTokenPostData() called --");
    var map = {
      "redirect_uri": redirectUrl,
      "code": authCode,
      "client_id": clientId,
      "client_secret": clientSecret,
      "grant_type": "authorization_code",
    };
    return map;
  }
}