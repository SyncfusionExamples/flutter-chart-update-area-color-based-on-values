import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;

void main() {
  return runApp(_ChartApp());
}

class _ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<SalesData> data = [
    SalesData('Jan', 35),
    SalesData('Feb', 28),
    SalesData('Mar', 0),
    SalesData('Apr', -32),
    SalesData('May', -40),
  ];
  double midValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SfCartesianChart(
          primaryXAxis: const CategoryAxis(),
          onActualRangeChanged: (ActualRangeChangedArgs rangeChangedArgs) {
            if (rangeChangedArgs.orientation == AxisOrientation.vertical) {
              midValue =
                  rangeChangedArgs.visibleMax /
                  (rangeChangedArgs.visibleMax.abs() +
                      rangeChangedArgs.visibleMin.abs());
            }
          },
          series: <CartesianSeries<SalesData, String>>[
            AreaSeries<SalesData, String>(
              dataSource: data,
              xValueMapper: (SalesData data, _) => data.year,
              yValueMapper: (SalesData data, _) => data.sales,
              color: Colors.green.withValues(alpha: 0.3),
              onCreateShader: (ShaderDetails details) {
                return ui.Gradient.linear(
                  details.rect.topCenter,
                  details.rect.bottomCenter,
                  <Color>[Colors.green, Colors.green, Colors.red, Colors.red],
                  <double>[0, midValue, midValue, 0.99999],
                );
              },
              borderColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
