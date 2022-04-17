abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // DECLARE ALL SHARED VARIABLES & FUNCTIONS THAT WILL BE USED THROUGH ANY VIEW MODEL

}

abstract class BaseViewModelInputs {
  void start(); // WILL BE CALLED WHILE INITIALIZATION OF VIEW.
  void dispose(); // WILL BE CALLED WHEN VIEW MODEL DIES.
}

abstract class BaseViewModelOutputs {}
