import 'package:simple_auth/simple_auth.dart' as simpleAuth;

class AuthToken {
  String access_token;
  String token_type;
  String id_token;
  String refresh_token;
  int expires_in;
  String scope;
  String jti;

  AuthToken.fromMap(Map respMap){
    access_token = respMap['access_token'];
    token_type = respMap['token_type'];
    id_token = respMap['id_token'];
    refresh_token = respMap['refresh_token'];
    expires_in = respMap['expires_in'];
    scope = respMap['scope'];
    jti = respMap['jti'];
  }

  AuthToken.fromAccount(simpleAuth.OAuthAccount account) {
    access_token = account.token;
    token_type = account.tokenType;
    id_token = account.idToken;
    refresh_token = account.refreshToken;
    expires_in = account.expiresIn;
    scope = account.scope.toString();
    jti = "";
  }
}