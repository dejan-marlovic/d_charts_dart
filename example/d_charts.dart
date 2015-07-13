
import 'dart:html';
import 'package:d_charts/d_charts.dart';
import "package:color/color.dart";


void main() 
{

RgbColor rgbBlue = new RgbColor(0,0,255);
RgbColor rgbRed = new RgbColor(255,0,0);
RgbColor rgbGreen = new RgbColor(0,255,0);
List<RgbColor> chartColors = new List<RgbColor>();
chartColors.add(rgbBlue);
chartColors.add(rgbRed);
chartColors.add(rgbGreen);

//testing barchart  
 List<String> xAxislabels = ["januari","februari","mars","januari","februari","mars","januari","februari","mars","januari","februari","mars", "februari", "mars"];
 List<List<double>> chartData = [[10.0,10.0,10.0], [10.0,6.0,3.0],[20.1,4.3,5.0],[10.0,10.0,10.0], [10.0,6.0,3.0],[20.1,4.3,5.0],[10.0,10.0,10.0], [10.0,6.0,3.0],[20.1,4.3,5.0],[10.0,10.0,10.0], [10.0,6.0,3.0],[20.1,4.3,5.0],[10.0,6.0,3.0],[20.1,4.3,5.0]];
 dBarChart barChart = new dBarChart(querySelector("#barchart"),10,chartColors,10,xAxislabels,90,90, "bold 10px sans-serif");
 barChart.setChartData(chartData);
 barChart.draw();

chartColors.removeAt(2);
 //List<String> chartColors =["blue","red","green"];
//testing linechart 
dDataPoint dp1 = new dDataPoint(10.0,10.0);
dDataPoint dp2 = new dDataPoint(11.0,80.0);
dDataPoint dp3 = new dDataPoint(15.0,15.0);
List<List<dDataPoint>> datapoints = new List();
List<dDataPoint> firstgraph = new List<dDataPoint>();
List<dDataPoint> secondgraph = new List<dDataPoint>();
datapoints.add(firstgraph);
datapoints.add(secondgraph);
datapoints.first.add(dp1);
datapoints.first.add(dp2);
datapoints.first.add(dp3);
datapoints.first.add(new dDataPoint(0.0,0.0));
datapoints.last.add(new dDataPoint(30.1,20.0));
datapoints.last.add(new dDataPoint(80.0,10.0));
datapoints.last.add(new dDataPoint(35.0,15.0));
datapoints.last.add(new dDataPoint(0.0,0.0));
//List<String> xAxisLabels = ["2010"];
//List<String> xAxisLabels = ["2010","2011"];
//List<String> xAxisLabels = ["2010","2011","2012","2013"];
//List<String> xAxisLabels = ["2010","2011","2012","2013","2014"];
//List<String> xAxisLabels = ["2010","2011","2012","2013","2014","2015"];
//List<String> xAxisLabels = ["2010","2011","2012","2013","2014","2015","2016"];
//List<String> xAxisLabels = ["2010","2011","2012","2013","2014","2015","2016","2017","2010"];
dLineChart lineChart = new dLineChart(querySelector("#linechart"), chartColors,5,90,90,"bold 8px sans-serif");

lineChart.setChartData(datapoints);
//lineChart.xAxisLabels = xAxisLabels;
lineChart.draw();
lineChart.drawProjected(extension_x:20,graph_index:0);
lineChart.drawProjected(extension_x:10,graph_index:1);
lineChart.drawProjected(extension_x:0);
//lineChart.drawProjected("blue",0, extensionX:0);
//lineChart.drawAxis();
//lineChart.renderVerticalLabels();
//lineChart.xAxisLabels = xAxisLabels;
//lineChart.renderHorisontalLabels();

//testing piechart

List<double> data = [500.3,600.34,400.0,699.9];

/*
RgbColor rgbBlue = new RgbColor(0,0,255);
RgbColor rgbRed = new RgbColor(255,0,0);
RgbColor rgbGreen = new RgbColor(0,255,0);
 */
RgbColor rgbPink = new RgbColor(100,0,100);
RgbColor rgbYellow = new RgbColor(200,200,0);
List<RgbColor> colors = new List();
colors.add(rgbBlue);
colors.add(rgbGreen);
colors.add(rgbRed);
colors.add(rgbYellow);
colors.add(rgbPink);

dPieChart chart = new dPieChart(querySelector("#piechart"),colors);
chart.setChartData(data);
//chart.labels = ["First","Second","Third", "Fifth"];
chart.draw();



} 
 

 