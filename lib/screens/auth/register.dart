import 'package:crew_brew/services/Loading.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/services/authService.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
        title: Text('Sign up', style: TextStyle(color: Colors.white)),
        actions: [
          FloatingActionButton.extended(
            onPressed: () {
              widget.toggleView();
            },
            backgroundColor: Colors.black,
            label: Text('Sign in', style: TextStyle(color: Colors.white)),
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
                validator: (val) => val == null || val.length < 6
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

                      dynamic result = await _auth.RegisterWithEmailAndPass(email, password);

                      if (result == null) {
                        setState(() {
                          error = 'Please enter a valid email';
                          loading = false;
                        });
                      }
                    }
                  },
                  backgroundColor: Colors.black,
                  label: Text('Register', style: TextStyle(color: Colors.white)),
                  icon: Icon(Icons.person, color: Colors.white),
                ),
              ),
              SizedBox(height: 12),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}

