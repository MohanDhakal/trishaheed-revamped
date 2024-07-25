import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void launchWebsite(String url) async {
  final Uri _url = Uri.parse(url);
  try {
    await launchUrl(_url);
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
}