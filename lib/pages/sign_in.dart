import 'package:flutter/material.dart';
import 'package:newest_insurance/services/authentication.dart';
import 'package:newest_insurance/services/database.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();
  String companyEmail = '';
  String companyID = '';
  String companyPassword = '';
  String error = '';
  final formKey = GlobalKey<FormState>();

  DataBaseService dataBaseService = DataBaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        centerTitle: true,
        actions: [
          TextButton.icon(
              onPressed: () async {
                await _authService.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("logout"),
          ),
        ],
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                validator: (val) => val!.isEmpty? 'Enter an ID':null,
                onChanged: (val){
                  setState(() {
                    companyID = val;
                  });
                },

              ),
              SizedBox(height: 20,),
              TextFormField(
                validator: (val) => val!.isEmpty? 'Enter an email':null,
                onChanged: (val){
                  setState(() {
                    companyEmail = val;
                  });
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                validator: (val) => val!.isEmpty? 'Enter an email':null,
                onChanged: (val){
                  setState(() {
                    companyPassword = val;
                  });
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white,),
                ),
                onPressed: () async{
                  print("clicked");
                 // dataBaseService.updateCollection('30kg', '180cm');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
