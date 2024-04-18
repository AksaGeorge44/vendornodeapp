import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            if (_error != null) Text(_error!, style: TextStyle(color: Colors.red)),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                if (_newPasswordController.text == _confirmPasswordController.text) {
                  try {
                    await _auth.currentUser!.updatePassword(_newPasswordController.text);
                    Navigator.pop(context);
                  } catch (e) {
                    setState(() {
                      _error = 'Failed to reset password: $e';
                    });
                  }
                } else {
                  setState(() {
                    _error = 'Passwords do not match';
                  });
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );

  }
}
