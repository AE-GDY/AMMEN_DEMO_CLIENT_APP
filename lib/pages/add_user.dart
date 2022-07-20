import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newest_insurance/constants.dart';
import 'package:newest_insurance/services/database.dart';


class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  DataBaseService dataBaseService = DataBaseService();


  // PERMISSIONS

  // scheduling permissions
  bool schedulingViewable = false;
  bool schedulingEditable = false;

  // inspection permissions
  bool inspectionViewable = false;
  bool inspectionEditable = false;

  // underwriting permissions
  bool underwritingViewable = false;
  bool underwritingEditable = false;

  // complete request permissions
  bool completeRequestViewable = false;
  bool completeRequestEditable = false;

  Future<Map<String, dynamic>?> insuranceCompaniesSignedUp() async {
    return (await FirebaseFirestore.instance.collection('insurance-companies').
    doc('insurance-company-list').get()).data();
  }

  Future<Map<String, dynamic>?> serviceCentersSignedUp() async {
    return (await FirebaseFirestore.instance.collection('service-centers').
    doc('service-center-list').get()).data();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            width: 800,
            height: 1200,
            child: Card(
              elevation: 3.0,
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text("User Information",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: roleController,
                      decoration: InputDecoration(
                        labelText: "Role (Admin, Scheduler, Inspector, Underwriter)",
                      ),
                    ),

                    SizedBox(height: 30,),
                    Text("Permissions",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(height: 20,),
                    permissionButton("Scheduling Viewable","Can view scheduling status and information", schedulingViewable,'sv'),
                    SizedBox(height: 20,),
                    permissionButton("Scheduling Editable","Can edit scheduling activities", schedulingEditable,'se'),
                    SizedBox(height: 20,),
                    permissionButton("Inspection Viewable","Can view inspection status and information", inspectionViewable,'iv'),
                    SizedBox(height: 20,),
                    permissionButton("Inspection Editable","Can edit inspection related activities", inspectionEditable,'ie'),
                    SizedBox(height: 20,),
                    permissionButton("Underwriting Viewable","Can view underwriting status and information", underwritingViewable,'uv'),
                    SizedBox(height: 20,),
                    permissionButton("Underwriting Editable","Can edit underwriting related activities", underwritingEditable,'ue'),
                    SizedBox(height: 20,),
                    permissionButton("Request Completion Viewable","Can view policy and claim request completion status", completeRequestViewable,'cv'),
                    SizedBox(height: 20,),
                    permissionButton("Request Completion Editable","Can edit policy and claim request completion related activities", completeRequestEditable,'ce'),
                    SizedBox(height: 50,),
                    Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FutureBuilder(
                        future: signInAsServiceOrWorkshop?serviceCentersSignedUp():insuranceCompaniesSignedUp(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){
                              return TextButton(
                                onPressed: () async {

                                  await dataBaseService.addUser(
                                      globalCurrentCompanyIndex,
                                      snapshot.data['$globalCurrentCompanyIndex']['user-amount'],
                                      signInAsServiceOrWorkshop,
                                      emailController.text,
                                      passwordController.text,
                                      roleController.text,
                                      schedulingViewable,
                                      schedulingEditable,
                                      inspectionViewable,
                                      inspectionEditable,
                                      underwritingViewable,
                                      underwritingEditable,
                                      completeRequestViewable,
                                      completeRequestEditable
                                  );

                                  Navigator.pushNamed(context, '/management');

                                },
                                child: Text("Add User",style: TextStyle(
                                  color: Colors.white,
                                ),),
                              );
                            }
                          }
                          return const Text("Please wait");
                        },

                      ),
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget permissionButton(String permissionType, String permissionInfo ,bool permissionAccess, String type){
    return Row(
      children: [
        Container(
          width: 230,
          height: 50,
          decoration: BoxDecoration(
            color: permissionAccess?Colors.green:Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: (){
              if(permissionAccess){
                if(type == 'sv'){
                  setState(() {
                    schedulingViewable = false;
                  });
                }
                else if(type == 'se'){
                  setState(() {
                    schedulingEditable = false;
                  });
                }
                else if(type == 'iv'){
                  setState(() {
                    inspectionViewable = false;
                  });
                }
                else if(type == 'ie'){
                  setState(() {
                    inspectionEditable = false;
                  });
                }
                else if(type == 'uv'){
                  setState(() {
                    underwritingViewable = false;
                  });
                }
                else if(type == 'ue'){
                  setState(() {
                    underwritingEditable = false;
                  });
                }
                else if(type == 'cv'){
                  setState(() {
                    completeRequestViewable = false;
                  });
                }
                else if(type == 'ce'){
                  setState(() {
                    completeRequestEditable = false;
                  });
                }
              }
              else{
                if(type == 'sv'){
                  setState(() {
                    schedulingViewable = true;
                  });
                }
                else if(type == 'se'){
                  setState(() {
                    schedulingEditable = true;
                  });
                }
                else if(type == 'iv'){
                  setState(() {
                    inspectionViewable = true;
                  });
                }
                else if(type == 'ie'){
                  setState(() {
                    inspectionEditable = true;
                  });
                }
                else if(type == 'uv'){
                  setState(() {
                    underwritingViewable = true;
                  });
                }
                else if(type == 'ue'){
                  setState(() {
                    underwritingEditable = true;
                  });
                }
                else if(type == 'cv'){
                  setState(() {
                    completeRequestViewable = true;
                  });
                }
                else if(type == 'ce'){
                  setState(() {
                    completeRequestEditable = true;
                  });
                }
              }
            },
            child: Text(permissionType,style: TextStyle(
              color: Colors.white,
            ),),
          ),
        ),
        SizedBox(width: 10,),
        Text(permissionInfo, style: TextStyle(
          fontSize: 16,
        ),),
      ],
    );
  }


}
