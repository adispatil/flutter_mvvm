import 'package:dio/dio.dart';
import 'package:mvvm_demo/app/constants.dart';
import 'package:mvvm_demo/data/responses/authentication/login_response.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST('/contacts/checkContactExists')
  Future<AuthenticationResponse> login(
      @Field('phoneNumber') String phoneNumber);
}
