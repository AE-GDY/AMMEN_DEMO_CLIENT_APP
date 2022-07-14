import 'package:flutter/material.dart';
import 'package:newest_insurance/constants.dart';

class VehiclesRequested extends StatefulWidget {
  const VehiclesRequested({Key? key}) : super(key: key);

  @override
  _VehiclesRequestedState createState() => _VehiclesRequestedState();
}

class _VehiclesRequestedState extends State<VehiclesRequested> {
  @override
  Widget build(BuildContext context) {

    print("vehicle amount: $globalVehiclesRequested");

    return Scaffold(
      appBar: AppBar(
        title: Text("Policy Request Vehicles"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Center(
          child: Container(
            width: 500,
            height: 2000,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Vehicles Requested", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 20,),
                Expanded(
                  child:ListView.builder(
                      itemCount: globalVehiclesRequested[globalCurrentPolicyIndex].length,
                      itemBuilder: (context,index){
                        return Container(
                          height: 320,
                          margin: EdgeInsets.all(20),
                          child: Card(
                            elevation: 10.0,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Vehicle Make", style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 5,),
                                  Text(globalVehiclesRequested[globalCurrentPolicyIndex][index].vehicleMake, style: TextStyle(
                                    fontSize: 18,
                                  ),),
                                  SizedBox(height: 10,),
                                  Text("Vehicle Model", style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 5,),
                                  Text(globalVehiclesRequested[globalCurrentPolicyIndex][index].vehicleModel, style: TextStyle(
                                    fontSize: 18,
                                  ),),
                                  SizedBox(height: 10,),
                                  Text("Production Year", style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 5,),
                                  Text(globalVehiclesRequested[globalCurrentPolicyIndex][index].productionYear, style: TextStyle(
                                    fontSize: 18,
                                  ),),
                                  SizedBox(height: 10,),
                                  Text("Plate Number", style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 5,),
                                  Text(globalVehiclesRequested[globalCurrentPolicyIndex][index].vehiclePlateNumber, style: TextStyle(
                                    fontSize: 18,
                                  ),),
                                  SizedBox(height: 10,),
                                  buildExtraInfo(index),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget buildExtraInfo(int index){
    if(globalVehiclesRequested[globalCurrentPolicyIndex][index].vehicleType == 'bus'){
      return Column(
        children: [
          Text("Number of seats", style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 5,),
          Text(globalVehiclesRequested[globalCurrentPolicyIndex][index].vehicleNumberOfSeats, style: TextStyle(
            fontSize: 18,
          ),),
          SizedBox(height: 10,),
        ],
      );
    }
    else if(globalVehiclesRequested[globalCurrentPolicyIndex][index].vehicleType == 'truck'){
      return Column(
        children: [
          Text("Vehicle weight", style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 5,),
          Text(globalVehiclesRequested[globalCurrentPolicyIndex][index].vehicleWeight, style: TextStyle(
            fontSize: 18,
          ),),
          SizedBox(height: 10,),
        ],
      );



      return Text("Vehicle weight: ${globalVehiclesRequested[globalCurrentPolicyIndex][index].vehicleWeight}", style: TextStyle(
        fontSize: 18,
      ),);
    }
    else{
      return Container();
    }
  }

}
