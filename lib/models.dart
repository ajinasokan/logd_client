class ConsoleLine {
  String function;
  List<dynamic> params;

  ConsoleLine(this.function, this.params);

  Map<String, dynamic> toMap() {
    return {"function": function, "params": params};
  }
}

class LogdRequest {
  String url;
  Map<String, String> headers;
  String method;
  String body;

  LogdRequest(
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

class LogdResponse {
  Map<String, String> headers;
  String body;
  int status;

  LogdResponse({
    this.headers,
    this.body,
    this.status,
  });

  factory LogdResponse.fromMap(Map<String, dynamic> responseMap) {
    return LogdResponse(
      headers: responseMap["headers"].cast<String, String>(),
      body: responseMap["body"],
      status: responseMap["status"],
    );
  }
}
