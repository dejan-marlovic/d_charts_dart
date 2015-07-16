
import 'dart:html';
import 'package:d_charts/d_charts.dart';
import "package:color/color.dart";


void main() 
{

  //testing barchart
  List<RgbColor> chartColors = [new RgbColor(0,0,255),new RgbColor(255,0,0),new RgbColor(0,255,0)];
  List<String> xAxislabels = ["januari","februari","mars","januari","februari","mars","januari","februari","mars","januari","februari","mars"];
  List<List<double>> chartData = [[10.0,10.0,10.0], [10.0,6.0,3.0],[20.1,4.3,5.0],[10.0,10.0,10.0], [10.0,6.0,3.0],[20.1,4.3,5.0],[10.0,10.0,10.0], [10.0,6.0,3.0],[20.1,4.3,5.0],[10.0,10.0,10.0], [10.0,6.0,3.0],[20.1,4.3,5.0]];
  dBarChart barChart = new dBarChart(querySelector("#barchart"),10,chartColors,10,xAxislabels,90,90, "bold 10px sans-serif");
  barChart.setChartData(chartData);
  barChart.font = "bold 12px sans-serif";
  barChart.barValuePrecision = 3;
  barChart.xAxisLabels = ["januari","februari","mars","januari","februari","mars","januari","februari","mars","januari","februari","TEST"];
  barChart.draw();
  
  chartColors.removeAt(2);
  
  //testing linechart two separate graphs
  List<List<dDataPoint>> datapoints = [[new dDataPoint(0.0,0.0), new dDataPoint(10.0,10.0),new dDataPoint(11.0,80.0), new dDataPoint(15.0,15.0)],
                                          [new dDataPoint(0.0,0.0),new dDataPoint(30.1,20.0), new dDataPoint(80.0,10.0), new dDataPoint(35.0,15.0)]];
  
  
  List<String> xAxisLabels = ["2010","2011","2012","2013","2014","2015","2016","2017","2010"];
  dLineChart lineChart = new dLineChart(querySelector("#linechart"), chartColors,10,90,90,"bold 8px sans-serif");
  lineChart.xAxisLabels = xAxisLabels;
  lineChart.setChartData(datapoints);
  lineChart.font = "bold 11px sans-serif";
  lineChart.draw();
  lineChart.drawProjected(extension_x:20,graph_index:0);
  lineChart.drawProjected(extension_x:10,graph_index:1);
  lineChart.drawProjected(extension_x:0);


  //testing piechart
  List<double> data = [500.3,600.34,400.0,699.9];
  List<RgbColor> colors = [new RgbColor(0,0,255),new RgbColor(255,0,0),new RgbColor(0,255,0), new RgbColor(100,0,100)];
  dPieChart chart = new dPieChart(querySelector("#piechart"),colors);
  chart.setChartData(data);
  chart.precsion = 4;
  chart.font = "bold 12px sans-serif";
  //chart.labels = ["First","Second","Third", "Fifth"];
  //chart.includeLabels = false;
  chart.draw();




} 
 

 