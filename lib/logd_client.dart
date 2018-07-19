library logd_client;

import 'dart:async';
import 'dart:convert';
import 'task_queue.dart';
import 'models.dart';
import 'utils.dart';

export 'models.dart';

String _host = "localhost";
int _port = 1234;
bool _enableLogs = Logd.isInDebug;

class Logd {
  static bool get isInDebug {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  static void init({String host, int port, bool enableLogs}) {
    if (host != null) _host = host;
    if (port != null) _port = port;
    if (enableLogs != null) _enableLogs = enableLogs;
  }
}

class Console {
  static var requests = TaskQueue();

  static void raw(List<ConsoleLine> logs) {
    if (!_enableLogs) return;
    requests.add(() async => await post(
          buildURL(_host, _port, "console"),
          json.encode(logs.map((line) => line.toMap()).toList()),
        ));
  }

  static void log(p0, [p1, p2, p3, p4, p5, p6, p7, p8, p9]) {
    if (!_enableLogs) return;
    var params = getParams(p0, p1, p2, p3, p4, p5, p6, p7, p8, p9);
    raw([ConsoleLine("log", params)]);
  }

  static void error(p0, [p1, p2, p3, p4, p5, p6, p7, p8, p9]) {
    if (!_enableLogs) return;
    var params = getParams(p0, p1, p2, p3, p4, p5, p6, p7, p8, p9);
    raw([ConsoleLine("error", params)]);
  }

  static void warn(p0, [p1, p2, p3, p4, p5, p6, p7, p8, p9]) {
    if (!_enableLogs) return;
    var params = getParams(p0, p1, p2, p3, p4, p5, p6, p7, p8, p9);
    raw([ConsoleLine("warn", params)]);
  }

  static void info(p0, [p1, p2, p3, p4, p5, p6, p7, p8, p9]) {
    if (!_enableLogs) return;
    var params = getParams(p0, p1, p2, p3, p4, p5, p6, p7, p8, p9);
    raw([ConsoleLine("info", params)]);
  }

  static void group(p0, [p1, p2, p3, p4, p5, p6, p7, p8, p9]) {
    if (!_enableLogs) return;
    var params = getParams(p0, p1, p2, p3, p4, p5, p6, p7, p8, p9);
    raw([ConsoleLine("group", params)]);
  }

  static void groupEnd() {
    if (!_enableLogs) return;
    raw([ConsoleLine("groupEnd", [])]);
  }

  static void table(p0) {
    if (!_enableLogs) return;
    raw([
      ConsoleLine("table", [p0])
    ]);
  }

  static void clear() {
    if (!_enableLogs) return;
    raw([ConsoleLine("clear", [])]);
  }
}

class Storage {
  static Future<String> get(String key) async {
    return json.decode(await post(
      buildURL(_host, _port, "storage"),
      json.encode({
        "function": "get",
        "params": [key]
      }),
    ));
  }

  static Future<void> set(String key, String value) async {
    await post(
      buildURL(_host, _port, "storage"),
      json.encode({
        "function": "set",
        "params": [key, value]
      }),
    );
  }
}

class Network {
  static Future<Response> send(Request request) async {
    var responseMap = json.decode(await post(
      buildURL(_host, _port, "network"),
      json.encode(request.toMap()),
    ));

    return Response.fromMap(responseMap);
  }
}
