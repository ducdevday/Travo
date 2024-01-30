import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static late SharedPreferences _pref;

  static init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static void clearAllKey() async{
    await _pref.clear();
  }

  static bool getIsFirstTime(){
    return _pref.getBool("isFirstTime") ?? true;
  }

  static void setIsFirstTime(bool value){
    _pref.setBool("isFirstTime",value);
  }

  static bool getSeenTooltip(){
    return _pref.getBool("seenToolTip") ?? false;
  }
  static void setSeenTooltip(bool value){
    _pref.setBool("seenToolTip",value);
  }

  static String? getUserId(){
    return _pref.getString("userId");
  }

  static void setUserId(String userId){
    _pref.setString("userId", userId);
  }

  static String getUserEmail(){
    return _pref.getString("userEmail") ?? "";
  }

  static void setUserEmail(String userEmail){
    _pref.setString("userEmail", userEmail);
  }

  static List<String> getLikedPlaces(){
    return _pref.getStringList("likedPlaces") ?? [];
  }

  static void setLikedPlaces(List<String> likedPlaces){
    _pref.setStringList("likedPlaces", likedPlaces);
  }

  static List<String> getLikedHotels(){
    return _pref.getStringList("likedHotels") ?? [];
  }

  static void setLikedHotels(List<String> likedHotels){
    _pref.setStringList("likedHotels", likedHotels);
  }

}