import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/bundles/auth/reset_password.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Setting'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Reset Password'),
            trailing: Icon(FontAwesomeIcons.key),
            onTap: () => _resetPassword(context),
          ),
          ListTile(
            title: Text('Clean Cache'),
            trailing: Icon(FontAwesomeIcons.trash),
            onTap: () => _cleanCache(context),
          ),
          _buildSeparator(),
          ListTile(
            title: Text('Sign Out'),
            trailing: Icon(FontAwesomeIcons.signOutAlt),
            onTap: () => _signOut(context),
          ),
          _buildSeparator(),
          ListTile(
            title: Text('Verson: 1.0.0'),
          ),
        ],
      ),
    );
  }

  Container _buildSeparator() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200])),
      ),
    );
  }

  void _resetPassword(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => ResetPassword()));
  }

  void _cleanCache(BuildContext context) {
    // Todo
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Cache has been cleaned.'),
      duration: Duration(seconds: 1),
    ));
  }

  void _signOut(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Confirm sign out?"),
            // content: Text("Alert Dialog body"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Sign out"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
