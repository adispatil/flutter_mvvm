import 'package:dartz/dartz.dart';
import 'package:mvvm_demo/domain/onboarding/model.dart';

import '../data/network/failure_response.dart';
import '../data/request/request.dart';

abstract class Repository {
  Future<Either<FailureResponse, Authentication>> login(
      LoginRequest loginRequestModel);
}
