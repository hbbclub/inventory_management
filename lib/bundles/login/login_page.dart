import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/agent/agent.dart';

import 'package:inventory_management/bundles/agent/api.dart';
import 'package:inventory_management/bundles/bloc/bloc_provider.dart';
import 'package:inventory_management/bundles/common/utils.dart';
import 'package:inventory_management/bundles/home/home.dart';
import 'package:inventory_management/bundles/login/user_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Platform messages are asynchronous, so we initialize in an async method.
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Stack(children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: Utils.getScreenWidth(context) / 6),
                      buildTopLogImage(),
                      SizedBox(height: 20.0),
                      buildAccountTextField(),
                      SizedBox(height: 16.0),
                      buildPasswordTextField(),
                      SizedBox(height: 20.0),
                      buildServerTextField(),
                      SizedBox(height: 20.0),
                      buildLinkWordTextField(),
                      SizedBox(height: 20.0),
                      buildSubmitBottom(context),
                      // buildForgetText(),
                    ],
                  ),
                )),
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
    return TextFormField(
      controller: TextEditingController(text: Utils.userName),
      textCapitalization: TextCapitalization.words,
      validator: (text) {
        return text.isEmpty ? 'account is invalid' : null;
      },
      onSaved: (text) {
        Utils.userName =text;
        Utils.addLoaclCache({
          Utils.cacheKeyForUsername: text,
        });
      },
      decoration: const InputDecoration(
        hintText: 'Please enter your account number',
        labelText: 'Account',
        contentPadding: EdgeInsets.all(10.0),
      ),
    );
  }

  Widget buildPasswordTextField() {
    return TextFormField(
      controller: TextEditingController(text: Utils.password),
      textCapitalization: TextCapitalization.words,
      obscureText: true,
      validator: (text) {
        return text.isEmpty ? 'password is invalid' : null;
      },
      onSaved: (text) {
        Utils.password = text;
        Utils.addLoaclCache({
          Utils.cacheKeyForPassword: text,
        });
      },
      decoration: const InputDecoration(
        hintText: 'Please enter your password',
        labelText: 'Password',
        contentPadding: EdgeInsets.all(10.0),
      ),
    );
  }

  Widget buildServerTextField() {
    return TextFormField(
      controller: TextEditingController(text: Utils.hostUri),
      textCapitalization: TextCapitalization.words,
      validator: (text) {
        return text.isEmpty ? 'server address is invalid' : null;
      },
      onSaved: (text) {
        Utils.hostUri = text;
        httpUtil.changeHostUrl('http://' + text);
        Utils.addLoaclCache({
          Utils.cacheKeyForHostUrl: text,
        });
      },
      decoration: const InputDecoration(
        hintText: 'Please enter server host address',
        labelText: 'Server Address',
        contentPadding: EdgeInsets.all(10.0),
      ),
    );
  }

  Widget buildLinkWordTextField() {
    return TextFormField(
      controller: TextEditingController(text: Utils.linkWord),
      textCapitalization: TextCapitalization.words,
      validator: (text) {
        return text.isEmpty ? 'link word is invalid' : null;
      },
      onSaved: (text) {
        Utils.linkWord = text;
        Utils.addLoaclCache({
          Utils.cacheKeyForLinkWord: text,
        });
      },
      decoration: const InputDecoration(
        hintText: 'Please enter link word',
        labelText: 'Link Word',
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
          color: Colors.blue,
          textColor: Colors.white,
          child: Text('Login'),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              ApiModel result = await api.login(
                  username: Utils.userName,
                  password: Utils.password,
                  linkWord: Utils.linkWord);
              if (result.isError()) {
                Utils.showSnackBar(context, text: result.data['message']);
                return;
              }
              Utils.user = UserModel.fromJson(result.data['user']);
              httpUtil.commonHeader.addAll({
                'Authorization': result.data['token'],
              });
              Utils.replaceScreen(
                  context,
                  BlocProvider(
                    bloc: appBloc,
                    child: Home(),
                  ));
            }
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
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget buildVersionText() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      child: Text(
        'Version:' + Utils.appVersion,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
