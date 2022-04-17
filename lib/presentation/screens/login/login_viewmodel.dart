import 'dart:async';

import 'package:mvvm_demo/app/extensions.dart';
import 'package:mvvm_demo/data/network/failure_response.dart';
import 'package:mvvm_demo/domain/model/onboarding/model.dart';
import 'package:mvvm_demo/domain/usecases/login_usecase.dart';
import 'package:mvvm_demo/presentation/base/base_view_model.dart';

import '../../common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {}

  /// input stream controllers
  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllValid => _isAllInputsValidStreamController.sink;

  @override
  loginButtonPress() async {
    (await _loginUseCase.execute(LoginUseCaseInput(
            email: loginObject.userName,
            password: loginObject.password,
            phoneNumber: '9021939021')))
        .fold((failure) => _loginFailure(failure),
            (success) => _loginSuccess(success));
  }

  void _loginFailure(FailureResponse failure) {
    print(failure.message);
  }

  void _loginSuccess(Authentication success) {
    print(success.data?.fullName);
  }

  /// output stream controllers
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputIsAllInputIsValid =>
      _isAllInputsValidStreamController.stream
          .map((event) => _isAllInputsValid());

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
        password: password); // DATA CLASS OPERATION SAME AS KOTLIN

    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(
        userName: userName); // DATA CLASS OPERATION SAME AS KOTLIN

    _validate();
  }

  /// check if password is valid or not
  bool _isPasswordValid(String password) {
    return password.isValidPassword();
  }

  /// check if user name is valid or not
  bool _isUserNameValid(String userName) {
    return userName.isValidEmail();
  }

  /// check if all user inputs are valid
  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }

  void _validate() {
    inputIsAllValid.add(null);
  }
}

abstract class LoginViewModelInputs {
  setUserName(String userName);

  setPassword(String password);

  loginButtonPress();

  // two sinks
  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputIsAllValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsAllInputIsValid;
}
