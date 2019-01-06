

class CopinProjectController {
  static const String PROJECT_LIST_STD_FILTER = "\$skip=0&\$top=20&\$orderby=Name%20asc&\$inlinecount=allpages";


/*
  void readProjects(AuthToken token) async {
    final response = await http.get(
      getProjectUrl(),
      headers: {
        HttpHeaders.authorizationHeader: token.token_type + " " + token.access_token,
        HttpHeaders.contentTypeHeader: "application/json"
      },
    );
    print("--- readProjects() response: " + response.toString());

    //dump(response.body);

    if (response.statusCode == 200) {
      print("--- successfull call readProjects()");
      print("Body: " + response.body);
      // print("BodyBytes: " + response.bodyBytes.toString());
    } else {
      print("--- readProjects() failed " + response.statusCode.toString());
    }

    return;
  }

  */
}