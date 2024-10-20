import 'package:hive/hive.dart';

class CacheManager {
  static const String boxName = 'tempCache';

  // Open Hive Box
  static Future<void> initHiveCache() async {
    var box = await Hive.openBox(boxName);
    // Clear the box every time the app is restarted
    await box.clear();
  }

  // Save data temporarily
  Future<void> cacheData(String key, dynamic value) async {
    var box = Hive.box(boxName);
    await box.put(key, value);
  }

  // Retrieve cached data
  dynamic getCachedData(String key) {
    var box = Hive.box(boxName);
    return box.get(key);
  }
}
