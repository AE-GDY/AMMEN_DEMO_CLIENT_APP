import 'package:flutter/material.dart';
//import 'package:flutter_web_dashboard/constants/style.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color topColor;
  final bool isActive;
  final VoidCallback onTap;

  const InfoCard({Key? key,required this.title,required this.value, this.isActive = false,required this.onTap, this.topColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 136,
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
                    color: topColor,
                    height: 5,
                  ))
                ],
              ),
              Expanded(child: Container()),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "$title\n",
                        style: TextStyle(
                            fontSize: 16, color: Colors.black)),
                    TextSpan(
                        text: "$value",
                        style:
                        TextStyle(fontSize: 40, color: Colors.black)),
                  ])),
              Expanded(child: Container()),

            ],
          ),
        ),
      ),
    );
  }
}