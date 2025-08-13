import 'package:crew_brew/services/Loading.dart';
import 'package:crew_brew/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Sign In', style: TextStyle(color: Colors.white)),
        actions: [
          FloatingActionButton.extended(
            onPressed: () {
              widget.toggleView();
            },
            backgroundColor: Colors.black,
            label: Text('Register', style: TextStyle(color: Colors.white)),
            icon: Icon(Icons.person, color: Colors.white),
            elevation: 0,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(35),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: 'Email'),
                validator: (val) =>
                val == null || val.isEmpty || !val.contains('@')
                    ? 'Enter a valid email'
                    : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: 'Password'),
                obscureText: true,
                validator: (val) =>
                val == null || val.length < 6
                    ? 'Enter a password 6+ chars long'
                    : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);

                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                      if (result == null) {
                        setState(() {
                          error = 'Please enter a valid email';
                          loading = false;
                        });
                      }
                    }
                  },
                  backgroundColor: Colors.black,
                  label: Text('Sign in', style: TextStyle(color: Colors.white)),
                  icon: Icon(Icons.login, color: Colors.white),
                ),
              ),
              SizedBox(height: 12),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

