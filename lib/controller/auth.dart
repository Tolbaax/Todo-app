import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/shared/components/constant.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  // Sign Up using email and password
  signUp(email, password, name) async {
    var user = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    fireStore.collection('users').doc(user.user!.uid).set(
      {
        'email': email,
        'id': user.user!.uid,
        'name': name,
      },
    );

    await auth.currentUser!.sendEmailVerification();
  }

  // Email & Password Sign In
  signIn(String email, String password) async {
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
          (value) => uId = auth.currentUser!.uid,
        );
  }

  // Reset Password
  forgotPassword(email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  // Sign In With Google
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    var user = await FirebaseAuth.instance.signInWithCredential(credential);

    await fireStore.collection('users').doc(user.user!.uid).set({
      'email': user.user!.email,
      'name': user.user!.displayName,
      'image': user.user!.photoURL,
    }).then(
      (value) => uId = user.user!.uid,
    );

    // Once signed in, return the UserCredential
    return user;
  }

  // Sign In With Facebook
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    var user = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);

    await fireStore.collection('users').doc(user.user!.uid).set({
      'email': user.user!.email,
      'image': user.user!.photoURL,
      'name': user.user!.displayName,
    }).then(
      (value) => uId = user.user!.uid,
    );

    // Once signed in, return the UserCredential
    return user;
  }

  // Sign Out >>> not complete <<<
  Future signOut() async {
    //Firebase SignOut
    await auth.signOut();

    //Google SignOut
    await GoogleSignIn().signOut();

    //Facebook SignOut
    await FacebookAuth.instance.logOut();
  }
}
