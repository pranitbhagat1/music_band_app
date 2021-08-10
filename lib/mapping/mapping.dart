import 'package:flutter/material.dart';
import 'package:music_band_app/screens/login_register.dart';
import 'package:music_band_app/screens/homepage.dart';
import 'package:music_band_app/authentication/authentication.dart';

class Mapping extends StatefulWidget {

  final AuthImplementation auth;
  
  Mapping
  ({
    required this.auth,
    });

  @override
  _MappingState createState() => _MappingState();
}


enum AuthStatus{
  notSignedIn,
  signedIn,
}

class _MappingState extends State<Mapping> {

  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.auth.getCurrentUser().then((firebaseUserId)
    {
      setState(() {
        authStatus = firebaseUserId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn()
  {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut()
  {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }


  @override
  Widget build(BuildContext context) {
    switch(authStatus)
    {
      case AuthStatus.notSignedIn :
      return new LoginAndRegister(
        auth: widget.auth,
        onSignedIn: _signedIn,
      );

      case AuthStatus.signedIn :
      return new HomePage(
        auth: widget.auth,
        onSignedOut: _signedOut,
      );

    }

    // ignore: dead_code
    // return null;
  }
}