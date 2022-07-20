import 'package:flutter/material.dart';
import 'package:newest_insurance/constants.dart';
import 'package:newest_insurance/services/storage.dart';


class PolicyAttachments extends StatefulWidget {
  const PolicyAttachments({Key? key}) : super(key: key);

  @override
  _PolicyAttachmentsState createState() => _PolicyAttachmentsState();
}

class _PolicyAttachmentsState extends State<PolicyAttachments> {

  Storage _storage = Storage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Policy Attachments"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
          width: 1000,
          height: 1000,
          child: Column(
            children: [

              Text("National ID"),
              SizedBox(height: 10,),
              Container(
                width: 200,
                height: 200,
                child: FutureBuilder(
                  future: _storage.getImage('users-signed-up','$globalUserIndex/national-id'),
                  builder:  (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        return const Text("There is an error");
                      }
                      else if(snapshot.hasData){
                        return Container(
                            width: (globalUserIndex-1 == 0 || globalUserIndex-1 == 2)?70:(globalUserIndex-1 == 1)?80:100,
                            height: (globalUserIndex-1 == 0 || globalUserIndex-1 == 2)?70:(globalUserIndex-1 == 1)?80:100,
                            child: Image.network(snapshot.data, fit: BoxFit.cover,)
                        );
                      }
                    }
                    return const Text("Please wait");
                  },
                ),
              ),
              SizedBox(height: 20,),

              Text("Driver License"),
              SizedBox(height: 10,),
              Container(
                width: 200,
                height: 200,
                child: FutureBuilder(
                  future: _storage.getImage('users-signed-up','$globalUserIndex/vehicles/${globalPolicyVehicleIndexes[globalCurrentPolicyIndex]}/driving-license'),
                  builder:  (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        return const Text("There is an error");
                      }
                      else if(snapshot.hasData){
                        return Container(
                            width: (globalUserIndex-1 == 0 || globalUserIndex-1 == 2)?70:(globalUserIndex-1 == 1)?80:100,
                            height: (globalUserIndex-1 == 0 || globalUserIndex-1 == 2)?70:(globalUserIndex-1 == 1)?80:100,
                            child: Image.network(snapshot.data, fit: BoxFit.cover,)
                        );
                      }
                    }
                    return const Text("Please wait");
                  },
                ),
              ),
              SizedBox(height: 20,),

              Text("Vehicle License"),
              SizedBox(height: 10,),
              Container(
                width: 200,
                height: 200,
                child: FutureBuilder(
                  future: _storage.getImage('users-signed-up','$globalUserIndex/vehicles/${globalPolicyVehicleIndexes[globalCurrentPolicyIndex]}/vehicle-license'),
                  builder:  (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        return const Text("There is an error");
                      }
                      else if(snapshot.hasData){
                        return Container(
                            width: (globalUserIndex-1 == 0 || globalUserIndex-1 == 2)?70:(globalUserIndex-1 == 1)?80:100,
                            height: (globalUserIndex-1 == 0 || globalUserIndex-1 == 2)?70:(globalUserIndex-1 == 1)?80:100,
                            child: Image.network(snapshot.data, fit: BoxFit.cover,)
                        );
                      }
                    }
                    return const Text("Please wait");
                  },
                ),
              ),
              SizedBox(height: 20,),

              Text("Vehicle Attachments"),
              SizedBox(height: 10,),
              Container(
                width: 500,
                height: 150,
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      child: FutureBuilder(
                        future: _storage.getImage('insurance_companies','$currentInsuranceCompany/policy-requests/$globalCurrentPolicyIndex/vehicle-attachments/front'),
                        builder:  (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){
                              return Container(
                                  width: (globalUserIndex-1 == 0 || globalUserIndex-1 == 2)?70:(globalUserIndex-1 == 1)?80:100,
                                  height: (globalUserIndex-1 == 0 || globalUserIndex-1 == 2)?70:(globalUserIndex-1 == 1)?80:100,
                                  child: Image.network(snapshot.data, fit: BoxFit.cover,)
                              );
                            }
                          }
                          return const Text("Please wait");
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      child: FutureBuilder(
                        future: _storage.getImage('insurance_companies','$currentInsuranceCompany/policy-requests/$globalCurrentPolicyIndex/vehicle-attachments/back'),
                        builder:  (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){
                              return Container(
                                  width: (globalUserIndex-1 == 0 || globalUserIndex-1 == 2)?70:(globalUserIndex-1 == 1)?80:100,
                                  height: (globalUserIndex-1 == 0 || globalUserIndex-1 == 2)?70:(globalUserIndex-1 == 1)?80:100,
                                  child: Image.network(snapshot.data, fit: BoxFit.cover,)
                              );
                            }
                          }
                          return const Text("Please wait");
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      child: FutureBuilder(
                        future: _storage.getImage('insurance_companies','$currentInsuranceCompany/policy-requests/$globalCurrentPolicyIndex/vehicle-attachments/left'),
                        builder:  (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){
                              return Container(
                                  width: (globalUserIndex-1 == 0 || globalUserIndex-1 == 2)?70:(globalUserIndex-1 == 1)?80:100,
                                  height: (globalUserIndex-1 == 0 || globalUserIndex-1 == 2)?70:(globalUserIndex-1 == 1)?80:100,
                                  child: Image.network(snapshot.data, fit: BoxFit.cover,)
                              );
                            }
                          }
                          return const Text("Please wait");
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      child: FutureBuilder(
                        future: _storage.getImage('insurance_companies','$currentInsuranceCompany/policy-requests/$globalCurrentPolicyIndex/vehicle-attachments/right'),
                        builder:  (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){
                              return Container(
                                  width: (globalUserIndex-1 == 0 || globalUserIndex-1 == 2)?70:(globalUserIndex-1 == 1)?80:100,
                                  height: (globalUserIndex-1 == 0 || globalUserIndex-1 == 2)?70:(globalUserIndex-1 == 1)?80:100,
                                  child: Image.network(snapshot.data, fit: BoxFit.cover,)
                              );
                            }
                          }
                          return const Text("Please wait");
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      child: FutureBuilder(
                        future: _storage.getImage('insurance_companies','$currentInsuranceCompany/policy-requests/$globalCurrentPolicyIndex/vehicle-attachments/roof'),
                        builder:  (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){
                              return Container(
                                  width: (globalUserIndex-1 == 0 || globalUserIndex-1 == 2)?70:(globalUserIndex-1 == 1)?80:100,
                                  height: (globalUserIndex-1 == 0 || globalUserIndex-1 == 2)?70:(globalUserIndex-1 == 1)?80:100,
                                  child: Image.network(snapshot.data, fit: BoxFit.cover,)
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
              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
}
