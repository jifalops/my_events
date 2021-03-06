import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

export 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth get auth => FirebaseAuth.instance;

final _googleSignIn = GoogleSignIn(
  scopes: [
    // 'email',
    // 'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

Future<FirebaseUser> signInWithGoogle() async {
  try {
    final account = await _googleSignIn.signIn();
    if (account != null) {
      final gAuth = await account.authentication;
      if (gAuth != null) {
        final credential = GoogleAuthProvider.getCredential(
          idToken: gAuth.idToken,
          accessToken: gAuth.accessToken,
        );
        final result = await auth.signInWithCredential(credential);
        if (result?.user != null) {
          print('Google sign-in succeeded.');
          return result.user;
        }
      }
    }
  } catch (error) {
    print(error);
  }
  print('Sign in failed.');
  return null;
}

Future<void> signOut() async {
  await _googleSignIn.signOut();
  await auth.signOut();
}