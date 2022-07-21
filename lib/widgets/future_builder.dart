import 'package:flutter/material.dart';

import '../constants.dart';

Widget defaultFutureBuilder(Future<dynamic> func, String field){
  return FutureBuilder(
    future: func,
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return Center(
            child: Text('there is an error'),
          );
        }
        else if(snapshot.hasData){
          final String myText = snapshot.data[field]!.toString();
          clientNamesForPolicyRequests.insert(0, myText);
          print("${clientNamesForPolicyRequests.length}");
          return Text(myText);
        }
      }
      return const Text("Please wait");
    },
  );
}