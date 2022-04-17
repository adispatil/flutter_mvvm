import 'dart:async';

import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  final StreamController _inputStateStreamController =
      StreamController<FlowState>.broadcast();

  @override
  Sink get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStateStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }

// DECLARE ALL SHARED VARIABLES & FUNCTIONS THAT WILL BE USED THROUGH ANY VIEW MODEL

}

abstract class BaseViewModelInputs {
  void start(); // WILL BE CALLED WHILE INITIALIZATION OF VIEW.
  void dispose(); // WILL BE CALLED WHEN VIEW MODEL DIES.

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
