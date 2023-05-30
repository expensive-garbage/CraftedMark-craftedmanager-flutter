import 'package:http/http.dart' as http;

class OneSignalAPI {
  static const _url = "https://onesignal.com/api/v1/notifications";
  static const _restApiKey = "MzVhNWRjN2ItZDVmZC00ZTZiLTk5NzYtNzc2NDEyMTU2NWM2";
  static const _appKey = "fed52d24-522d-4653-ae54-3c23d0a735ac";

  static const String companyName = "CraftedManager";

  static Future<void> sendNotification(String message) async {
    var uri = Uri.parse(_url);

    var payload = {
      "included_segments": "Subscribed Users",
      "app_id": _appKey,
      "contents": {
        "en": message,
      },
      "name": companyName,
    };
    var headers = {
      "accept": "application/json",
      "Authorization": "Basic $_restApiKey",
      "content-type": "application/json"
    };
    try {
      var result = await http.post(uri, headers: headers, body: payload);

      print( result.body.toString());
    }catch(e){
      print(e);
    }

  }
}