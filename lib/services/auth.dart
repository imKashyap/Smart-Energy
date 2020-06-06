import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  final FirebaseUser user;
  const User({@required this.user});

  String get uid {
    return user.uid;
  }

  String get email {
    return user.email;
  }

  String get photoUrl {
    return user.photoUrl;
  }

  String get displayName {
    return user.displayName;
  }
}

abstract class AuthBase {
  Stream<User> getCurrentAuthState();
  Future<User> signInWithGoogle();
  Future<User> getCurrentUser();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  User _getUserFromFirebase(FirebaseUser user) {
    if (user == null) return null;
    return User(user: user);
  }

  @override
  Stream<User> getCurrentAuthState() {
    return _auth.onAuthStateChanged.map((user) => _getUserFromFirebase(user));
  }

  @override
  Future<User> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return _getUserFromFirebase(user);
  }

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthResult authResult = await _auth.signInWithCredential(
            GoogleAuthProvider.getCredential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));
        return _getUserFromFirebase(authResult.user);
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING GOOGLE AUTH TOKENS',
            message: 'Google auth tokens are missing');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED BY USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
  }
}
