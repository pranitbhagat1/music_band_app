import 'package:flutter/material.dart';
import 'package:music_band_app/authentication/authentication.dart';

class LoginAndRegister extends StatefulWidget {
  LoginAndRegister({
    required this.auth,
    required this.onSignedIn,
  });

  final AuthImplementation auth;

  final VoidCallback onSignedIn;

  @override
  _LoginAndRegisterState createState() => _LoginAndRegisterState();
}

enum FormType { login, register }

class _LoginAndRegisterState extends State<LoginAndRegister> {
  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;

  String _email = "";
  String _password = "";

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId = await widget.auth.SignIn(_email, _password);
          print("Login userId = " + userId);
        } else {
          String userId = await widget.auth.SignUp(_email, _password);
          print("Login userId = " + userId);
        }

        widget.onSignedIn();
      } catch (e) {
        print("Error = " + e.toString());
      }
    }
  }

  void moveToLogin() {
    formKey.currentState!.reset();

    setState(() {
      _formType = FormType.login;
    });
  }

  void moveToRegister() {
    formKey.currentState!.reset();

    setState(() {
      _formType = FormType.register;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.all(15.0),
        child: new Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: createLogo() + createInput() + createButtons(),
            )),
      ),
    );
  }

  List<Widget> createLogo() {
    if (_formType == FormType.login) {
      return [
        Container(
      height: 120.0,
      width: 120.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'images/login.png'),
          fit: BoxFit.scaleDown,
        ),
        shape: BoxShape.circle,
      ),
    )
      ];
    } else {
      return [
        Container(
      height: 120.0,
      width: 120.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'images/signup.png'),
          fit: BoxFit.scaleDown,
        ),
        shape: BoxShape.circle,
      ),
    )
      ];
    }
  }

  List<Widget> createInput() {
    return [
      SizedBox(
        height: 30.0,
      ),
      new TextFormField(
        decoration: InputDecoration(
          labelText: "Email",
          contentPadding: const EdgeInsets.all(8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (value) => value!.isEmpty ? "Email is required" : null,
        onSaved: (value) => _email = value!,
      ),
      SizedBox(
        height: 10.0,
      ),
      new TextFormField(
        decoration: InputDecoration(
          labelText: "Password",
          contentPadding: const EdgeInsets.all(8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        obscureText: true,
        validator: (value) => value!.isEmpty ? "Password is required" : null,
        onSaved: (value) => _password = value!,
      ),
      SizedBox(
        height: 10.0,
      ),
    ];
  }

  List<Widget> createButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
            child: Text(
              "Login",
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: validateAndSubmit),
        FlatButton(
            child: Text("Create Account"),
            textColor: Colors.deepPurple[900],
            onPressed: moveToRegister)
      ];
    } else {
      return [
        RaisedButton(
            child: Text(
              "Register",
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: validateAndSubmit),
        FlatButton(
          child: Text("Login"),
          textColor: Colors.deepPurple[900],
          onPressed: moveToLogin,
        )
      ];
    }
  }
}
