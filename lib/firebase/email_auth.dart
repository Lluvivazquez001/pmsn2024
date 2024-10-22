import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {
  //vamos a tener la logica para: registrar y validar el usuario 
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<bool> createUser(String user, String email, String password) async {
    try {
      final credentials = await auth.createUserWithEmailAndPassword(email: email, password: password);
      credentials.user!.sendEmailVerification(); //al reigstrar nos mandara un correo

      return true;

    } catch (e) {
      print('Error al crear el usuario');
    }

    return false;
  }

  Future<bool> validateUser(String email, String password) async {
    try {
      final credentials = await auth.signInWithEmailAndPassword(email: email, password: password);
      if (credentials.user !.emailVerified) {
        return true;
      }

    } catch (e) {
       print('Error al crear el usuario');
    }
    return false;

  }
}