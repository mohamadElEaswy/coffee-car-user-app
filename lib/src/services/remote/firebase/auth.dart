import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User? get currentUser;
  Stream<User?> authUserState();
  Future<User?> signInAnonymously();
  Future<User?> signInWithGoogle();
  // Future<User?> signInWithFacebook();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class Auth implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Stream<User?> authUserState() => _firebaseAuth.authStateChanges();
  @override
  User? get currentUser => _firebaseAuth.currentUser;
  @override
  Future<User?> signInAnonymously() async {
    final UserCredential userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken),
        );
        return userCredential.user;
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'missing google id token',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'sign in aborted by user',
      );
    }
  }

  // @override
  // Future<User?> signInWithFacebook() async {
  //   final fb = FacebookLogin();
  //   final response = await fb.logIn(permissions: [
  //     FacebookPermission.email,
  //     FacebookPermission.publicProfile
  //   ]);
  //   switch (response.status) {
  //     case FacebookLoginStatus.success:
  //       final accessToken = response.accessToken;
  //       final userCredential = await _firebaseAuth.signInWithCredential(
  //           FacebookAuthProvider.credential(accessToken!.token));
  //       return userCredential.user;
  //     case FacebookLoginStatus.cancel:
  //       throw FirebaseAuthException(
  //           code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
  //     case FacebookLoginStatus.error:
  //       throw FirebaseAuthException(
  //           code: 'ERROR_FACEBOOK_LOGIN_FAILED',
  //           message: response.error!.developerMessage);
  //     default: throw UnimplementedError();
  //   }
  // }

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password));
    return userCredential.user;
  }

  @override
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    // final facebookLogin = FacebookLogin();
    // await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}
