// to convert the response into a non nullable objects (model)

import 'package:mvvm_demo/app/extensions.dart';
import 'package:mvvm_demo/data/responses/authentication/login_response.dart';
import 'package:mvvm_demo/domain/onboarding/model.dart';

const EMPTY = '';
const ZERO = 0;

extension UserResponseMapper on UserDataResponse? {
  UserData toDomain() {
    return UserData(
      this?.userId?.orEmpty() ?? EMPTY,
      this?.fullName?.orEmpty() ?? EMPTY,
      this?.profilePhoto?.orEmpty() ?? EMPTY,
      this?.phoneNumber?.orEmpty() ?? EMPTY,
      this?.deviceId?.orEmpty() ?? EMPTY,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.userDataResponse?.toDomain(),
    );
  }
}
