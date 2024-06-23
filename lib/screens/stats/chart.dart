import 'package:firstapp/data/data.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Mychart extends StatefulWidget {
  const Mychart({super.key});

  @override
  State<Mychart> createState() => _MychartState();
}

class _MychartState extends State<Mychart> {
final dataMap = <String, double>{
    //myTransactionsData[i]['name']: 5,
    "Food": 10,
    "Shopping": 4,
    "Sport": 1,
    "Entertainment": 2,
    "Transportation": 2,
  };

  final colorList = <Color>[
    //myTransactionsData[i]['color'],
    Colors.yellow.shade600,
    Colors.purple.shade500,
    Colors.blue.shade600,
    Colors.blue.shade200,
    Colors.teal.shade400,
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Pie Chart Example'),
      // ),
      body: Container(
        color: Colors.grey.shade400,
        child: PieChart(
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 1000),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width / 2,
          baseChartColor: Colors.grey.shade400,
          colorList: colorList,
          initialAngleInDegree: 0,
          chartType: ChartType.ring,
          ringStrokeWidth: 38,
          //centerText: "Technologies",
          legendOptions: LegendOptions(
            showLegendsInRow: true,
            legendPosition: LegendPosition.bottom,
            showLegends: true,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: true,
            showChartValuesInPercentage: true,
            showChartValuesOutside: false,
            decimalPlaces: 1,
          ),
          // gradientList: ---To add gradient colors---
          // emptyColorGradient: ---Empty Color gradient---
        ),
      ),
    );
  } 
}