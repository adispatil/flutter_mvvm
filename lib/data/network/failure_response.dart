import 'package:mvvm_demo/data/network/error_handler.dart';

class FailureResponse {
  String type; // success or failed
  String message;

  FailureResponse(this.type, this.message);
}

class DefaultFailure extends FailureResponse {
  DefaultFailure()
      : super(ResponseCode.DEFAULT.toString(), ResponseMessage.DEFAULT);
}
