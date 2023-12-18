import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';

class Graph extends StatefulWidget {
  var data = [];
  Graph({required this.data});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height / 2.4,
        child: SfCartesianChart(
          borderWidth: 0,
          primaryXAxis: CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),
              labelRotation: 45,
              //Hide the axis line of y-axis
              axisLine: AxisLine(width: 0)),
          primaryYAxis: NumericAxis(
              majorGridLines: MajorGridLines(width: 0),
              decimalPlaces: 0,
              // minimum: 1,
              // maximum: 6,
              //Hide the axis line of y-axis
              axisLine: AxisLine(width: 0)),
          series: <ChartSeries>[
            ColumnSeries(
                width: .3,
                borderRadius: BorderRadius.circular((10.0)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [
                    AppColors.ff47438D,
                    AppColors.white,
                  ],
                ),
                dataSource: widget.data,
                xValueMapper: (sales, _) => sales[TextConstant.month],
                yValueMapper: (sales, _) => sales[TextConstant.count])
          ],
        ),
      ),
    );
  }
}

// class SalesData{
//   String x;
//   double y;
//   SalesData(this.x,this.y);
// }

// dynamic getColumnData(){
//   List<SalesData> columnData = <SalesData>[
//     SalesData("BMW ", 20),
//     SalesData("Audi", 30),
//     SalesData("Honda", 40),
//     SalesData("ghcg", 5000),
//     SalesData("fd", 5000),
//     SalesData("vd", 5000),
//     SalesData("ds", 5000),
//     SalesData("efwds", 60),
//     SalesData("dv", 60),
//     SalesData("vs", 60),
//     SalesData("RR", 60),
//   ];
//   return columnData;
// }
