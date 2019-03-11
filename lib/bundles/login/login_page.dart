import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/agent/agent.dart';
import 'package:flutter_user_agent/flutter_user_agent.dart';
import 'package:inventory_management/bundles/agent/api.dart';
import 'package:inventory_management/bundles/bloc/bloc_provider.dart';
import 'package:inventory_management/bundles/common/utils.dart';
import 'package:inventory_management/bundles/home/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = '';
  String _password = '';
  // Platform messages are asynchronous, so we initialize in an async method.
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Future<void> initUserAgentState() async {
    String userAgent, hostUri, linkWord;
    try {
      //获取userAgent 添加到请求代理类中
      userAgent = await FlutterUserAgent.getPropertyAsync('userAgent');
      httpUtil.commonHeader.addAll({'User-Agent': userAgent});
      //拿到缓存对象 设置对应的hostUri 和linkWord
      Map<String, dynamic> localCache = await Utils.getLoaclCache();
      print(localCache);
      hostUri =
          Utils.hostUri = localCache[Utils.cacheKeyForHostUrl] ?? Utils.hostUri;
      linkWord = Utils.linkWord = localCache[Utils.cacheKeyForlinkWord] ?? '';
    } on Exception {
      // userAgent = webViewUserAgent = '<error>';
    }
  }

  @override
  void initState() {
    super.initState();
    initUserAgentState().then((data) {
      if (mounted) {
        setState(() {});
      }
    });
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
      // onChanged: loginBloc.accountOnchange,
      textCapitalization: TextCapitalization.words,
      validator: (text) {
        return text.isEmpty ? 'account is invalid' : null;
      },
      onSaved: (text) {
        _username = text;
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
      textCapitalization: TextCapitalization.words,
      obscureText: true,
      validator: (text) {
        return text.isEmpty ? 'password is invalid' : null;
      },
      onSaved: (text) {
        _password = text;
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
          Utils.cacheKeyForlinkWord: text,
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
                  username: _username,
                  password: _password,
                  linkWord: Utils.linkWord);
              if (result.isError()) {
                return;
              }

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
        'Version:1.0.0',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
