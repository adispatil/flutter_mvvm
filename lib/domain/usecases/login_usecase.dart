import 'package:dartz/dartz.dart';
import 'package:mvvm_demo/data/network/failure_response.dart';
import 'package:mvvm_demo/data/request/request.dart';
import 'package:mvvm_demo/domain/domain_reppository/repository.dart';
import 'package:mvvm_demo/domain/usecases/base_usecase.dart';
import '../model/onboarding/model.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<FailureResponse, Authentication>> execute(
      LoginUseCaseInput input) async {
    // IF DEVICE INFO IS REQUIRED THEN
    // UNCOMMENT THE BELOW LINE AND SEND THE BELOW DEVICE INFO
    // DeviceInfo _deviceInfo = await getDeviceDetails();

    return await _repository.login(LoginRequest(input.phoneNumber));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  String phoneNumber;

  LoginUseCaseInput({required this.email, required this.password, required this.phoneNumber});
}
