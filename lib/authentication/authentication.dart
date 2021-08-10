import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthImplementation{
  Future<String> SignIn(String email, String password);
  // ignore: non_constant_identifier_names
  Future<String> SignUp (String email, String password);
  Future<String> getCurrentUser();
  Future<void> signOut();
}

class Auth implements AuthImplementation{
  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> SignIn(String email, String password) async{
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

    final User user = userCredential.user!;

    return user.uid;
  }

  // ignore: non_constant_identifier_names
  Future<String> SignUp (email, password) async{
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    
    final User user = userCredential.user!;
    
    return user.uid;
  }

  Future<String> getCurrentUser() async {
    User user = await _firebaseAuth.currentUser!;
    return user.uid;
  }

  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

}