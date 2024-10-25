import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trishaheed/services/hive_cache_manager.dart';

Future<void> initHive() async {
  Directory appDocDir = await getTemporaryDirectory();
  Hive.init(appDocDir.path);
  await Hive.openBox('cachedPosts');
  await CacheManager.initHiveCache();
}

class HiveCacheStore {
  late Box cacheBox;
  HiveCacheStore() {
    cacheBox = Hive.box('cachedPosts');
  }
  Future<void> storeCache(String key, dynamic response) async {
    await cacheBox.put(key, response);
  }

  dynamic getCache(String key) {
    return cacheBox.get(key);
  }

  Future<void> clearCache(String key) async {
    await cacheBox.delete(key);
  }
}
