import 'dart:io';

class ConnectionUtility {

  // to check network connection
  static checkConnectionForImage() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return (result.isNotEmpty && result[0].rawAddress.isNotEmpty);
    } on SocketException catch (_) {
      return false;
    }
  }
}
