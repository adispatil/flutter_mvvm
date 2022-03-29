import 'package:mvvm_demo/data/network/app_api.dart';
import 'package:mvvm_demo/data/request/request.dart';
import 'package:mvvm_demo/data/responses/authentication/login_response.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplementor implements RemoteDataSource {
  AppServiceClient _appServiceClient;

  RemoteDataSourceImplementor(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(loginRequest.phoneNumber);
  }
}
