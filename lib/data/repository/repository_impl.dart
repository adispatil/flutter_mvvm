import 'package:dartz/dartz.dart';
import 'package:mvvm_demo/app/constants.dart';
import 'package:mvvm_demo/data/data_source/remote_data_source.dart';
import 'package:mvvm_demo/data/mapper/mapper.dart';
import 'package:mvvm_demo/data/network/failure_response.dart';
import 'package:mvvm_demo/data/network/network_info.dart';
import 'package:mvvm_demo/data/request/request.dart';
import 'package:mvvm_demo/domain/onboarding/model.dart';
import '../../domain/repository.dart';

class RepositoryImpl extends Repository {
  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<FailureResponse, Authentication>> login(
      LoginRequest loginRequestModel) async {
    if (await _networkInfo.isConnected) {
      // IT'S SAFE TO CALL THE API
      final response = await _remoteDataSource.login(loginRequestModel);
      if (response.type == Constants.statusSuccess) {
        // SUCCESS
        return Right(response.toDomain());
      } else {
        // RETURN BUSINESS LOGIC ERROR
        return Left(FailureResponse(
            response.type ?? Constants.statusError,
            response.message ??
                'We have internal server error. Please try letter'));
      }
    } else {
      // RETURN CONNECTION ERROR
      return Left(FailureResponse(
          Constants.statusError, 'Please check your internet connection'));
    }
  }
}
