import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import '../domain/model/onboarding/model.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String _deviceName = 'Unknown';
  String _deviceIdentifier = 'Unknown';
  String _deviceVersion = 'Unknown';

  DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      // RETURN ANDROID DEVICE INFO
      var build = await _deviceInfo.androidInfo;
      _deviceName = '${build.brand ?? ''} ${build.model ?? ''}';
      _deviceIdentifier = build.androidId ?? '';
      _deviceVersion = build.version.codename ?? '';
    } else if (Platform.isIOS) {
      // RETURN IOS DEVICE INFO
      var build = await _deviceInfo.iosInfo;
      _deviceName = '${build.name ?? ''} ${build.model ?? ''}';
      _deviceIdentifier = build.identifierForVendor ?? '';
      _deviceVersion = build.systemVersion ?? '';
    }
  } on PlatformException {
    return DeviceInfo(_deviceName, _deviceIdentifier, _deviceVersion);
  }

  return DeviceInfo(_deviceName, _deviceIdentifier, _deviceVersion);
}
