import 'dart:async';

import 'package:mvvm_demo/domain/onboarding/model.dart';
import 'package:mvvm_demo/presentation/base/baseviewmodel.dart';

import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // stream controllers
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    // send this slider data to our view
    _postDataToView();
  }

  @override
  int goToNext() {
    int nextIndex = _currentIndex + 1;
    if (nextIndex >= _list.length) {
      _currentIndex = 0; // infinite loop to go to the length of slider
    } else {
      _currentIndex = nextIndex;
    }
    _postDataToView();
    return _currentIndex;
  }

  @override
  int goToPrevious() {
    int previousIndex = _currentIndex - 1;
    if (previousIndex == -1) {
      _currentIndex =
          _list.length - 1; // infinite loop to go to the length of slider
    } else {
      _currentIndex = previousIndex;
    }
    _postDataToView();
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  // input
  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // output
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((slideViewObject) => slideViewObject);

  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onBoarding1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onBoarding2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onBoarding3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onBoarding4),
      ];

  void _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

// input means the orders that our view model will receive from our view
abstract class OnBoardingViewModelInputs {
  /// when user clicks on right arrow or swipe
  int goToNext();

  /// when user clicks on left arrow or swipe to left
  int goToPrevious();

  void onPageChanged(int index);

  // this is the way to add the data  to the stream.. stream input
  Sink get inputSliderViewObject;
}

// output means the data or results that will be sent from our view model to our view
abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
