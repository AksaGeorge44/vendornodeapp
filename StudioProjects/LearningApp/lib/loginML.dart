
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginMLPage extends StatefulWidget {
  @override
  _LoginMLPageState createState() => _LoginMLPageState();
}

class _LoginMLPageState extends State<LoginMLPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Replace this with your Django server authentication endpoint
      const String apiUrl = 'http://192.168.0.106:8000/login_now/';

      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        // Authentication successful
        Navigator.pushReplacementNamed(context, '/predict_now');
      } else {
        // Authentication failed
        setState(() {
          _errorMessage = 'Invalid email or password';
        });
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        _errorMessage = 'An error occurred, please try again later';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: _isLoading ? CircularProgressIndicator() : Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
