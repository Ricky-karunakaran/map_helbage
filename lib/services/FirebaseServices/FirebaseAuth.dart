import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:helbage/services/FirebaseServices/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
class FirebaseAuthService implements AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String getUID() {
    return _auth.currentUser!.uid;
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      User? user = result.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  Future signUp(String email,String password)async{
  try
  {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email:email,password:password);
    return true;
  }on FirebaseAuthException catch(e)
  {
    if (e.code=='weak-password'){
      return ('The password provided is too weak');
    }
    else if(e.code=='email-already-in-use')
    {
      return ('The account already exists for that email.');
    }
    
  }catch(e)
  {
    return e.toString();
  }
}

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
