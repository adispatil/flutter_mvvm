import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm_demo/presentation/resources/assets_manager.dart';
import 'package:mvvm_demo/presentation/resources/color_manager.dart';
import 'package:mvvm_demo/presentation/resources/strings_manager.dart';
import 'package:mvvm_demo/presentation/resources/values_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final List<SliderObject> _list = _getSliderData();
  int _currentIndex = 0;

  final PageController _pageController = PageController(initialPage: 0);

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

  @override
  Widget build(BuildContext context) {
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
          itemCount: _list.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return OnBoardingPage(
              sliderObject: _list[index],
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
                onPressed: () {},
                child: Text(
                  AppStrings.skip,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),

            // add layout for indicator
            Container(
                color: ColorManager.primary, child: _getBottomSheetWidget()),
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Left arrow
        Padding(
          padding: const EdgeInsets.all(AppPaddings.p14),
          child: InkWell(
            onTap: () {
              // go to previous slide
              _pageController.animateToPage(_getPreviousIndex(),
                  duration:
                      const Duration(milliseconds: DurationConstants.d300),
                  curve: Curves.bounceInOut);
            },
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.icLeftArrow, color: ColorManager.white,),
            ),
          ),
        ),

        /// circles indicator
        Row(
          children: [
            for (int i = 0; i < _list.length; i++)
              Padding(
                padding: const EdgeInsets.all(AppPaddings.p8),
                child: _getProperCircle(i),
              ),
          ],
        ),

        /// Right arrow
        Padding(
          padding: const EdgeInsets.all(AppPaddings.p14),
          child: InkWell(
            onTap: () {
              // get next slide
              _pageController.animateToPage(_getNextIndex(),
                  duration:
                      const Duration(milliseconds: DurationConstants.d300),
                  curve: Curves.bounceInOut);
            },
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.icRightArrow, color: ColorManager.white,),
            ),
          ),
        )
      ],
    );
  }

  Widget _getProperCircle(int index) {
    if (index == _currentIndex) {
      return SvgPicture.asset(ImageAssets.icHollowCircle); // selected slider
    } else {
      return SvgPicture.asset(ImageAssets.icSolidCircle); // unselected slider
    }
  }

  int _getPreviousIndex() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex =
          _list.length - 1; // infinite loop to go to the length of slider
    }

    return _currentIndex;
  }

  int _getNextIndex() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0; // infinite loop to go to the length of slider
    }

    return _currentIndex;
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

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}
