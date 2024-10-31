import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLoginPage extends StatefulWidget {
  @override
  _SocialLoginPageState createState() => _SocialLoginPageState();
}

class _SocialLoginPageState extends State<SocialLoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  Future<void> _handleSignIn() async {
    try {
      final user = await _googleSignIn.signIn();
      setState(() {
        _user = user;
      });
      print("Signed in as ${_user?.displayName}");
    } catch (error) {
      print("Sign-in error: $error");
    }
  }

  Future<void> _handleSignOut() async {
    await _googleSignIn.signOut();
    setState(() {
      _user = null;
    });
    print("User signed out");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Google Sign-In Example')),
        body: Center(
          child: _user == null
              ? ElevatedButton(
                  onPressed: _handleSignIn,
                  child: Text('Sign in with Google'),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hello, ${_user?.displayName}!'),
                    Text('Email:, ${_user?.email}!'),
                    _user != null && _user!.photoUrl != null
                        ? Image.network('${_user?.photoUrl}')
                        : SizedBox(),
                    ElevatedButton(
                      onPressed: _handleSignOut,
                      child: Text('Sign Out'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
