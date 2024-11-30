import 'package:shared_preferences/shared_preferences.dart';
import 'package:trishaheed/utilities/data/credentials.dart';

class LoginRepo {
  SharedPreferencesWithCache? preferencesWithCache;
  LoginRepo(SharedPreferencesWithCache? prefCache) {
    preferencesWithCache = prefCache;
  }
  LoginRepo.initial();

  static Future<LoginRepo> create() async {
    final preferencesWithCache = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{
          CredentialsKey.accessToken,
          CredentialsKey.expiryDate
        },
      ),
    );
    return LoginRepo(preferencesWithCache);
  }

  Future<String?> accessToken() async {
    return preferencesWithCache != null
        ? await preferencesWithCache!.getString(CredentialsKey.accessToken)
        : null;
  }

  Future<String?> expiryDate() async {
    return preferencesWithCache != null
        ? await preferencesWithCache!.getString(CredentialsKey.expiryDate)
        : null;
  }

  Future<bool> save(String key, String value) async {
    try {
      // final currentToken = await accessToken();
      // print("Current Token $currentToken ");
      preferencesWithCache != null
          ? await preferencesWithCache!.setString(key, value)
          : null;
      return true;
    } catch (e) {
      print("Error Saving value in local storage with error: $e  ");
      return false;
    }
  }

  Future<Map<String, dynamic>> studentLogin(
      int gradeId, int studentId, String passCode) async {
    await Future.delayed(Duration(seconds: 2));
    return {
      "access_token": "xkuiya89emak2387.90()",
      "expiry_date": "2034/9/87"
    };
  }

  Future<Map<String, dynamic>> teacherLogin(
      int teacherId, String passCode) async {
    await Future.delayed(Duration(seconds: 2));
    return {
      "access_token": "xkuiya89emak2387.90()",
      "expiry_date": "2034/9/87"
    };
  }

  Future<List<Map<String, dynamic>>> getStudentsForGrade(int gradeId) async {
    await Future.delayed(Duration(seconds: 2));
    return [
      {"id": 1, "roll_number": 1, "name": "Manisha Dhakal"},
      {"id": 2, "roll_number": 2, "name": "Pancha Nepali"},
    ];
  }

  Future<List<Map<String, dynamic>>> getTeachers() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      {"id": 1, "age": 31, "name": "Suraj Chaudhary"},
      {"id": 2, "age": 27, "name": "Mohan Dhakal"},
    ];
  }

  Future<List<Map<String, dynamic>>> getGrades() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      {"id": 1, "num": 1, "name": "One"},
      {"id": 2, "num": 2, "name": "Two"},
    ];
  }
}
