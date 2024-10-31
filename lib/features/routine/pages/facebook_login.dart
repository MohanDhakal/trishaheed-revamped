import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class FacebookLoginExample extends StatefulWidget {
  @override
  _FacebookLoginExampleState createState() => _FacebookLoginExampleState();
}

class _FacebookLoginExampleState extends State<FacebookLoginExample> {
  final FacebookLogin _facebookLogin = FacebookLogin(debug: true);

  FacebookUserProfile? _userProfile;
  String? _accessToken;
  String? imageUrl;

  Future<void> _loginWithFacebook() async {
    final result = await _facebookLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
    ]);

    switch (result.status) {
      case FacebookLoginStatus.success:
        // Successfully logged in
        final accessToken = result.accessToken!.token;
        final profile = await _facebookLogin.getUserProfile();
        imageUrl = await _facebookLogin.getProfileImageUrl(width: 200);

        setState(() {
          _userProfile = profile;
          _accessToken = accessToken;
        });
        break;

      case FacebookLoginStatus.cancel:
        // User canceled the login
        print("Facebook login canceled by user.");
        break;

      case FacebookLoginStatus.error:
        // Error occurred
        print("Facebook login error: ${result.error}");
        break;
    }
  }

  Future<void> _logoutFromFacebook() async {
    await _facebookLogin.logOut();
    setState(() {
      _userProfile = null;
      _accessToken = null;
    });
    print("Logged out from Facebook");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Facebook Login Example')),
        body: Center(
          child: _userProfile == null
              ? ElevatedButton(
                  onPressed: _loginWithFacebook,
                  child: Text('Login with Facebook'),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hello, ${_userProfile?.name}!'),
                    imageUrl != null ? Image.network(imageUrl!) : SizedBox(),
                    ElevatedButton(
                      onPressed: _logoutFromFacebook,
                      child: Text('Logout from Facebook'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
