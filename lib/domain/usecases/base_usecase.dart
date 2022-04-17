import 'package:dartz/dartz.dart';
import 'package:mvvm_demo/data/network/failure_response.dart';

abstract class BaseUseCase<Input, Output> {
  Future<Either<FailureResponse, Output>> execute(Input input);
}
