import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChart extends StatefulWidget {
  final List<dynamic> data;
  final String chartType;
  final String title;
  const BarChart({Key? key, required this.data, required this.title, required this.chartType}) : super(key: key);

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {

  @override
  Widget build(BuildContext context) {

    List<charts.Series<dynamic,String>> series = [
      charts.Series(
        id: "Company",
        data: widget.data,
        domainFn: (dynamic company, _) => company.name,
        measureFn: (dynamic company, _) => (widget.chartType == "ranking")?
        company.score:(widget.chartType == "claims")?
        company.claims:(widget.chartType == "policy ranking")?
        company.policiesIssued:(widget.chartType == "complains")?company.complains:company.fraud,
        colorFn: (dynamic company, _) => company.barColor,

      )
    ];
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Column(
          children: [
            Text(
              "${widget.title}",style: TextStyle(

            ),
            ),
            Expanded(child: charts.BarChart(series, animate:true)),
          ],
        ),
      ),
    );
  }
}