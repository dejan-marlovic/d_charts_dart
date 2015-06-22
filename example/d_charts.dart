// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.


import 'dart:html';
import 'package:d_charts/d_charts.dart';

void main() 
{
 List<String> chartColors =["blue","red","green"];
//testing barchart  
 List<String> xAxislabels = ["januari","februari","mars","januari","februari","mars","januari","februari","mars","januari","februari","mars"];
 List<List<double>> chartData = [[10.0,10.0,10.0], [10.0,6.0,3.0],[20.1,4.3,5.0],[10.0,10.0,10.0], [10.0,6.0,3.0],[20.1,4.3,5.0],[10.0,10.0,10.0], [10.0,6.0,3.0],[20.1,4.3,5.0],[10.0,10.0,10.0], [10.0,6.0,3.0],[20.1,4.3,5.0]];
 dBarChart barChart = new dBarChart(querySelector("#barchart"),10,chartColors,10,xAxislabels);
 barChart.setChartData(chartData);
 barChart.draw();


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
//List<String> xAxisLabels = ["2010","2011","2012","2013","2014","2015","2016","2017","2010","2011","2012","2013","2014","2015","2016","2017"];
dLineChart lineChart = new dLineChart(querySelector("#linechart"), chartColors,5);

lineChart.setChartData(datapoints);
lineChart.draw();
lineChart.drawProjected("blue",0);
//lineChart.drawAxis();
//lineChart.renderVerticalLabels();
//lineChart.xAxisLabels = xAxisLabels;
//lineChart.renderHorisontalLabels();

//testing piechart

List<int> data = [120,120,120];
List<List<String>> colors = [["blue","green"],["yellow","red"],["pink","white"]];
dPieChart chart = new dPieChart(querySelector("#piechart"),colors);
chart.setChartData(data);
chart.labels = ["First","Second","Third"];
chart.draw();
chart.select(1);


} 
 

 