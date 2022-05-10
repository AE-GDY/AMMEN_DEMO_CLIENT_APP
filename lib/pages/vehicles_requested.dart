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
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
          width: 2000,
          height: 2000,
          child: ListView.builder(
              itemCount: globalVehiclesRequested[globalCurrentPolicyIndex].length,
              itemBuilder: (context,index){
                return Container(
                  height: 250,
                  margin: EdgeInsets.all(20),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Vehicle Make: ${globalVehiclesRequested[globalCurrentPolicyIndex][index].vehicleMake}", style: TextStyle(
                            fontSize: 18,
                          ),),
                          SizedBox(height: 20,),
                          Text("Vehicle Model: ${globalVehiclesRequested[globalCurrentPolicyIndex][index].vehicleModel}", style: TextStyle(
                            fontSize: 18,
                          ),),
                          SizedBox(height: 20,),
                          Text("Production Year: ${globalVehiclesRequested[globalCurrentPolicyIndex][index].productionYear}", style: TextStyle(
                            fontSize: 18,
                          ),),
                          SizedBox(height: 20,),
                          Text("Plate Number: ${globalVehiclesRequested[globalCurrentPolicyIndex][index].vehiclePlateNumber}", style: TextStyle(
                            fontSize: 18,
                          ),),
                          SizedBox(height: 20,),
                          buildExtraInfo(index),
                        ],
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }


  Widget buildExtraInfo(int index){
    if(globalVehiclesRequested[globalCurrentPolicyIndex][index].vehicleType == 'bus'){
      return Text("Number of seats: ${globalVehiclesRequested[globalCurrentPolicyIndex][index].vehicleNumberOfSeats}", style: TextStyle(
        fontSize: 18,
      ),);
    }
    else if(globalVehiclesRequested[globalCurrentPolicyIndex][index].vehicleType == 'truck'){
      return Text("Vehicle weight: ${globalVehiclesRequested[globalCurrentPolicyIndex][index].vehicleWeight}", style: TextStyle(
        fontSize: 18,
      ),);
    }
    else{
      return Container();
    }
  }

}
