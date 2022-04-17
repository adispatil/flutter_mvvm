import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm_demo/presentation/resources/assets_manager.dart';
import 'package:mvvm_demo/presentation/resources/color_manager.dart';
import 'package:mvvm_demo/presentation/resources/strings_manager.dart';
import 'package:mvvm_demo/presentation/resources/values_manager.dart';
import 'package:mvvm_demo/presentation/screens/onboarding/onboarding_viewmodel.dart';

import '../../../domain/model/onboarding/model.dart';
import '../../resources/routes_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);

  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  _bind() {
    _viewModel.start();
  }

  _navigateToLoginScreen() {
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context, snapshot) {
          return _getContentWidget(snapshot.data);
        });
  }

  Widget _getContentWidget(SliderViewObject? data) {
    if (data == null) {
      return Container();
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark),
        ),
        backgroundColor: ColorManager.white,
        body: PageView.builder(
            controller: _pageController,
            itemCount: data.numOfSlides,
            onPageChanged: (index) {
              _viewModel.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              return OnBoardingPage(
                sliderObject: data.sliderObject,
              );
            }),
        bottomSheet: Container(
          color: ColorManager.white,
          height: AppSize.s100,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    _navigateToLoginScreen();
                  },
                  child: Text(
                    AppStrings.skip,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ),

              // add layout for indicator
              Container(
                color: ColorManager.primary,
                child: _getBottomSheetWidget(data),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.icSolidCircle); // selected slider
    } else {
      return SvgPicture.asset(ImageAssets.icHollowCircle); // unselected slider
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Left arrow
        Padding(
          padding: const EdgeInsets.all(AppPaddings.p14),
          child: InkWell(
            onTap: () {
              // go to previous slide
              _pageController.animateToPage(_viewModel.goToPrevious(),
                  duration:
                      const Duration(milliseconds: DurationConstants.d300),
                  curve: Curves.bounceInOut);
            },
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(
                ImageAssets.icLeftArrow,
                color: ColorManager.white,
              ),
            ),
          ),
        ),

        /// circles indicator
        Row(
          children: [
            for (int i = 0; i < sliderViewObject.numOfSlides; i++)
              Padding(
                padding: const EdgeInsets.all(AppPaddings.p8),
                child: _getProperCircle(i, sliderViewObject.currentIndex),
              ),
          ],
        ),

        /// Right arrow
        Padding(
          padding: const EdgeInsets.all(AppPaddings.p14),
          child: InkWell(
            onTap: () {
              // get next slide
              _pageController.animateToPage(_viewModel.goToNext(),
                  duration:
                      const Duration(milliseconds: DurationConstants.d300),
                  curve: Curves.bounceInOut);
            },
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(
                ImageAssets.icRightArrow,
                color: ColorManager.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({required this.sliderObject, Key? key})
      : super(key: key);

  final SliderObject sliderObject;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPaddings.p8),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPaddings.p8),
          child: Text(
            sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(
          sliderObject.image,
          height: MediaQuery.of(context).size.width * 0.7,
          width: MediaQuery.of(context).size.width * 0.7,
        ),
      ],
    );
  }
}
