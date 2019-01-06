import 'dart:async';
import 'package:flutter/widgets.dart';
import "package:simple_auth/simple_auth.dart";
import 'package:simple_auth_flutter/simple_auth_flutter.dart';

// task manager
import 'package:task_manager/auth/sapCopinApi.dart';
import 'package:task_manager/config/sapCopinConfig.dart';
import 'package:task_manager/util/utils.dart';
import 'package:task_manager/auth/authToken.dart';

class SAPCopinAccount {
  static final SAPCopinAccount _sapCopinAccount = new SAPCopinAccount._internal();
  bool didInit = false;
  Account copinAccount = null;
  final SapCopinApi _copinApi = new SapCopinApi("CopinStaging",
                                                SapCopinStaging.CLIENT_ID,
                                                SapCopinStaging.CLIENT_SECRET,
                                                "http://localhost:8080/",
                                                SapCopinStaging.TOKEN_URL,
                                                SapCopinStaging.AUTHORIZE_URL,
                                                false);

  factory SAPCopinAccount() {
    return _sapCopinAccount;
  }

  SAPCopinAccount._internal();

  // init() muss im statful flutter ui aufgerufen werden
  Future init(BuildContext context) async {
    return await _init(context);
  }


  Future _init(BuildContext context) async {
    // this init is needed for the embedded login dialog. With this a flutter
    // depencency (BuildContext) has been injected.
    // @todo: Consider whether this is good for the oAuth library?
    SimpleAuthFlutter.init(context);
    // login
    copinAccount = await _copinApi.authenticate();
    //copinApi.getAccountFromMap(data)

    if(copinAccount!=null) {
      Utils.logC("successful login into copin");
      didInit = true;
    } else {
      print("copin login failed");
      didInit = false;
    }
    // initialization logic here

  }

  Account _getAccount() {
    if(didInit) {
      return copinAccount;
    } else {
      throw new Exception("Copin Account not initialied!");
    }
  }

  AuthToken getToken() {
     return AuthToken.fromAccount(_getAccount());
  }
  // rest of the class
}