import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trishaheed/repository/contacts_repo.dart';
import 'package:trishaheed/utilities/Error.dart';
import 'package:trishaheed/utilities/api_routes.dart';

import 'blog_repo_test.mocks.dart';

void main() {
  final response = {"sucess": true, "message": "feedback received sucessfully"};
  late MockBaseApi mockBaseApi;
  late ContactRepo contactRepo;
  final requestData = {
    "name": "Mohan Dhakal",
    "email": "mohan@gmail.com",
    "phone_number": "9876567897",
    "message":
        "this is my messsage to the team please forward this message to the concerned department.",
  };
  setUp(() {
    mockBaseApi = MockBaseApi();
    contactRepo = ContactRepo(mockBaseApi);
  });
  test(
    "sucessful addition of feedback",
    () async {
      //arrange
      when(mockBaseApi.post(requestData, ApiRoutes.feeback)).thenAnswer(
        (_) async => Left(
          Response(
            data: response,
            requestOptions: RequestOptions(),
          ),
        ),
      );
      //act
      final result = await contactRepo.addFeedback(requestData);
      //assert
      expect(result, response['message']);
    },
  );
  test(
    "unsucessfull insertion of feedback",
    () async {
      //arrange
      when(mockBaseApi.post(requestData, ApiRoutes.feeback)).thenAnswer(
        (_) async => Right(Failure("Couldn't Figure out", FailureType.LOCAL)),
      );
      //act
      final result = await contactRepo.addFeedback(requestData);
      //assert
      expect(result, null);
    },
  );
}
