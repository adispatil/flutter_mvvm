import 'package:dartz/dartz.dart';

import '../../data/network/failure_response.dart';
import '../../data/request/request.dart';
import '../model/onboarding/model.dart';

abstract class Repository {
  Future<Either<FailureResponse, Authentication>> login(
      LoginRequest loginRequestModel);
}
