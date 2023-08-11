import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:llm_trivia/utils/firebase_collection_names.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> checkIfUserIsLoggedIn() async {
    final User? user = _firebaseAuth.currentUser;
    print('User initial status ${user != null ? 'logged in' : 'logged out'}');
    if (user != null) {
      await user.reload();
      return (await _db
              .collection(FirebaseCollectionNames.usersCollection)
              .doc(user.uid)
              .get())
          .data()!;
    }
    return null;
  }

  Future<Map<String, dynamic>> signInAnonymously(String username) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInAnonymously();

      final String userId = userCredential.user!.uid;

      await userCredential.user!.updateDisplayName(username);

      await _db
          .collection(FirebaseCollectionNames.usersCollection)
          .doc(userId)
          .set({
        'id': userId,
        'username': username,
        'type': 'anonymous',
        'createdAt': FieldValue.serverTimestamp(),
      });

      return (await _db
              .collection(FirebaseCollectionNames.usersCollection)
              .doc(userId)
              .get())
          .data()!;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
