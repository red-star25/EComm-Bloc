import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/data/repository/app_repository.dart';
import 'package:ecomm/data/sharedprefs/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final userDocumentRef = FirebaseFirestore.instance.collection('users');
  final AppRepository appRepository = AppRepository();

  Future<void> signUp({
    required String email,
    required String password,
    String? userName,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((data) async {
        await createNewUser(data, userName);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCred.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<String?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((userCredential) async {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await createNewUser(userCredential, userCredential.user?.displayName);
        } else {
          return userCredential.user?.uid;
        }
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> createNewUser(
    UserCredential userCredential, [
    String? userName,
  ]) async {
    final userData = {
      'uid': userCredential.user?.uid,
      'email': userCredential.user?.email,
      'userName': userCredential.user?.displayName ?? userName,
    };
    try {
      await userDocumentRef.doc(userCredential.user!.uid).set(userData);
      final _prefs = await SharedPreferences.getInstance();
      final uId = userCredential.user?.uid;
      await _prefs.setString(Preferences.user_id, uId!);
      appRepository.setUserId = uId;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
