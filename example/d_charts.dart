// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.


import 'dart:html';
import 'package:d_charts/d_charts.dart';

void main() 
{
 List<String> xAxislabels = ["januari","februari","mars"];
 List<List<double>> chartData = [[10.0,10.0,10.0], [10.0,6.0,3.0],[20.1,4.3,5.0]];
 List<String> chartColors =["blue","red","green"];
 
 //ej implementerat
 List<String> yAxisLabels = ["1","2","3"];
 
 String font = "bold 12px sans-serif";

 dBarChart barChart = new dBarChart(container:querySelector("#barchart"),margin:20,chartData:chartData,chartColors:chartColors,xAxisLabels:xAxislabels,yAxisLabels:null,font:font,xAxisLabelsRoom:40, yAxisOffset:25, barValuePrecision:3);
 barChart.draw();
 
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
}