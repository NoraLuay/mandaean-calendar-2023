import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io' as io;

class UpdateDialog {
  var appYear = 2023; // TODO change every year
  Uri androidUrl = Uri.parse('https://play.google.com/store/apps/details?id=com.twayesh.apps.mandaeancalendar');
  Uri iOsUrl = Uri.parse('https://www.apple.com/se/app-store/');

  Future<void> showUpdateDialogIfAppNeedsUpdate(BuildContext context) async {
    int currentYear = DateTime.now().year;

    if (currentYear > appYear) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.waring),
            content: Text(AppLocalizations.of(context)!.newUpdateWarningDescription),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.update),
                onPressed: () {
                  // Launch the URL.
                  if (io.Platform.isAndroid) {
                    localLaunchUrl(androidUrl);
                  } else if (io.Platform.isIOS) {
                    localLaunchUrl(iOsUrl);
                  }
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.close),
                onPressed: ()=> exit(0),
              ),
            ],
          );
        },
      );
    }
  }

  localLaunchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw ('could not lunch $url');
    }
  }
}
