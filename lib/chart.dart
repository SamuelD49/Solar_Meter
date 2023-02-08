//@dart=2.9
import '/services/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import 'model/channal.dart';

/* void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
} */

class Chart extends StatefulWidget {
  Chart(this.channel);
  //  String _channal;
  // Chart({Key? key, required this._channal}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String channel;

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<ChannalModel> _chartData;
  TooltipBehavior _tooltipBehavior;
  ZoomPanBehavior _zoomPanBehavior;

  getdata() async {
    var data = await getch1ChartData();
    setState(() {
      _chartData = data;
      _tooltipBehavior = TooltipBehavior(enable: true);
      _zoomPanBehavior = ZoomPanBehavior(
          enablePinching: true,
          enableDoubleTapZooming: true,
          enableSelectionZooming: true,
          selectionRectBorderColor: Colors.red,
          selectionRectBorderWidth: 2,
          selectionRectColor: Colors.grey,
          enablePanning: true,
          zoomMode: ZoomMode.xy,
          enableMouseWheelZooming: true,
          maximumZoomLevel: 0.5);
    });
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  double tsConverter(int ts) {
    final hour = DateTime.fromMillisecondsSinceEpoch(ts).hour +
        (DateTime.fromMillisecondsSinceEpoch(ts).minute) / 60;
    return hour.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: SfCartesianChart(
              // plotAreaBackgroundImage: AssetImage('asset/sami2.jpg'),
              title: ChartTitle(text: 'CH 1'),
              legend: Legend(isVisible: true),
              tooltipBehavior: _tooltipBehavior,
              zoomPanBehavior: _zoomPanBehavior,
              series: <ChartSeries>[
                LineSeries<ChannalModel, double>(
                    name: 'Generated Energy',
                    dataSource: _chartData,
                    xValueMapper: (ChannalModel sales, _) =>
                        tsConverter(sales.time),
                    yValueMapper: (ChannalModel sales, _) => sales.value,
                    //dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true)
              ],
              primaryXAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  labelFormat: '{value}H',
                  //numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                  interactiveTooltip: InteractiveTooltip(enable: false)),
              primaryYAxis: NumericAxis(
                  labelFormat: '{value}Watt',
                  //  numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                  interactiveTooltip: InteractiveTooltip(enable: false))),
        ),
      ),
      SizedBox(
        width: 25,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: SfCartesianChart(
              title: ChartTitle(text: 'CH 2'),
              legend: Legend(isVisible: true),
              tooltipBehavior: _tooltipBehavior,
              zoomPanBehavior: _zoomPanBehavior,
              series: <ChartSeries>[
                LineSeries<ChannalModel, double>(
                    name: 'Generated Energy',
                    dataSource: _chartData,
                    xValueMapper: (ChannalModel sales, _) =>
                        tsConverter(sales.time),
                    yValueMapper: (ChannalModel sales, _) => sales.value,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true)
              ],
              primaryXAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  labelFormat: '{value}H',
                  // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                  interactiveTooltip: InteractiveTooltip(enable: false)),
              primaryYAxis: NumericAxis(
                  labelFormat: '{value}Watt',
                  //numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                  interactiveTooltip: InteractiveTooltip(enable: false))),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: SfCartesianChart(

              // []
              // backgroundColor: Colors.amber,
              /* palette: <Color>[
                Color.fromRGBO(75, 135, 185, 1),
                Color.fromRGBO(192, 108, 132, 1),
                Color.fromRGBO(246, 114, 128, 1),
                Color.fromRGBO(248, 177, 149, 1),
                Color.fromRGBO(116, 180, 155, 1),
                Color.fromRGBO(0, 168, 181, 1),
                Color.fromRGBO(73, 76, 162, 1),
                Color.fromRGBO(255, 205, 96, 1),
                Color.fromRGBO(255, 240, 219, 1),
                Color.fromRGBO(238, 238, 238, 1)
              ], */
              title: ChartTitle(text: 'CH 3'),
              legend: Legend(position: LegendPosition.bottom, isVisible: true),
              tooltipBehavior: _tooltipBehavior,
              zoomPanBehavior: _zoomPanBehavior,
              series: <ChartSeries>[
                LineSeries<ChannalModel, double>(
                    name: 'Generated Energy',
                    dataSource: _chartData,
                    xValueMapper: (ChannalModel sales, _) =>
                        tsConverter(sales.time),
                    yValueMapper: (ChannalModel sales, _) => sales.value,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true)
              ],
              primaryXAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  labelFormat: '{value}H',
                  //  numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                  interactiveTooltip: InteractiveTooltip(enable: false)),
              primaryYAxis: NumericAxis(
                  labelFormat: '{value}Watt',
                  // numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                  interactiveTooltip: InteractiveTooltip(enable: false))),
        ),
      )
    ])));
  }

  Future<List<ChannalModel>> getch1ChartData() async {
    List<ChannalModel> chartData =
        await Provider.of<DataProvider>(context, listen: false)
            .getChData24(ch: widget.channel);
    chartData.forEach((element) {
      print(element.time);
    });
    return chartData;
  }
}

/* class ChartData {
  ChartData(this.time, this.value);
  final double time;
  final double value;
}
 */	
  /* FutureBuilder<List>(
    future: _value,
    builder: (
      BuildContext context,
      AsyncSnapshot<String> snapshot,
    ) {
      print(snapshot.connectionState);
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.hasData) {
          return Text(snapshot.data);
        } else {
          return const Text('Empty data');
        }
      } else {
        return Text('State: ${snapshot.connectionState}');
      }
    },
  ) */