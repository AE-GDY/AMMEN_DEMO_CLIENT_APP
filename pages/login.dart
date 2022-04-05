import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../services/database.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool secureText = true;
  String userName = "";
  String dateOfBirth = "";
  String iD = "";
  String email = "";
  String password = "";
  String nationality = "";
  String mobileNumber = "";
  String city = "";
  String carModel = "";
  String carType = "";
  String modelYear = "";
  String drivingLicense = "";

  bool leftSelected = false;
  var formKey = GlobalKey<FormState>();

  DataBaseService dataBaseService = DataBaseService();

  Future<Map<String, dynamic>?> usersSignedUpIndex() async {
    return (await FirebaseFirestore.instance.collection('users-signed-up').
    doc('users').get()).data();
  }

  Future<Map<String, dynamic>?> requestsDocBrokerPolicyRequestData() async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests').
    doc("requests").get()).data();
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            children: [
              TextButton(
                  onPressed: (){
                    setState(() {
                      signInAsRegulator = false;
                      signInAsBroker = false;
                      signInAsServiceOrWorkshop = false;
                    });
                  },
                child: Text(
                  'Insurance Company',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                 ),
              ),
              const SizedBox(width: 30,),
              TextButton(
                onPressed: (){
                  setState(() {
                    signInAsRegulator = true;
                    signInAsBroker = false;
                    signInAsServiceOrWorkshop = false;
                  });
                },
                child: Text(
                  'Regulator',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 30,),
              TextButton(
                onPressed: (){
                  setState(() {
                    signInAsRegulator = false;
                    signInAsBroker = true;
                    signInAsServiceOrWorkshop = false;
                  });
                },
                child: Text(
                  'Brokerage Company',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 30,),
              TextButton(
                onPressed: (){
                  setState(() {
                    signInAsRegulator = false;
                    signInAsBroker = false;
                    signInAsServiceOrWorkshop = true;
                  });
                },
                child: Text(
                  'Service Center/Workshop',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => email = value!),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: mainColor,
            ),
            labelText: 'E-mail'),
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => password = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Password',
        ),
      ),
    );
  }

  Widget _buildDateRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        //obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => dateOfBirth = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Date of Birth',
        ),
      ),
    );
  }

  Widget _buildIdRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => iD = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'National ID',
        ),
      ),
    );
  }

  Widget _buildDrivingLicenseRow(){
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => drivingLicense = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Driving License',
        ),
      ),
    );
  }

  Widget _buildCarTypeRow(){
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        // obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => carType = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Vehicle Make',
        ),
      ),
    );
  }

  Widget _buildModelYearRow(){
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        //  obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => modelYear = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Production Year',
        ),
      ),
    );
  }



  Widget _buildCityRow(){
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        //  obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => city = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'City',
        ),
      ),
    );
  }

  Widget _buildMobileRow(){
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        //    obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => mobileNumber = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Mobile',
        ),
      ),
    );
  }

  Widget _buildNameRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.text,
        //obscureText: true,
        validator: (value){
          if(value!.length < 4){
            return "Enter at least 4 characters";
          }
          else{
            return null;
          }
        },
        onSaved: (value) => setState(() => userName = value!),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: mainColor,
          ),
          labelText: 'Employee Name',
        ),
      ),
    );
  }

  Widget _buildForgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextButton(
          onPressed: () {},
          child: Text("Forgot Password"),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.5 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: FutureBuilder(
            future: usersSignedUpIndex(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done){
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('there is an error'),
                  );
                }
                else if(snapshot.hasData){
                  return RaisedButton(
                    elevation: 5.0,
                    color: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed: () async {


                      FocusScope.of(context).unfocus();
                      final isValid = formKey.currentState!.validate();
                      if(isValid){
                        formKey.currentState!.save();
                        setState(() {
                          if(!signInAsBroker && !signInAsRegulator && !signInAsServiceOrWorkshop){
                            currentInsuranceCompany = insComp!;
                            Navigator.pushNamed(context, '/home');
                          }
                          else if(signInAsBroker && !signInAsRegulator && !signInAsServiceOrWorkshop){
                            currentBrokerCompany = brokerComp!;
                            Navigator.pushNamed(context, '/home');
                          }
                          else if(signInAsRegulator && !signInAsBroker && !signInAsServiceOrWorkshop){
                            Navigator.pushNamed(context, '/home-regulator');
                          }
                          else if(!signInAsBroker && !signInAsRegulator && signInAsServiceOrWorkshop){
                            currentServiceOrWorkshop = serviceOrWorkshop!;
                            Navigator.pushNamed(context, '/service-center-dashboard');
                          }
                        });
                      }
                    },
                    child: Text(
                      "ابدأ الآن",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontSize: MediaQuery.of(context).size.height / 30,
                      ),
                    ),
                  );
                }
              }
              return const Text("Please wait");
            },

          ),
        )
      ],
    );
  }

  Widget _buildDropDownButton() {
    if(!signInAsRegulator&&!signInAsBroker&&!signInAsServiceOrWorkshop){
      //sign in as insurance company
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 1.5 * (MediaQuery.of(context).size.height / 20),
            width: 5 * (MediaQuery.of(context).size.width / 18),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black),
            ),
            child: DropdownButton<String>(
              value: insComp,
              items: insuranceCompanyList.map(buildMenuItem).toList(),
              onChanged: (value){
                setState(() {
                  insComp = value!;
                });
              },
            ),
          ),
        ],
      );
    }
    else if(!signInAsRegulator&&signInAsBroker&&!signInAsServiceOrWorkshop){
      //sign in as broker
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 1.5 * (MediaQuery.of(context).size.height / 20),
            width: 5 * (MediaQuery.of(context).size.width / 18),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black),
            ),
            child: DropdownButton<String>(
              value: brokerComp,
              items: brokerCompanyList.map(buildMenuItem).toList(),
              onChanged: (value){
                setState(() {
                  brokerComp = value!;
                });
              },
            ),
          ),
        ],
      );
    }
    else if(!signInAsRegulator&&!signInAsBroker&&signInAsServiceOrWorkshop){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 1.5 * (MediaQuery.of(context).size.height / 20),
            width: 5 * (MediaQuery.of(context).size.width / 18),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black),
            ),
            child: DropdownButton<String>(
              value: serviceOrWorkshop,
              items: serviceCentersAndWorkshopsList.map(buildMenuItem).toList(),
              onChanged: (value){
                setState(() {
                  serviceOrWorkshop = value!;
                });
              },
            ),
          ),
        ],
      );
    }
    else{
      return Container();
    }

  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          fontSize: MediaQuery.of(context).size.height / 30,
        ),
      ),
  );


  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 2,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20,),
                Container(
                  child: Text(
                    (signInAsRegulator&&!signInAsBroker)?"Regulator":(!signInAsRegulator&&signInAsBroker)?"Brokerage Company":
    (!signInAsRegulator&&!signInAsBroker && !signInAsServiceOrWorkshop)?"Insurance Company":"Service Center/Workshop",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                _buildDropDownButton(),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 30,
                        ),
                      ),
                    ),

                  ],
                ),
              //  _buildNameRow(),
               // _buildIdRow(),
               // _buildDateRow(),
                //   _buildCityRow(),
                _buildEmailRow(),
                _buildPasswordRow(),
               // _buildMobileRow(),
               // _buildDrivingLicenseRow(),
                // _buildCarTypeRow(),
                //  _buildModelYearRow(),
                _buildForgetPasswordButton(),
                SizedBox(height: 30,),
                _buildLoginButton(),

                //_buildOrRow(),
                // _buildSocialBtnRow(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: FlatButton(
            onPressed: () {},
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Dont have an account? ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height / 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'Sign Up',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: MediaQuery.of(context).size.height / 40,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          centerTitle: true,
          title: Container(
            width: globalWidth,
            height: globalHeight ,
            child: Image(
              image: AssetImage('assets/logofinal3.PNG'),
            ),
          ),
          actions: [

            /*
            FutureBuilder(
              future: requestsDocBrokerPolicyRequestData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError){
                    return const Text("There is an error");
                  }
                  else if(snapshot.hasData){
                    return IconButton(
                        onPressed: () async {

                          int idx = 0;
                          while(idx <= snapshot.data['total-policy-amount']){
                            if(snapshot.data['$idx']['vehicle-amount'] != 0){
                              int vehicleIdx = 0;
                              while(vehicleIdx < snapshot.data['$idx']['vehicle-amount']){
                                await dataBaseService.tempUpdateBrokerVehiclesMultiple(idx, vehicleIdx);
                                vehicleIdx++;
                              }
                            }
                            else{
                              await dataBaseService.tempUpdateBrokerVehicles(idx);
                            }
                            idx++;
                          }
                        },
                          icon: Icon(Icons.ten_k_sharp)
                      );
                  }
                }
                return const Text("Please wait");
              },

            ),
            */

          ],
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff2f3f7),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(30),
                        bottomRight: const Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    _buildLogo(),
                    _buildContainer(),
                    _buildSignUpBtn(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
