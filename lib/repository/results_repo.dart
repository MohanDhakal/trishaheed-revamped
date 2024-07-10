import 'package:flutter/material.dart';
import '../model/Exam.dart';
import '../model/Result.dart';
import '../services/BaseApi.dart';
import '../utilities/api_routes.dart';

class ResultsRepo {



  Future<List<Exam>> getExams({required int academicYear}) async {
    final response = await BaseApi.createDio()
        .get('${ApiRoutes.examForAcamdemicYear}$academicYear');
    List<Exam> exams = <Exam>[];
    response.fold((l) {
      for (var element in l.data) {
        exams.add(Exam.fromMap(element));
      }
    }, (r) {
      debugPrint(r.message + r.code.toString());
    });
    return exams;
  }

  Future<List<int>> getAcademicYears() async {
    final response =
        await BaseApi.createDio().get('${ApiRoutes.academicYears}');
    List<int> years = <int>[];
    response.fold((l) {
      for (var element in l.data) {
        years.add(element);
      }
    }, (r) {
      debugPrint(r.message + r.code.toString());
    });
    return years;
  }
  Future<List<Result>> displayResult(Map<String, dynamic> data) async {
    BaseApi baseApi = BaseApi.createDio();
    var response = await baseApi.post(data, ApiRoutes.displayResult);
    List<Result> results = <Result>[];
    response.fold((l) {
      for (var element in l.data) {
        final result = Result.fromMap(element);
        results.add(result);
      }
    }, (r) {
      debugPrint(r.message + r.code.toString());
    });
    return results;
  }


}
