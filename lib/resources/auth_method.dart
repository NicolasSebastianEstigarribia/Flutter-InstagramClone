import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/resources/storage_mothod.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Obtener detalles de usuarios
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  // Registro de usuario
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Ocurrió algún error";
    try {
      // Regristrar usuario in auth con email y contraseña
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //Almacenar foto para esto tiene que estar creada la carpeta en storage firebase
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('profilePics', file, false);

      model.User user = model.User(
        username: username,
        uid: cred.user!.uid,
        photoUrl: photoUrl,
        email: email,
        bio: bio,
        followers: [],
        following: [],
      );

      // Agregar usuario en la base de datos
      await _firestore
          .collection("users")
          .doc(cred.user!.uid)
          .set(user.toJson());

      res = "exitoso";
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // Loguear con usuario
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Ocurrió algún error";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // Login con usuario y contraseña
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "exitoso";
      } else {
        res = "Por favor ingrese todos los campos";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
