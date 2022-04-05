import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newest_insurance/companies/insurancecompanies.dart';
import 'package:newest_insurance/data/insurance_companies_data.dart';
import 'package:newest_insurance/widgets/bar_chart.dart';
import 'package:newest_insurance/widgets/future_builder.dart';

import '../constants.dart';

class InsuranceCompanyDashboard extends StatefulWidget {
  const InsuranceCompanyDashboard({Key? key}) : super(key: key);

  @override
  _InsuranceCompanyDashboardState createState() => _InsuranceCompanyDashboardState();
}

class _InsuranceCompanyDashboardState extends State<InsuranceCompanyDashboard> {

  List<Map> selectedComps = [];
  bool companySelected = false;
  Map currentlySelected = {};





  @override
  Widget build(BuildContext context) {

    Future<Map<String, dynamic>?> policyRequestData() async {
      return (await FirebaseFirestore.instance.collection('users-policy-requests').
      doc(currentInsuranceCompany).get()).data();
    }

    Future<Map<String, dynamic>?> brokerPolicyRequestData() async {
      return (await FirebaseFirestore.instance.collection('users-policy-requests-broker').
      doc(currentBrokerCompany).get()).data();
    }

    Future<Map<String, dynamic>?> claimRequestData() async {
      return (await FirebaseFirestore.instance.collection('users-claim-requests').
      doc("claims").get()).data();
    }

    Future<Map<String, dynamic>?> brokerClaimRequestData() async {
      return (await FirebaseFirestore.instance.collection('users-claim-requests-broker').
      doc("claims").get()).data();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(signInAsBroker?"${currentBrokerCompany} Dashboard":"${currentInsuranceCompany} Dashboard"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.notifications),
          ),
          TextButton(
            onPressed: (){
              Navigator.pushNamed(context, '/');
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.logout, color: Colors.white,),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height + 1000,
            child: Stack(
              children: [
                // FIRST
                Positioned(
                  left: 0,
                  //right: 0,
                  child: Container(
                    width: 210,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        ListTile(
                          leading: Icon(Icons.account_circle_rounded),
                          title: Text("Dashboard", style: TextStyle(
                            fontSize: 12,
                          ),),
                          onTap: (){
                            setState(() {
                              Navigator.pushNamed(context, '/home');
                            });
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.directions_car),
                          title: Text("Policies", style: TextStyle(
                            fontSize: 12,
                          ),),
                          onTap: (){
                            setState(() {
                              if(signInAsBroker){
                                Navigator.pushNamed(context, '/broker-page');
                              }
                              else{
                                Navigator.pushNamed(context, '/policies-page');
                              }

                            });
                          },
                        ),
                        claimsTile(signInAsBroker),
                        ListTile(
                          leading: Icon(Icons.account_circle_rounded),
                          title: Text("Complains", style: TextStyle(
                            fontSize: 12,
                          ),),
                          onTap: (){
                            setState(() {
                              Navigator.pushNamed(context, '/complains');
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),


                //SECOND
                Positioned(
                  left: 220,
                  child: Container(
                    height: 200,
                    width: 1000,
                    child: Row(
                      children: [
                        FutureBuilder(
                          future: signInAsBroker?brokerPolicyRequestData():policyRequestData(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if(snapshot.connectionState == ConnectionState.done){
                              if(snapshot.hasError){
                                return const Text("There is an error");
                              }
                              else if(snapshot.hasData){

                                int overallPolicies = snapshot.data['total-amount-approved']+
                                    snapshot.data['total-amount-cancelled']+
                                    snapshot.data['total-amount-renewal'];

                                return Expanded(
                                  child: InkWell(
                                    onTap: (){},
                                    child: Container(
                                      height: 170,
                                      //width: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 6),
                                              color: Colors.grey.withOpacity(.1),
                                              blurRadius: 12
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(child: Container(
                                                color: Colors.blue,
                                                height: 5,
                                              ))
                                            ],
                                          ),
                                          // Container(),
                                          RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: "Overall Policies\n",
                                                    style: TextStyle(
                                                        fontSize: 16, color: Colors.black)),
                                                TextSpan(
                                                    text: "$overallPolicies",
                                                    style:
                                                    TextStyle(fontSize: 40, color: Colors.black)),
                                              ])),
                                          //  Container(),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                            return const Text("");
                          },
                        ),
                        const SizedBox(width: 10,),

                        FutureBuilder(
                          future: signInAsBroker?brokerPolicyRequestData():policyRequestData(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if(snapshot.connectionState == ConnectionState.done){
                              if(snapshot.hasError){
                                return const Text("There is an error");
                              }
                              else if(snapshot.hasData){
                                return Expanded(
                                  child: InkWell(
                                    onTap: (){},
                                    child: Container(
                                      height: 170,
                                      //width: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 6),
                                              color: Colors.grey.withOpacity(.1),
                                              blurRadius: 12
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(child: Container(
                                                color: Colors.orange,
                                                height: 5,
                                              ))
                                            ],
                                          ),
                                          // Container(),
                                          RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: "New Requests\n",
                                                    style: TextStyle(
                                                        fontSize: 16, color: Colors.black)),
                                                TextSpan(
                                                    text: "${snapshot.data['total-new-requests']}",
                                                    style:
                                                    TextStyle(fontSize: 40, color: Colors.black)),
                                              ])),
                                          //  Container(),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                            return const Text("");
                          },

                        ),


                        const SizedBox(width: 10,),

                        FutureBuilder(
                          future: signInAsBroker?brokerPolicyRequestData():policyRequestData(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if(snapshot.connectionState == ConnectionState.done){
                              if(snapshot.hasError){
                                return const Text("There is an error");
                              }
                              else if(snapshot.hasData){
                                return Expanded(
                                  child: InkWell(
                                    onTap: (){},
                                    child: Container(
                                      height: 170,
                                      //width: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 6),
                                              color: Colors.grey.withOpacity(.1),
                                              blurRadius: 12
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(child: Container(
                                                color: Colors.red,
                                                height: 5,
                                              ))
                                            ],
                                          ),
                                          // Container(),
                                          RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: "Pending Policies\n",
                                                    style: TextStyle(
                                                        fontSize: 16, color: Colors.black)),
                                                TextSpan(
                                                    text: "${snapshot.data['total-pending-policies']}",
                                                    style:
                                                    TextStyle(fontSize: 40, color: Colors.black)),
                                              ])),
                                          //  Container(),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                            return const Text("");
                          },

                        ),
                        const SizedBox(width: 10,),
                        FutureBuilder(
                          future: signInAsBroker?brokerClaimRequestData():claimRequestData(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if(snapshot.connectionState == ConnectionState.done){
                              if(snapshot.hasError){
                                return const Text("There is an error");
                              }
                              else if(snapshot.hasData){
                                return Expanded(
                                  child: InkWell(
                                    onTap: (){},
                                    child: Container(
                                      height: 170,
                                      //width: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 6),
                                              color: Colors.grey.withOpacity(.1),
                                              blurRadius: 12
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(child: Container(
                                                color: Colors.green,
                                                height: 5,
                                              ))
                                            ],
                                          ),
                                          // Container(),
                                          RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: "Requested Claims\n",
                                                    style: TextStyle(
                                                        fontSize: 16, color: Colors.black)),
                                                TextSpan(
                                                    text: "${snapshot.data[signInAsBroker?currentBrokerCompany:currentInsuranceCompany]['total-claim-amount']+1}",
                                                    style:
                                                    TextStyle(fontSize: 40, color: Colors.black)),
                                              ])),
                                          //  Container(),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                            return const Text("");
                          },

                        ),
                        const SizedBox(width: 10,),


                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 230,
                  top: 180,
                  child: Container(
                    width: 1000,
                    height: 300,
                    child: BarChart(data: insuranceCompanies, title: signInAsBroker?"Overall Policies":"Overall Policies By Age", chartType: signInAsBroker?'overallPolicies':'byAge',),
                    ),
                ),
                Positioned(
                  left: 230,
                  top: 480,
                  child: Container(
                    width: 1000,
                    height: 300,
                    child: BarChart(data: insuranceCompanies, title: signInAsBroker?"New Requests":"New Requests by Age", chartType: signInAsBroker?'newRequests':'byAge',),
                  ),
                ),
                Positioned(
                  left: 230,
                  top: 780,
                  child: Container(
                    width: 1000,
                    height: 300,
                    child: BarChart(data: insuranceCompanies, title: signInAsBroker?"Pending Policies":"Pending Policies by Age", chartType: signInAsBroker?'pendingPolicies':'byAge',),
                  ),
                ),
                Positioned(
                  left: 230,
                  top: 1080,
                  child: Container(
                    width: 1000,
                    height: 300,
                    child: BarChart(data: insuranceCompanies, title: signInAsBroker?"Claim Requests": "Claim Requests by Age", chartType: signInAsBroker?'claimRequests':'byAge',),
                  ),
                ),

              ],
            ),
          ),
        ),
    );
  }

  Widget claimsTile(bool asBroker){
    if(asBroker){
      return Container();
    }
    else{
      return ListTile(
        leading: Icon(Icons.account_circle_rounded),
        title: Text("Claims", style: TextStyle(
          fontSize: 12,
        ),),
        onTap: (){
          setState(() {
            Navigator.pushNamed(context, '/claims-page');
          });
        },
      );
    }
  }

}


/*

*/