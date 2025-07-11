import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository {
  final auth = FirebaseAuth.instance;

  // HANDLE GOOGLE SIGN IN \\
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      return await auth.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // HANDLE SIGN OUT \\
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await auth.signOut();
  }
}
