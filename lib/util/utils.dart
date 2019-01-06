class Utils {
  static void logC(String msg) {
    print("#taskM: "+ msg);
  }
  static void logEx(Exception e, [String msg]) {
    if (msg!=null) print("#taskM: Exception "+ msg);
    print("#taskM: Exception "+ e.toString());
  }
}