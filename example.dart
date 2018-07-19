import 'lib/logd_client.dart';

void main() async {
  Logd.init(enableLogs: Logd.isInDebug);

  Console.clear();

  Console.log("name", "ajin asokan");
  Console.warn("name", ["asokan", "ajin"]);
  Console.info("name", 1);
  Console.error("name", {"name": "ajin"});

  Console.group('%caction', 'color:grey;font-weight:bold;', "ActionName");
  Console.log('%cprev state', 'color:#f17b5e;font-weight:bold;', {"name": ""});
  Console.log('%caction', 'color:#03A9F4;font-weight:bold;', {});
  Console.log('%cnew state', 'color:#4CAF50;font-weight:bold;', {"name": ""});
  Console.log('%cconsumed', 'color:#f25e99;font-weight:bold;', '2ms');
  Console.groupEnd();

  Console.table([
    {"name": "ajin"},
    {"name": "sujith"},
    {"name": "vivek"},
  ]);

  await Storage.set("name", "ajin");

  print(await Storage.get("name"));

  var resp = await Network.send(
      LogdRequest('get', 'https://api.kite.trade', headers: {"test": "value"}));

  print(resp.body);
}
