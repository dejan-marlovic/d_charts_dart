// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.


import 'dart:html';
import 'package:d_charts/d_charts.dart';

void main() 
{
 //testing barchart  
 /*
 List<String> xAxislabels = ["januari","februari","mars"];
 List<List<double>> chartData = [[10.0,10.0,10.0], [10.0,6.0,3.0],[20.1,4.3,5.0]];
 List<String> chartColors =["blue","red","green"];

 String font = "bold 12px sans-serif";
 dBarChart barChart = new dBarChart(container:querySelector("#barchart"),margin:20,chartData:chartData,chartColors:chartColors,xAxisLabels:xAxislabels,yAxisLabels:null,font:font,xAxisLabelsRoom:40, yAxisOffset:25, barValuePrecision:3);
 barChart.draw();
 */
 
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
 
//testing linechart 
  
  dDataPoint dp1 = new dDataPoint(5.0,5.0);
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
  datapoints.last.add(new dDataPoint(40.1,4.1));
  datapoints.last.add(new dDataPoint(50.1,40.1));
  List<String> chartColors =["blue","red","green"];
  
  dLineChart linechart = new dLineChart(container:querySelector("#linechart"), chartData:datapoints, chartColors : chartColors);
  linechart.draw();
}