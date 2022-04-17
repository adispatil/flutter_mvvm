import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mvvm_demo/data/mapper/mapper.dart';
import 'package:mvvm_demo/presentation/resources/assets_manager.dart';
import 'package:mvvm_demo/presentation/resources/color_manager.dart';
import 'package:mvvm_demo/presentation/resources/font_manager.dart';
import 'package:mvvm_demo/presentation/resources/strings_manager.dart';
import 'package:mvvm_demo/presentation/resources/styles_manager.dart';
import 'package:mvvm_demo/presentation/resources/values_manager.dart';

enum StateRendererType {
  // POPUP STATES
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
  POPUP_SUCCESS_STATE,

  // FULL SCREEN STATES
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  FULL_SCREEN_SUCCESS_STATE,

  // THE UI OF THE SCREEN
  CONTENT_SCREEN_STATE,

  // EMPTY VIEW WHEN WE RECEIVE NO DATA FROM API SIDE FOR LIST SCREEN
  EMPTY_SCREEN_STATE,
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function? retryActionFunction;

  StateRenderer({
    Key? key,
    required this.stateRendererType,
    required this.retryActionFunction,
    String? message,
    String? title,
  })
      : message = message ?? AppStrings.loading,
        title = title ?? EMPTY,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopUpDialog(context, [_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDialog(
            context, [_getAnimatedImage(JsonAssets.error), _getMessage(message),
          _getRetryButton(AppStrings.ok, context)]);
      case StateRendererType.POPUP_SUCCESS_STATE:
        return _getPopUpDialog(
            context, [_getAnimatedImage(JsonAssets.success), _getMessage(message),
          _getRetryButton(AppStrings.ok, context)]);
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemsInColumn([_getAnimatedImage(JsonAssets.loading), _getMessage(message)]);
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsInColumn(
            [
              _getAnimatedImage(JsonAssets.error),
              _getMessage(message),
              _getRetryButton(AppStrings.retryAgain, context)
            ]);
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();
      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemsInColumn([_getAnimatedImage(JsonAssets.empty), _getMessage(message)]);
      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [
              BoxShadow(color: Colors.black26,
                blurRadius: AppSize.s12,
                offset: Offset(AppSize.s0, AppSize.s12,),),
            ]
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName), // json image
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.p18),
        child: Text(message, style: getMediumStyle(
          color: ColorManager.black, fontSize: FontSize.s16,),),
      ),
    );
  }

  /// show retry button
  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPaddings.p18),
      child: SizedBox(
        width: AppSize.s180,
        child: ElevatedButton(onPressed: () {
          if (stateRendererType == StateRendererType.FULL_SCREEN_ERROR_STATE) {
            retryActionFunction
                ?.call(); // to call the api function again to retry
          } else {
            Navigator.of(context)
                .pop(); // POPUP STATE ERROR SO WE NEED TI DISMISS THE DIALOG
          }
        }, child: Text(buttonTitle),),
      ),
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,);
  }
}
