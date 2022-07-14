import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newest_insurance/constants.dart';
import 'package:newest_insurance/services/database.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  Future<Map<String, dynamic>?> insuranceCompanyListDoc() async {
    return (await FirebaseFirestore.instance.collection('insurance-companies').
    doc("insurance-company-list").get()).data();
  }

  Future<Map<String, dynamic>?> brokerCompanyListDoc() async {
    return (await FirebaseFirestore.instance.collection('broker-companies').
    doc("broker-company-list").get()).data();
  }

  Future<Map<String, dynamic>?> serviceCenterListDoc() async {
    return (await FirebaseFirestore.instance.collection('service-centers').
    doc("service-center-list").get()).data();
  }


  String companyType = "Insurance Company";

  TextEditingController companyName = TextEditingController();
  TextEditingController defaultPremium = TextEditingController();
  TextEditingController coveringTypes = TextEditingController();
  TextEditingController additionalCoverages = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DataBaseService dataBaseService = DataBaseService();


  List<String> numbers = ['0','1','2','3','4','5','6','7','8','9',];

  bool isLetter(String currentLetter){
    int currentNumberIndex = 0;
    while(currentNumberIndex < numbers.length){
      if(numbers[currentNumberIndex] == currentLetter){
       return false;
      }
      currentNumberIndex++;
    }
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Center(
          child: Container(
            width: 1000,
            height: 1000,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 1000,
                  height: 800,
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Text("Company Type",style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: companyType == "Insurance Company"?mainColor:Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    companyType = "Insurance Company";
                                  });
                                },
                                child: Text("Insurance Company",style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                              width: 200,
                              height: 50,
                            ),
                            SizedBox(width: 10,),
                            Container(
                              decoration: BoxDecoration(
                                color: companyType == "Broker Company"?mainColor:Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    companyType = "Broker Company";
                                  });
                                },
                                child: Text("Broker Company",style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                              width: 200,
                              height: 50,
                            ),
                            SizedBox(width: 10,),
                            Container(
                              decoration: BoxDecoration(
                                color: companyType == "Service Center"?mainColor:Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    companyType = "Service Center";
                                  });
                                },
                                child: Text("Service Center",style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                              width: 200,
                              height: 50,
                            ),
                            SizedBox(width: 10,),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: TextField(
                            controller: companyName,
                            decoration: InputDecoration(
                              labelText: "Company Name",
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                            ),
                          ),
                        ),
                        companyType != "Insurance Company"?Container():Container(
                          margin: EdgeInsets.all(20),
                          child: TextField(
                            controller: defaultPremium,
                            decoration: InputDecoration(
                              labelText: "Default Premium",
                            ),
                          ),
                        ),
                        companyType == "Service Center"?Container():Container(
                          margin: EdgeInsets.all(20),
                          child: TextField(
                            controller: coveringTypes,
                            decoration: InputDecoration(
                              labelText: "Covering types (separate types by coma)",
                            ),
                          ),
                        ),
                        companyType == "Service Center"?Container():Container(
                          margin: EdgeInsets.all(20),
                          child: TextField(
                            controller: additionalCoverages,
                            decoration: InputDecoration(
                              labelText: "Additional Coverages (separate coverages by coma)",
                            ),
                          ),
                        ),


                        FutureBuilder(
                            future: companyType == "Insurance Company"?insuranceCompanyListDoc():
                            companyType == "Broker Company"?brokerCompanyListDoc():serviceCenterListDoc(),
                            builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                              if(snapshot.connectionState == ConnectionState.done){
                                if(snapshot.hasData){
                                  return Container(
                                    width: 250,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: () async {

                                        bool invalidInput = false;

                                        List<String> coverageTypesList = [];
                                        int coverageTypeIndex = 0;
                                        String currentCoverage = '';
                                        String coverageTypes = coveringTypes.text;

                                        while(coverageTypeIndex < coverageTypes.length){
                                          if(coverageTypes[coverageTypeIndex] == ','){
                                            coverageTypesList.add(currentCoverage);
                                            currentCoverage = '';
                                          }
                                          else if(!isLetter(coverageTypes[coverageTypeIndex])){
                                            print("The current character is: ${isLetter(coverageTypes[coverageTypeIndex])}");
                                            invalidInput = true;
                                            break;
                                          }
                                          else{
                                            currentCoverage += coverageTypes[coverageTypeIndex];
                                          }
                                          coverageTypeIndex++;
                                        }

                                        coverageTypesList.add(currentCoverage);

                                        List<String> additionalCoveragesList = [];
                                        int additionalCoverageIndex = 0;
                                        String currentAdditionalCoverage = '';
                                        String additionalCoveragesString = additionalCoverages.text;

                                        while(additionalCoverageIndex < additionalCoveragesString.length){
                                          if(additionalCoveragesString[additionalCoverageIndex] == ','){
                                            additionalCoveragesList.add(currentAdditionalCoverage);
                                            currentAdditionalCoverage = '';
                                          }
                                          else if(!isLetter(additionalCoveragesString[additionalCoverageIndex])){
                                            print("The current character is: ${isLetter(additionalCoveragesString[additionalCoverageIndex])}");
                                            invalidInput = true;
                                            break;
                                          }
                                          else{
                                            currentAdditionalCoverage += additionalCoveragesString[additionalCoverageIndex];
                                          }
                                          additionalCoverageIndex++;
                                        }

                                        additionalCoveragesList.add(currentAdditionalCoverage);


                                        int premiumIndex = 0;
                                        String premium = defaultPremium.text;

                                        while(premiumIndex < premium.length){
                                          if(isLetter(premium[premiumIndex])){
                                            invalidInput = true;
                                            break;
                                          }
                                          premiumIndex++;
                                        }

                                        if(!invalidInput){

                                          final newDoc = FirebaseFirestore.instance.collection(companyType == "Insurance Company"?"users-policy-requests":
                                          "users-policy-requests-broker").doc(companyName.text);

                                          final json = {
                                            'total-policy-amount' : -1,
                                            'total-new-requests' : 0,
                                            'total-amount-approved' : 0,
                                            'total-amount-renewal' : 0,
                                            'total-amount-cancelled' : 0,
                                            'total-pending-policies' : 0,
                                          };

                                          if(companyType != "Service Center"){
                                            await newDoc.set(json);
                                            await dataBaseService.addCompanyToClaims(companyType, companyName.text);
                                          }
                                          else{
                                            await dataBaseService.addServiceCenter(companyName.text);
                                          }

                                          await dataBaseService.addCompanyToComplains(companyName.text);

                                          await dataBaseService.signUpCompany(
                                            companyType,
                                            companyName.text,
                                            emailController.text,
                                            passwordController.text,
                                            defaultPremium.text,
                                            coverageTypesList,
                                            additionalCoveragesList,
                                            snapshot.data!['company-amount']+1,
                                          );
                                      }

                                      },
                                      child: Text("Sign Up",style: TextStyle(
                                        color: Colors.white,
                                      ),),
                                    ),
                                  );
                                }
                                else if(snapshot.hasError){
                                  return const Text("There is an error");
                                }
                              }

                              return const Text("");

                            },
                        ),





                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
