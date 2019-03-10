import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/bloc/bloc_provider.dart';
import 'package:inventory_management/bundles/common/colors.dart';
import 'package:inventory_management/bundles/common/utils.dart';
import 'package:inventory_management/bundles/home/home.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Stack(children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0),
              color: appColors.mainColor,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: Utils.getScreenWidth(context) / 6),
                  buildTopLogImage(),
                  SizedBox(height: 20.0),
                  buildAccountTextField(),
                  SizedBox(height: 16.0),
                  buildPasswordTextField(),
                  SizedBox(height: 20.0),
                  buildSubmitBottom(context),
                  buildForgetText(),
                ],
              ),
            ),
            buildVersionText(),
          ]);
        },
      ),
    );
  }

  Widget buildTopLogImage() {

    return Container(
      // child: Image.asset(
      //   imagePaths.loginLog,
      //   height: 109.0,
      //   width: 223.0,
      // ),
    );
  }

  Widget buildAccountTextField() {
    return TextField(
      // onChanged: loginBloc.accountOnchange,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(
          Icons.person,
          size: 30.0,
        ),
        hintText: 'Please enter your account number',
        labelText: 'Account',
        contentPadding: EdgeInsets.all(10.0),
      ),
    );
  }

  Widget buildPasswordTextField() {
    return TextField(
      // onChanged: loginBloc.passwordOnchange,
      textCapitalization: TextCapitalization.words,
      obscureText: true,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(
          Icons.lock,
          size: 30.0,
        ),
        hintText: 'Please enter your password',
        labelText: 'Password',
        contentPadding: EdgeInsets.all(10.0),
      ),
    );
  }

  Widget buildSubmitBottom(
    context,
  ) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
          color: Color.fromRGBO(231, 183, 61, 1.0),
          textColor: Colors.white,
          child: Text('Login'),
          onPressed: () {
            // loginBloc.login(context);
            Utils.replaceScreen(
                context,
                BlocProvider(
                  bloc: appBloc,
                  child: Home(),
                ));
          }),
    );
  }

  Widget buildForgetText() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      alignment: Alignment.centerRight,
      width: double.infinity,
      child: Text(
        'Forget password?',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget buildVersionText() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      child: Text(
        'Version:1.0.0',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
