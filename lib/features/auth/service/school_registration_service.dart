import 'package:trishaheed/features/auth/repository/school_registration_repo.dart';
import 'package:trishaheed/utilities/data/school.dart';

class SchoolRegistrationService {
  late SchoolRegistrationRepo schoolRegistrationRepo;
  SchoolRegistrationService(SchoolRegistrationRepo repo) {
    schoolRegistrationRepo = repo;
  }

  Future<bool> saveName(String name) async {
    final output =
        await schoolRegistrationRepo.save(SchoolConstant.schoolName, name);
    return output;
  }

  Future<bool> saveCode(String code) async {
    final output =
        await schoolRegistrationRepo.save(SchoolConstant.schoolCode, code);
    return output;
  }

  Future<bool> saveUrl(String url) async {
    final output =
        await schoolRegistrationRepo.save(SchoolConstant.schoolCode, url);
    return output;
  }

  Future<String?> getUrlFromInternetAndSave(String name, String code) async {

    //TODO: update this to get the url from the internet
    final url = await schoolRegistrationRepo.getSchoolUrl();
    if (url != null) {
      saveUrl(url);
    }
    return url;
  }

  Future<String?> getUrlFromStorage() async {
    final url = await schoolRegistrationRepo.getSchoolUrl();
    return url;
  }
}
class SchoolRegistrationServiceInitial extends SchoolRegistrationService {
  SchoolRegistrationServiceInitial(super.repo);
}