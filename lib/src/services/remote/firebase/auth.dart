import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mk/src/core/model/user_details_model/user_details_model.dart';
import 'package:mk/src/ui/pages/home/home_page.dart';
import '../../../core/navigation/navigation_methods.dart';
import '../../../ui/pages/otp_page/phone_page.dart';
import 'database.dart';

abstract class AuthBase {
  User? get currentUser;
  Stream<User?> authUserState();
  Future<User?> signInWithGoogle(context);
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String phoneNumber,
    required String userName,
    // required String city,
    // required String userType,
  });
  // Database? firebaseFirestore;
  Future<void> signOut();
  Future<void> submitPhoneNumber({required String phoneNumber});
  Future<void> submitOTP(String otpCode);
}

class Auth implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // @override
  Database? firebaseFirestore = FirestoreDatabase();
  @override
  Stream<User?> authUserState() => _firebaseAuth.authStateChanges();
  @override
  User? get currentUser => _firebaseAuth.currentUser;

  UserDetails? _userDetailsModel;
  late bool isNewGoogleUser;
  @override
  Future<User?> signInWithGoogle(context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final UserCredential userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        ));

        print(userCredential.user!.uid);

        bool isNewUser = userCredential.additionalUserInfo!.isNewUser;
        isNewGoogleUser = isNewUser;
        if (isNewUser) {
          _userDetailsModel = UserDetails(
            uId: userCredential.user!.uid,
            userName: userCredential.user!.displayName!,
            phoneNumber: '',
            email: userCredential.user!.email!,
            city: 'city',
            userType: 'userType',
            joinDate: DateTime.now(),
          );
          print('new user');
          RouteMethods.navigateTo(context: context, routeName: PhonePage.route);
        } else {
          print('old user');
          RouteMethods.navigateTo(context: context, routeName: Home.route);
        }
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

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(
            EmailAuthProvider.credential(email: email, password: password));
    firebaseFirestore!.getUser(userCredential.user!.uid);
    return userCredential.user;
  }

  @override
  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String phoneNumber,
    required String userName,
    // required String city,
    // required String userType,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    firebaseFirestore!.addUser(
      uid: userCredential.user!.uid,
      email: email,
      phoneNumber: phoneNumber,
      userName: userName,
      city: 'city',
      userType: 'not defined yet',
    );
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

  String? userPhoneNumber;
  @override
  Future<void> submitPhoneNumber({required String phoneNumber}) async{
    userPhoneNumber = phoneNumber;
    await firebaseFirestore!
        .addUser(
          uid: _userDetailsModel!.uId,
          email: _userDetailsModel!.email,
          phoneNumber: phoneNumber,
          userName: _userDetailsModel!.userName,
          city: _userDetailsModel!.city,
          userType: _userDetailsModel!.userType,
        )
        .then((value) async => await _firebaseAuth.verifyPhoneNumber(
              phoneNumber: '+2$phoneNumber',
              verificationCompleted: verificationCompleted,
              verificationFailed: verificationFailed,
              codeSent: codeSent,
              codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
              timeout: const Duration(seconds: 40),
            ));
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print(credential.signInMethod);
    // firebaseFirestore!.addUser(
    //   uid: currentUser!.uid,
    //   email: currentUser!.email!,
    //   phoneNumber:
    //       // userCredential.user!.phoneNumber == null
    //       //     ? ''
    //       //     :
    //       currentUser!.phoneNumber ?? userPhoneNumber!,
    //   userName: currentUser!.displayName!,
    //   city: 'city',
    //   userType: 'not defined yet',
    // );

    // firebaseFirestore!.getUser(currentUser!.uid);
    currentUser!.linkWithCredential(credential);
  }

  void verificationFailed(FirebaseAuthException e) async {
    if (e.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
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

  // User getUserdata() {
  //   User firebaseUser = _firebaseAuth.currentUser!;
  //   return firebaseUser;
  // }
}
