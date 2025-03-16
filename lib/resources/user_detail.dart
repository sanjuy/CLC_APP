import 'package:clc_app/resources/keys.dart';
import 'package:clc_app/resources/shared_preferance.dart';

class UserDetail {
  static Future<bool?> get getUserLoggedIn {
    return UserDefaults.shared.getBool(Keys.userLoggedIn);
  }

  static set setUserLoggedIn(bool value) {
    UserDefaults.shared.saveBool(key: Keys.userLoggedIn, value: value);
  }

  static Future<String?> get getUserId {
    return UserDefaults.shared.getString(Keys.userID);
  }

  static set setUserId(String value) {
    UserDefaults.shared.saveString(key: Keys.userID, value: value);
  }

  static Future<String?> get getUserEmail {
    return UserDefaults.shared.getString(Keys.userEmail);
  }

  static set setUserEmail(String value) {
    UserDefaults.shared.saveString(key: Keys.userEmail, value: value);
  }

  static Future<String?> get getUserName {
    return UserDefaults.shared.getString(Keys.userName);
  }

  static set setUserName(String value) {
    UserDefaults.shared.saveString(key: Keys.userName, value: value);
  }

  static Future<String?> get getMobileNUmber {
    return UserDefaults.shared.getString(Keys.mobileNUmber);
  }

  static set setMobileNUmber(String value) {
    UserDefaults.shared.saveString(key: Keys.mobileNUmber, value: value);
  }

  static Future<String?> get getGender {
    return UserDefaults.shared.getString(Keys.gender);
  }

  static set setGender(String value) {
    UserDefaults.shared.saveString(key: Keys.gender, value: value);
  }

  static Future<String?> get getMembershipType {
    return UserDefaults.shared.getString(Keys.membershiptype);
  }

  static set setMembershipType(String value) {
    UserDefaults.shared.saveString(key: Keys.membershiptype, value: value);
  }

  static Future<String?> get getUserStatus {
    return UserDefaults.shared.getString(Keys.userStatus);
  }

  static set setUserStatus(String value) {
    UserDefaults.shared.saveString(key: Keys.userStatus, value: value);
  }

  static Future<String?> get getProfilePicture {
    return UserDefaults.shared.getString(Keys.profilePicture);
  }

  static set setProfilePicture(String value) {
    UserDefaults.shared.saveString(key: Keys.profilePicture, value: value);
  }

  static Future<String?> get getAddress {
    return UserDefaults.shared.getString(Keys.address);
  }

  static set setAddress(String value) {
    UserDefaults.shared.saveString(key: Keys.address, value: value);
  }

  static Future<String?> get getFullAd {
    return UserDefaults.shared.getString(Keys.fullAd);
  }

  static set setFullAd(String value) {
    UserDefaults.shared.saveString(key: Keys.fullAd, value: value);
  }

  static Future<String?> get getListAd {
    return UserDefaults.shared.getString(Keys.listAd);
  }

  static set setListAd(String value) {
    UserDefaults.shared.saveString(key: Keys.listAd, value: value);
  }

  static Future<String?> get getPopupAd {
    return UserDefaults.shared.getString(Keys.popupAd);
  }

  static set setPopupAd(String value) {
    UserDefaults.shared.saveString(key: Keys.popupAd, value: value);
  }
}
