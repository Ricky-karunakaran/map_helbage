import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:helbage/shared/styles.dart';
import 'package:helbage/shared/color.dart';
import 'package:helbage/shared/buttons.dart';
import 'package:helbage/view/authentication/UserLogin.dart';
import 'package:stacked/stacked.dart';
import 'package:helbage/viewmodel/HomeScreenViewModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 4));

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.nonReactive(
        viewModelBuilder: () => HomeScreenViewModel(),
        builder: (context, model, child) => Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/cover.png',
                        width: 250, height: 250),
                    Container(
                      width: 200,
                      margin: EdgeInsets.only(bottom: 0),
                      child: froyoFlatBtn('Sign In', () {
                        model.NavigateToLogin();
                      }),
                    ),
                    Container(
                      width: 200,
                      padding: EdgeInsets.all(0),
                      child: froyoOutlineBtn('Sign Up', () {
                        model.NavigateToRegister();
                      }),
                    ),
                  ],
                ),
              ),
              backgroundColor: bgColor,
            ));
  }
}