import 'dart:convert';
import 'dart:io';
import 'dart:core';



class NetworkManager {
  //I was just too stubborn to ever be governed by enforced insanity
  //Someone had to reach for the rising star, I knew it was up to me

  //Create singleton
  static NetworkManager _instance;

  factory NetworkManager() => _instance ??= new NetworkManager._();

  List<Cookie> cookies = [];

  NetworkManager._();


  void addCookie(String k, String v) {
    var c = new Cookie(k, v);
    if (k.contains('cosign')) {
      c.secure = true;
    }
    cookies.add(c);
  }

  void addCookies(List<Cookie> cookieList) {
    cookies.insertAll(0, cookieList);
  }

  void clearCookies() {
    cookies.clear();
  }

  Future<dynamic> postRequest(String url,
      {Map jsonBody, Map<String, dynamic> headers}) async {
    HttpClient httpClient = new HttpClient();

    //Set up request object
    try {
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));

      if (headers != null) {
        headers.forEach((k, v) {
          request.headers.set(k, v);
        });
      } else {
        request.cookies.insertAll(0, cookies);
        request.headers.set('content-type', 'application/json');
      }

      if (jsonBody != null) {
        request.add(utf8.encode(json.encode(jsonBody)));
      }

      //Send request
      HttpClientResponse response = await request.close();

      if (response.statusCode != 200 && response.statusCode != 201) {
        print("Uh oh, HTTP error for $url");
        print(response.statusCode.toString());
        String errorStr = await response.transform(utf8.decoder).join();
        print(errorStr);
        return {};
      }

      String reply = await response.transform(utf8.decoder).join();
//      Map jsonObj = json.decode(reply);
      httpClient.close();
      return reply;
    } catch (e) {
      print('POST request failed: ' + e.toString());
      return null;
    }
  }

  Future<dynamic> getRequest(String url,
      {Map<String, String> parameters, Map<String, dynamic> headers}) async {
    HttpClient client = new HttpClient();

    var urlStr = url;
    var addedInitial = false;
    if (parameters != null) {
      parameters.forEach((k, v) {
        urlStr += addedInitial ? '&' : '?';
        urlStr += k + '=' + v;
        addedInitial = true;
      });
    }

    try {
      HttpClientRequest request = await client.getUrl(Uri.parse(urlStr));

      if (headers != null) {
        headers.forEach((k, v) {
          request.headers.set(k, v);
        });
      }

      HttpClientResponse response = await request.close();

      if (response.statusCode != 200) {
        print("GET failed: ${response.statusCode} for $url");
        return null;
      }

      String replyText = await response.transform(utf8.decoder).join();
      client.close();
      print(replyText);
      var finalObj = json.decode(replyText);
      return finalObj;
    } catch (e) {
      print("Failed to parse JSON for $url");
      return null;
    }
  }
}
