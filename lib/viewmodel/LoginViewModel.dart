import 'package:flutter/cupertino.dart';
import 'package:helbage/app/route.locator.dart';
import 'package:helbage/services/FirebaseServices/FirebaseAuth.dart';
import 'package:helbage/view/main/ResidentMainScreen.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:helbage/app/route.router.dart';
import 'package:helbage/app/route.locator.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  FirebaseAuthService auth = FirebaseAuthService();

  FirebaseAuthService get _auth => auth;

  Future<bool> login(GlobalKey<FormState> _formkey, TextEditingController email,
      TextEditingController password) async {
    Future.delayed(Duration(seconds: 5));
    if (!_formkey.currentState!.validate()) {
      return false;
    } else {
      dynamic result =
          await auth.signInWithEmailAndPassword(email.text, password.text);

      if (result == null) {
        _dialogService.showDialog(
            title: "Login Error",
            description: "Invalid Credentials",
            dialogPlatform: DialogPlatform.Material);
        return false;
      } else {
        return true;
      }
    }
  }

  void NaviageToMain() {
    _navigationService.navigateTo(Routes.residentMainScreen);
  }

  void NavigateToRegister() {
    _navigationService.navigateTo(Routes.userRegister);
  }

  void NavigateToForgetPassword() {
    _navigationService.navigateTo(Routes.forgetPassword);
  }
}
