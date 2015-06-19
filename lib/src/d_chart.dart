library chart;

import "dart:html";
import "dart:math";

///namnge subklassernas filer;
part "d_barchart.dart";
part "d_piechart.dart";
part "d_linechart.dart";

abstract class dChart 
{
  // param: container - DivElement, div container for the canvas element that will contain the graph.
  // param: chartColors - List, containing chart colors
  // param: gridResolution - int, grid resolution for line and bar charts
  dChart(DivElement container, List chartColors, int gridResolution) 
  {
    _container = container;
    _canvas = new CanvasElement();
    _canvas.width = (_container.getBoundingClientRect().width as double).toInt();
    _canvas.height = (_container.getBoundingClientRect().height as double).toInt();
    _container.append(_canvas);
    _context = _canvas.getContext("2d");
    _container = container;
    _chartColors = chartColors;
    _font = "bold 12px sans-serif";
    _yAxisOffset = 20;
    _xAxisOffset = 20;
    _graphAreaHeight = _canvas.height -_yAxisOffset;
    _graphAreaWidth = _canvas.width - _xAxisOffset;
    _gridResolution = gridResolution;
  }

  double calcMaxDataValue();
  void renderHorisontalLabels();
 
  void draw()
  {
    if (_chartData == null) throw (new StateError("chart data is not initilazed"));
    if (_gridResolution != null)
    {  
      renderHorisontalGrid();
      renderHorisontalLabels();
      renderVerticalLabels();
    }
    if (this is dLineChart) renderVerticalGrid();
    if (!(this is dPieChart)) drawAxis(); 
  }
  
  void drawAxis() 
  {
    _context.beginPath();
    _context.lineWidth = 2;
    _context.strokeStyle = "black";
    _context.moveTo(_xAxisOffset, 0);
    _context.lineTo(_xAxisOffset, _graphAreaHeight);
    _context.moveTo(_xAxisOffset, _graphAreaHeight);
    _context.lineTo(_graphAreaWidth + _xAxisOffset, _graphAreaHeight);
    _context.stroke();
    _context.closePath();
  }

  void renderHorisontalGrid() 
  {
    _context.strokeStyle = "gray";
    _context.lineWidth = 1;
    int currentY = _graphAreaHeight - _gridHeight;
    
    while (currentY > 0) 
    {
      _context.beginPath();
      _context.moveTo(_xAxisOffset, currentY);
      _context.lineTo(_graphAreaWidth + _xAxisOffset, currentY);
      _context.stroke();
      _context.closePath();
      currentY -= _gridHeight;
    }
  }
  
  void renderVerticalGrid() 
  {
    _context.strokeStyle = "gray";
    _context.lineWidth = 1;
    int currentX = _gridWidth + _xAxisOffset;
    
    while (currentX < _graphAreaWidth + _xAxisOffset) 
    {
      _context.beginPath();
      _context.moveTo(currentX, 0);
      _context.lineTo(currentX, _graphAreaHeight);
      _context.stroke();
      _context.closePath();
      currentX += _gridWidth;
    }
  }
  
  void renderVerticalLabels() 
  {
    _context.textAlign = "left";
    _context.font  = "bold 12px sans-serif";
    _context.fillStyle = "black";
    int currentY;
    currentY = _graphAreaHeight - _gridHeight;
    
    while (currentY > 0) 
    {
      String value = toRelativeY(_graphAreaHeight-currentY).toString();
      _context.fillText(value, 0, (currentY));
      currentY -= _gridHeight;
    }
  }

  int toPixelsY(double relative_value) 
  {
    return (relative_value * _ratioY).round();
  }

  int toRelativeY(int pixel_value) 
  {
    return (pixel_value.toDouble() / _ratioY).round();
  }

  int toPixelsX(double relative_value) 
  {
    return (relative_value * _ratioX).round();
  }

  int toRelativeX(int pixel_value) 
  {
    return (pixel_value / _ratioX).round();
  }
  var _context;
  CanvasElement _canvas;
  DivElement _container;
  List _chartData,_chartColors;
  Iterator _chartDataIterator;
  double _ratioY,_ratioX;
  int _graphAreaHeight,_xAxisOffset, _yAxisOffset, _graphAreaWidth, _gridResolution, _gridWidth,_gridHeight;
  String _font;
}
