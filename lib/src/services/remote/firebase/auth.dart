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
  Future<User?> createUserWithEmailAndPassword({required String email, required String password});
  // Future<User?> createUserWithPhoneAndPassword(String phone, String password);
  Future<void> signOut();
  Future<void> submitPhoneNumber({required String phoneNumber});
  Future<void> submitOTP(String otpCode);
}

class Auth implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Stream<User?> authUserState() => _firebaseAuth.authStateChanges();
  @override
  User? get currentUser => _firebaseAuth.currentUser;
  @override
  Future<User?> signInAnonymously() async {
    final UserCredential userCredential =
        await _firebaseAuth.signInAnonymously();
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
    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(
            EmailAuthProvider.credential(email: email, password: password));
    return userCredential.user;
  }

  @override
  Future<User?> createUserWithEmailAndPassword({required String email, required String password,}) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
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

  @override
  Future<void> submitPhoneNumber({required String phoneNumber}) async {
    return await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      timeout: const Duration(seconds: 30),
    );
  }


  void verificationCompleted(PhoneAuthCredential credential) async {
    // await _firebaseAuth.currentUser!.updateDisplayName(credential.userName);
    // await _firebaseAuth.currentUser!.linkWithCredential(credential);
    // await _firebaseAuth.currentUser!.updatePhoneNumber(credential);

    // await _firebaseAuth.currentUser!.reload();

    currentUser!.linkWithCredential(credential);
    // await _firebaseAuth.currentUser!.updateDisplayName(userName);
    // print('verification completed');
    // await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException e) async {
    if (e.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
    // print('verification Failed ${e.toString()}');
    //emit();
  }

  String verificationId = '';
  void codeSent(String verificationId, int? resendToken) async {
    this.verificationId == verificationId;

    //emit();
  }

  void codeAutoRetrievalTimeout(String verificationId) async {
    // print(' code auto retrieval timeout');
  }

  @override
  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
    // await setUserDetails(userName);
    // await _firebaseAuth.currentUser!.updatePhoneNumber(credential);
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await _firebaseAuth.signInWithCredential(credential);
      //emit();
    } catch (e) {
      // print(e.toString());
      //emit();
    }
  }



  User getUserdata() {
    User firebaseUser = _firebaseAuth.currentUser!;
    return firebaseUser;
  }
}
