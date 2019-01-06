/**
 * sapCopinConfig_Dummy.dart
 *
 * To activate this source file
 * - remove "_Dummy" and
 * - add the proper oauth attributes
 */
class SapCopinStaging {
  // oAuth Information
  static const String CLIENT_ID = "client id";
  static const String CLIENT_SECRET = "client secret";
  static const String TOKEN_URL =
      "https://copin.url.com/oauth/token";
  static const String TOKEN_PATH =
      "/oauth/token";
  static const String AUTHORIZE_URL =
      "https://copin.url.com/oauth/authorize";
  static const String BASE_URL =
      "https://copin.url.com";
  static const List<String> SCOPES = [
    "scope-1",
    "scope-2"
  ];

  // Task Management URLs
  static const String TASK_SRV = "https://https://copin.url.com/task-srv";
  static const String TASK_SRV_POSTFIX = "Tasks";

  // Project Service URLs
  static const String PROJECT_SRV = "https://copin.url.com/project-srv";
  static const String PROJECT_SRV_POSTFIX ="Projects";


}