import 'package:flutter/cupertino.dart';
import 'package:perfectscan/settings/settings.dart';

class ConfigViewModel extends ChangeNotifier{

  bool isWifiAutoConnect = true;
  bool isAutoOpenLinks = true;
  bool isAutoFocus = true;
  bool isModoMassaPhoto = false;
  bool isModoMassa = false;
  bool isApitar = true;
  bool isSaveScanCodes = true;
  bool isSaveMakerCodes = true;
  bool isUpdate = false;

  ConfigViewModel(){ initialise(); }

  Future<void> initialise() async {
    isWifiAutoConnect = (await Settings.get(key: 'WifiAutoConnect', valueDefault: isWifiAutoConnect))!;
    isAutoOpenLinks = (await Settings.get(key: 'AutoOpenLinks', valueDefault: isAutoOpenLinks))!;
    isAutoFocus = (await Settings.get(key: 'AutoFocus', valueDefault: isAutoFocus))!;
    isModoMassaPhoto = (await Settings.get(key: 'ModoMassaPhoto', valueDefault: isModoMassaPhoto))!;
    isModoMassa = (await Settings.get(key: 'ModoMassa', valueDefault: isModoMassa))!;
    isApitar = (await Settings.get(key: 'Apitar', valueDefault: isApitar))!;
    isSaveScanCodes = (await Settings.get(key: 'SaveScanCodes', valueDefault: isSaveScanCodes))!;
    isSaveMakerCodes = (await Settings.get(key: 'SaveMakerCodes', valueDefault: isSaveMakerCodes))!;
    isUpdate = true;
    notifyListeners();
  }

  void setWifiAutoConnect(bool value) {
    Settings.put(value: value, key: 'WifiAutoConnect');
    isWifiAutoConnect = value;
    notifyListeners();
  }

  void setAutoOpenLinks(bool value) {
    Settings.put(value: value, key: 'AutoOpenLinks');
    isAutoOpenLinks = value;
    notifyListeners();
  }

  void setAutoFocus(bool value) {
    Settings.put(value: value, key: 'AutoFocus');
    isAutoFocus = value;
    notifyListeners();
  }

  void setModoMassaPhoto(bool value) {
    Settings.put(value: value, key: 'ModoMassaPhoto');
    isModoMassaPhoto = value;
    notifyListeners();
  }

  void setModoMassa(bool value) {
    Settings.put(value: value, key: 'ModoMassa');
    isModoMassa = value;
    notifyListeners();
  }

  void setApitar(bool value) {
    Settings.put(value: value, key: 'Apitar');
    isApitar = value;
    notifyListeners();
  }

  void setSaveScanCodes(bool value) {
    Settings.put(value: value, key: 'SaveScanCodes');
    isSaveScanCodes = value;
    notifyListeners();
  }

  void setSaveMakerCodes(bool value) {
    Settings.put(value: value, key: 'SaveMakerCodes');
    isSaveMakerCodes = value;
    notifyListeners();
  }
}