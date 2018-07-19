class ConsoleLine {
  String function;
  List<dynamic> params;

  ConsoleLine(this.function, this.params);

  Map<String, dynamic> toMap() {
    return {"function": function, "params": params};
  }
}

class Request {
  String url;
  Map<String, String> headers;
  String method;
  String body;

  Request(
    this.method,
    this.url, {
    this.headers,
    this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      "method": method,
      "headers": headers ?? {},
      "url": url,
      "body": body,
    };
  }
}

class Response {
  Map<String, String> headers;
  String body;
  int status;

  Response({
    this.headers,
    this.body,
    this.status,
  });

  factory Response.fromMap(Map<String, dynamic> responseMap) {
    return Response(
      headers: responseMap["headers"].cast<String, String>(),
      body: responseMap["body"],
      status: responseMap["status"],
    );
  }
}
