import 'package:trishaheed/features/auth/repository/school_registration_repo.dart';
import 'package:trishaheed/utilities/data/school.dart';

class SchoolRegistrationService {
  SchoolRegistrationRepo? schoolRegistrationRepo;
  SchoolRegistrationService(SchoolRegistrationRepo? repo) {
    schoolRegistrationRepo = repo;
  }

  Future<bool> saveName(String name) async {
    if (schoolRegistrationRepo != null) {
      final output =
          await schoolRegistrationRepo!.save(SchoolConstant.schoolName, name);
      return output;
    }
    return false;
  }

  Future<bool> saveCode(String code) async {
    if (schoolRegistrationRepo != null) {
      final output =
          await schoolRegistrationRepo!.save(SchoolConstant.schoolCode, code);

      return output;
    }
    return false;
  }

  Future<bool> saveUrl(String url) async {
    if (schoolRegistrationRepo != null) {
      final output =
          await schoolRegistrationRepo!.save(SchoolConstant.schoolCode, url);
      return output;
    }
    return false;
  }

  Future<String?> getUrlFromInternetAndSave(String name, String code) async {
    //TODO: update this to get the url from the internet
    if (schoolRegistrationRepo != null) {
      final url = await schoolRegistrationRepo?.getSchoolUrl();
      if (url != null) {
        saveUrl(url);
      }
      return url;
    }
    return null;
  }

  Future<String?> getUrlFromStorage() async {
    if (schoolRegistrationRepo != null) {
      final url = await schoolRegistrationRepo!.getSchoolUrl();
      return url;
    }
    return null;
  }
}

class SchoolRegistrationServiceInitial extends SchoolRegistrationService {
  SchoolRegistrationServiceInitial(SchoolRegistrationRepo repo) : super(repo);
}
