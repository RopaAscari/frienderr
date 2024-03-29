import '../../../../core/enums/enums.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frienderr/core/constants/constants.dart';
import 'package:frienderr/core/exceptions/exceptions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:frienderr/features/data/models/auth/auth_model.dart';
import 'package:frienderr/features/data/models/user/user_model.dart';
import 'package:frienderr/core/enums/collections/users/query_fields.dart';

@LazySingleton(as: IAuthRemoteDataProvider)
class AuthRemoteDataProvider implements IAuthRemoteDataProvider {
  final FirebaseAuth authInstance;
  final FirebaseMessaging messagingInstance;
  final FirebaseFirestore firestoreInstance;

  const AuthRemoteDataProvider(
      this.authInstance, this.firestoreInstance, this.messagingInstance);

  @override
  Future<AuthResponse> recoverPassword({required String email}) async {
    try {
      await authInstance.sendPasswordResetEmail(email: email);

      return const AuthResponse(user: null, hasError: false, error: null);
    } on FirebaseAuthException catch (e) {
      return AuthResponse(user: null, hasError: true, error: e.toString());
    }
  }

  @override
  Future<AuthResponse> createUserAccount(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String id = userCredential.user!.uid;

      final UserModel user = UserModel(
          id: id,
          email: '',
          username: '',
          deviceToken: await messagingInstance.getToken());

      await firestoreInstance
          .collection(Collections.users)
          .doc(id)
          .set(user.toJson());

      return AuthResponse(user: user, hasError: false, error: null);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          return AuthResponse(
              user: null, hasError: true, error: Errors.signUpPassword);
        case 'email-already-in-use':
          return AuthResponse(
              user: null, hasError: true, error: Errors.signUpEmail);
        default:
          return AuthResponse(
              user: null, hasError: true, error: Errors.generic);
      }
    }
  }

  @override
  Future<AuthResponse> authenticateUser({
    required String password,
    required String email,
  }) async {
    try {
      final userCredential = await authInstance.signInWithEmailAndPassword(
          email: email, password: password);

      final QuerySnapshot authenticatedUser = await firestoreInstance
          .collection(Collections.users)
          .where(UserQueryFields.id.name, isEqualTo: userCredential.user?.uid)
          .limit(1)
          .get();

      final QueryDocumentSnapshot<Object?> authUser =
          authenticatedUser.docs.toList()[0];

      final UserModel user =
          UserModel.fromJson(authUser.data() as Map<String, dynamic>);

      return AuthResponse(user: user, hasError: false, error: null);
    } on FirebaseAuthException catch (e) {
      return AuthResponse(user: null, hasError: true, error: Errors.login);
    }
  }

  @override
  Future<bool> verfyAndUpdateUsername(String userId, String username) async {
    try {
      final QuerySnapshot data = await firestoreInstance
          .collection(Collections.users)
          .where(UserQueryFields.username.name, isEqualTo: username)
          .limit(1)
          .get();

      if (data.docs.toList().isEmpty) {
        await firestoreInstance
            .collection(Collections.users)
            .doc(userId)
            .update({'username': username});
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await authInstance.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  @override
  Future<dynamic> isAuthenticated() async {
    return authInstance.currentUser?.uid != null;
  }

  @override
  Future<bool> isUsernameSelected() async {
    final DocumentSnapshot<Object?> user = await firestoreInstance
        .collection(Collections.users)
        .doc(authInstance.currentUser?.uid)
        .get();
    return user['username'] != '';
  }

  @override
  Future<String> getUserId() async {
    return authInstance.currentUser?.uid as String;
  }
}

abstract class IAuthRemoteDataProvider {
  Future<String> getUserId();

  Future<dynamic> isAuthenticated();

  Future<bool> isUsernameSelected();

  Future<AuthResponse> recoverPassword({required String email});

  Future<bool> signOut();

  Future<bool> verfyAndUpdateUsername(String userId, String username);

  Future<AuthResponse> authenticateUser(
      {required String email, required String password});

  Future<AuthResponse> createUserAccount(
      {required String email, required String password});
}
