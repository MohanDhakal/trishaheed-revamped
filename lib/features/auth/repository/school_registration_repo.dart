import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trishaheed/utilities/data/school.dart';

class SchoolRegistrationRepo {
  late final SharedPreferencesWithCache preferencesWithCache;

  SchoolRegistrationRepo(SharedPreferencesWithCache prefCache) {
    preferencesWithCache = prefCache;
  }
  SchoolRegistrationRepo.initial(){
    
  }


  static Future<SchoolRegistrationRepo> create() async {
    final preferencesWithCache = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{SchoolConstant.schoolName, SchoolConstant.schoolCode,SchoolConstant.schoolUrl},
      ),
    );
    return SchoolRegistrationRepo(preferencesWithCache);
  }

  Future<String> getSchoolCode() {
    return Future.value("Value");
  }

  Future<String> getSchoolName() {
    return Future.value("Value 1");
  }

  Future<String?> getSchoolUrl() async{
    await Future.delayed(Duration(seconds: 2));
    return Future.value("value 2");
  }

  Future<bool> save(String key, String value) async {
    try {
      await preferencesWithCache.setString(key, value);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
