import 'dart:io';
import 'dart:async';
import 'dart:convert';

List<dynamic> getParams(p0, p1, p2, p3, p4, p5, p6, p7, p8, p9) {
  var params = [];
  if (p0 != null) params.add(p0);
  if (p1 != null) params.add(p1);
  if (p2 != null) params.add(p2);
  if (p3 != null) params.add(p3);
  if (p4 != null) params.add(p4);
  if (p5 != null) params.add(p5);
  if (p6 != null) params.add(p6);
  if (p7 != null) params.add(p7);
  if (p8 != null) params.add(p8);
  if (p9 != null) params.add(p9);
  return params;
}

Future<String> post(String url, String data) async {
  var client = HttpClient();
  var req = await client.postUrl(Uri.parse(url));
  req.write(data);
  var res = await req.close();
  client.close(force: true);
  StringBuffer builder = new StringBuffer();
  await for (String a in await res.transform(utf8.decoder)) {
    builder.write(a);
  }
  return builder.toString();
}

String buildURL(String host, int port, String namespace) {
  return "http://" + host + ":" + port.toString() + "/" + namespace;
}
