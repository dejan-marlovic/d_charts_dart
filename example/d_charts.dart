// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.


import 'dart:html';
import 'package:d_charts/d_charts.dart';

void main() 
{
 //testing barchart  
 List<String> xAxislabels = ["januari","februari","mars"];
 List<List<double>> chartData = [[10.0,10.0,10.0], [10.0,6.0,3.0],[20.1,4.3,5.0]];
 List<String> chartColors =["blue","red","green"];
 dBarChart barChart = new dBarChart(querySelector("#barchart"),20,chartColors);
 barChart.setChartData(chartData, 5);
 barChart.draw();
 barChart.drawAxis();
 //barChart.renderHorisontalGrid();
 barChart.xAxisLabels = xAxislabels;
 barChart.renderXAxisLabels();
 barChart.renderHorisontalGridLabel();
 
 
 
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
 
/*  
//testing linechart 
  List<String> chartColors =["blue","red","green"];
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
  List<String> xAxisLabels = ["2010","2011","2012","2013"];
  
  dLineChart linechart = new dLineChart(container:querySelector("#linechart"), chartData:datapoints, chartColors : chartColors, xAxisLabels : xAxisLabels, verticalGridResolution:10, horisontalGridResolution:10);
  linechart.draw();
*/
}