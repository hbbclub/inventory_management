import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Old Password', labelText: 'Password'),
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'New Password', labelText: 'New Password'),
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'New Password', labelText: 'New Password'),
            ),
            Container(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                _savePassword(context);
              },
              child: Text('Save'),
            )
          ],
        ),
      ),
    );
  }

  void _savePassword(BuildContext context) {
    Navigator.of(context).pop();
  }
}
