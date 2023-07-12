

import 'package:url_launcher/url_launcher.dart';

class LauncherUtils{
  LauncherUtils._();

  /// terms and condition
  static Future<void> launchTermConditionUrl() async {
    const String scheme = 'https://khatasystem.com/TermsConditions/Index';
    final Uri uri = Uri.parse(scheme);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

  static Future<void> launchPolicyUrl() async {
    const String scheme = 'https://khatasystem.com/Policy/Index';
    final Uri uri = Uri.parse(scheme);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

  static Future<void> openMap() async{
    const latitude = 27.686006687496327;
    const longitude = 85.34108217987517;

    const url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Could not open Map";
    }
  }

  static Future<void> openPhone(String phoneNumber) async{

    final url = 'tel:$phoneNumber';

    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Could not open phone";
    }
  }

  static Future<void> openMail() async{
    const String recipientEmail = 'reply2search@gmail.com';
    const subject = 'Help about Khata System (App)';
    const body = "";

    const url = 'mailto:$recipientEmail?subject=$subject&body=$body';

    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Could not open Mail";
    }
  }

  static Future<void> launchKhataWeb() async {
    const String scheme = 'https://khatasystem.com/';
    final Uri uri = Uri.parse(scheme);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

}


