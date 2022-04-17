import 'package:dartz/dartz.dart';
import 'package:mvvm_demo/app/constants.dart';
import 'package:mvvm_demo/data/data_source/remote_data_source.dart';
import 'package:mvvm_demo/data/mapper/mapper.dart';
import 'package:mvvm_demo/data/network/error_handler.dart';
import 'package:mvvm_demo/data/network/failure_response.dart';
import 'package:mvvm_demo/data/network/network_info.dart';
import 'package:mvvm_demo/data/request/request.dart';
import '../../domain/model/onboarding/model.dart';
import '../../domain/domain_reppository/repository.dart';

class RepositoryImpl extends Repository {
  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<FailureResponse, Authentication>> login(
      LoginRequest loginRequestModel) async {
    if (await _networkInfo.isConnected) {
      try {
        // IT'S SAFE TO CALL THE API
        final response = await _remoteDataSource.login(loginRequestModel);
        if (response.type == Constants.statusSuccess) {
          // SUCCESS
          // RETURN RIGHT
          return Right(response.toDomain());
        } else {
          // RETURN BUSINESS LOGIC ERROR
          // RETURN LEFT
          return Left(FailureResponse(response.type ?? Constants.statusError,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failureResponse);
      }
    } else {
      // RETURN CONNECTION ERROR
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
