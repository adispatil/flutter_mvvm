import 'package:flutter/cupertino.dart';
import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer.dart';
import 'package:mvvm_demo/presentation/resources/strings_manager.dart';
import '../../../data/mapper/mapper.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

// Loading state (POPUP, FULL SCREEN)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// error state (POPUP, FULL SCREEN)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// success state (POPUP, FULL SCREEN)
class SuccessState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  SuccessState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// CONTENT STATE
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}

// EMPTY STATE
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            // SHOWING POPUP DIALOG
            showPopUp(context, getStateRendererType(), getMessage());
            // RETURN THE CONTENT UI OF THE SCREEN
            return contentScreenWidget;
          } else {
            // StateRendererType.StateRendererType.FULL_SCREEN_ERROR_STATE
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            // SHOWING POPUP DIALOG
            showPopUp(context, getStateRendererType(), getMessage());
            // RETURN THE CONTENT UI OF THE SCREEN
            return contentScreenWidget;
          } else // StateRendererType.StateRendererType.FULL_SCREEN_ERROR_STATE
          {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case SuccessState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.POPUP_SUCCESS_STATE) {
            // SHOWING POPUP DIALOG
            showPopUp(context, getStateRendererType(), getMessage());
            // RETURN THE CONTENT UI OF THE SCREEN
            return contentScreenWidget;
          } else {
            // StateRendererType.StateRendererType.FULL_SCREEN_SUCCESS_STATE
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case ContentState:
        dismissDialog(context);
        return contentScreenWidget;
      case EmptyState:
        return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction);
      default:
        return contentScreenWidget;
    }
  }

  /// dismiss the created dialog
  void dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  /// check if the dialog is already showing
  bool _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  void showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) => showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            retryActionFunction: () {}),
      ),
    );
  }
}
