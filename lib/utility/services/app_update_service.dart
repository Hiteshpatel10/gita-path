import 'dart:io';
import 'package:chapter/chapter_module/model/user_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

checkUpdate(BuildContext context, {AppUpdate? appUpdate}) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String buildNumber = packageInfo.buildNumber;
  bool updateAvailable = (appUpdate?.buildNo ?? 0) > int.parse(buildNumber);

  if (updateAvailable) {
    updateDrawer(context, appUpdate: appUpdate);
  }


  if ((appUpdate?.softUpdate == 1 || appUpdate?.forceUpdate == 1) && updateAvailable && kReleaseMode) {

    try{
      InAppUpdate.checkForUpdate().then(
            (updateInfo) {
          if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
            if (appUpdate?.forceUpdate == 1) {
              debugPrint('FORCE UPDATE STARTED');
              InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
                if (appUpdateResult == AppUpdateResult.success) {}
              });
            } else if (appUpdate?.forceUpdate == 0) {
              debugPrint('SOFT UPDATE STARTED');

              InAppUpdate.startFlexibleUpdate().then(
                    (appUpdateResult) {
                  if (appUpdateResult == AppUpdateResult.success) {
                    InAppUpdate.completeFlexibleUpdate();
                  }
                },
              );
            }
          }
        },
      );
    }catch(e){
      debugPrint("InAppUpdate Failure");
    }
  }
}


updateDrawer(BuildContext context, {required AppUpdate? appUpdate}) {
  if (appUpdate?.forceUpdate == 1) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: CupertinoAlertDialog(
            title: Text(appUpdate?.title ?? 'Update Available'),
            content: Text(appUpdate?.message ?? 'A new version of the app is available.'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Update'),
                onPressed: () async {
                  _launchStore();
                },
              ),
              if (appUpdate?.forceUpdate == 0)
                CupertinoDialogAction(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

void _launchStore() async {
  if (Platform.isAndroid || Platform.isIOS) {
    final appId = Platform.isAndroid ? 'com.gitasarathi' : '1246082058';
    final uri = Platform.isAndroid
        ? 'market://details?id=$appId'
        : 'https://apps.apple.com/gb/app/id$appId';

    final url = Uri.parse(uri);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch Store URL';
    }
  }
}

