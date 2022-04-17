import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer.dart';
import 'package:mvvm_demo/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:mvvm_demo/presentation/resources/assets_manager.dart';
import 'package:mvvm_demo/presentation/resources/color_manager.dart';
import 'package:mvvm_demo/presentation/resources/strings_manager.dart';
import 'package:mvvm_demo/presentation/resources/values_manager.dart';
import 'package:mvvm_demo/presentation/screens/login/login_viewmodel.dart';
import '../../../app/dependency_injection.dart';
import '../../resources/routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((event) {
      if (event == true) {
        // navigate to main screen
        _navigateToMainScreen();
      }
    });
  }

  void _navigateToMainScreen() {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
    });
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
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () => _viewModel.loginButtonPress()) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPaddings.p100),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// App logo
              Image.asset(ImageAssets.splashLogo),
              const SizedBox(
                height: AppSize.s28,
              ),

              /// user name textField
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPaddings.p28,
                ),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsUserNameValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _userNameController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        hintText: AppStrings.userName,
                        labelText: AppStrings.userName,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.wrongUserName,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(
                height: AppSize.s28,
              ),

              /// password textField
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPaddings.p28,
                ),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsPasswordValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: AppStrings.password,
                        labelText: AppStrings.password,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.wrongPassword,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(
                height: AppSize.s28,
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppPaddings.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsAllInputIsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s44,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () => _viewModel.loginButtonPress()
                            : null,
                        child: const Text(AppStrings.login),
                      ),
                    );
                  },
                ),
              ),

              ///
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPaddings.p8,
                    left: AppPaddings.p28,
                    right: AppPaddings.p28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        AppStrings.forgetPassword,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        AppStrings.notAMember,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
