import 'package:flutter/material.dart';
import 'package:music_band_app/appdrawer.dart';
import 'package:music_band_app/authentication/authentication.dart';

class HomePage extends StatefulWidget {
  HomePage({
    required this.auth,
    required this.onSignedOut,
  });

  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _signOut() async {
    try{
      await widget.auth.signOut();
      widget.onSignedOut();
    }
    catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: new Text("Music Bands",
        textAlign: TextAlign.center,
        ),
      ),
      
      body: Container(),

      bottomNavigationBar: BottomAppBar(
        color: Colors.amberAccent,
        child: new Container(
          child: IconButton(
            onPressed: _signOut, 
            icon: Icon(Icons.logout),
            iconSize: 30.0,
            color: Colors.white,
            ),
        ),
      ),
    );
  }
}
