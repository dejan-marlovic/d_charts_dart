// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.


import 'dart:html';
import 'package:d_charts/d_charts.dart';

void main() 
{
   List<String> chartColors =["blue","red","green"];
  //testing barchart  
 List<String> xAxislabels = ["januari","februari","mars"];
 List<List<double>> chartData = [[10.0,10.0,10.0], [10.0,6.0,3.0],[20.1,4.3,5.0]];

 dBarChart barChart = new dBarChart(querySelector("#barchart"),20,chartColors);
 barChart.setChartData(chartData, 10);
 barChart.draw();
 barChart.drawAxis();
 barChart.renderHorisontalGrid();
 barChart.xAxisLabels = xAxislabels;
 barChart.renderHorisontalLabels();
 barChart.renderVerticalLabels();

 

 //List<String> chartColors =["blue","red","green"];
//testing linechart 
dDataPoint dp1 = new dDataPoint(10.0,10.0);
dDataPoint dp2 = new dDataPoint(10.0,80.0);
dDataPoint dp3 = new dDataPoint(15.0,15.0);
List<List<dDataPoint>> datapoints = new List();
List<dDataPoint> firstgraph = new List<dDataPoint>();
List<dDataPoint> secondgraph = new List<dDataPoint>();
datapoints.add(firstgraph);
datapoints.add(secondgraph);
datapoints.first.add(dp1);
datapoints.first.add(dp2);
datapoints.first.add(dp3);
datapoints.last.add(new dDataPoint(30.1,20.0));
datapoints.last.add(new dDataPoint(80.0,10.0));
datapoints.last.add(new dDataPoint(50.0,50.0));
List<String> xAxisLabels = ["2010","2011","2012","2013"];

dLineChart lineChart = new dLineChart(querySelector("#linechart"), chartColors);

lineChart.setChartData(datapoints,10);
lineChart.renderVerticalGrid();
lineChart.draw();
lineChart.drawAxis();
lineChart.renderHorisontalGrid();
lineChart.renderVerticalLabels();

lineChart.xAxisLabels = xAxisLabels;


} 
 
 //testing piechart
 /* 
 List<int> data = [120,120,120];
 List<List<String>> colors = new List<List<String>>();
 List<String> color1 = ["blue","green"];
 List<String> color2 = ["yellow","red"];
 List<String> color3 = ["pink","white"];
 colors.add(color1);
 colors.add(color2);
 colors.add(color3);
 List<String> labels = ["First","Second","Third"];
 dPieChart chart = new dPieChart(container:querySelector("#piechart"), includeLabels:true,chartData:data,labels:labels,chartColors:colors);
 chart.draw();
 chart.select(1);
 */
 