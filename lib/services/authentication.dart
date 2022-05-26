import 'package:firebase_auth/firebase_auth.dart';
import 'package:newest_insurance/models/insurance_company.dart';
import 'package:newest_insurance/models/user.dart';

class AuthService{

  final FirebaseAuth _authenticationService = FirebaseAuth.instance;

  // create user based on our model
  appUser? userObject(User user) {
    return user != null ? appUser(uid: user.uid) : null;
  }

  //sign in anonymously
  Future signInAnon() async {
    try{
      UserCredential result = await _authenticationService.signInAnonymously();
      User? user = result.user;
      return userObject(user!);
      //appUser? finalUser = userObject(user!);
      //return appUser;
    }
    catch(error){
        print(error.toString());
        return null;
    }
  }

  // sign out
  Future signOut() async{
    try{
      await _authenticationService.signOut();
    }
    catch(error){
      print(error.toString());
    }
  }


  //get user object stream
  Stream<appUser?> get users{
    return _authenticationService.authStateChanges().map((User? user)=>userObject(user!));
  }

  // create insurance company account based on our model
  insuranceCompany? insuranceCompanyObject(User user,String name, String uid, String email, String password) {
    return user != null ? insuranceCompany(name: name,uid: uid, companyEmail: email, password: password) : null;
  }


  // sign up with email and password
  Future signUpWithEmailAndPassword(String email, String password, String name) async {
    try{
      UserCredential result = await _authenticationService.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return insuranceCompanyObject(user!, user.uid,email, password, name);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }



}