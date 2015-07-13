library chart;

import "dart:html";
import "dart:math";
import "package:color/color.dart";

///namnge subklassernas filer;
part "d_barchart.dart";
part "d_piechart.dart";
part "d_linechart.dart";

abstract class dChart 
{
  // param: container - DivElement, div container for the canvas element that will contain the graph.
  // param: chartColors - List, containing chart colors
  // param: gridResolution - int, grid resolution for line and bar charts
  // param: gridResolution - int, grid resolution for line and bar charts
  // param: graphtAreaUnitWidth - int, graph area width specified in units.  
  // param: graphtAreaUnitHeight - int, graph area height specified in units.
  // param: font - String, font to be used for drawing y and x-axis labels and piechat segment labels. Font is to be specified in context object format ex: bold 10px sans-serif
  dChart(DivElement container, List chartColors, int gridResolution, int graphAreaUnitWidth, int graphAreaUnitHeight, String font) 
  {
    _container = container;
    _canvas = new CanvasElement();
    _canvas.width = (_container.getBoundingClientRect().width as double).toInt();
    _canvas.height = (_container.getBoundingClientRect().height as double).toInt();
    _container.append(_canvas);
    _context = _canvas.getContext("2d");
    _container = container;
    _chartColors = chartColors;
    _font = font;
    _yAxisOffset = 20;
    _xAxisOffset = 20;
    _graphAreaPixelHeight = _canvas.height -_yAxisOffset ;
    _graphAreaPixelWidth = _canvas.width - _xAxisOffset;
    _graphAreaUnitHeight = graphAreaUnitHeight;
    _graphAreaUnitWidth = graphAreaUnitWidth;
    if (graphAreaUnitHeight != null) _ratioY = (_graphAreaPixelHeight.toDouble() / (_graphAreaUnitHeight * 1.05)) ;
    if (graphAreaUnitWidth != null) _ratioX = (_graphAreaPixelWidth.toDouble() / (_graphAreaUnitWidth * 1.05));
    _gridResolution = gridResolution;
    if(_gridResolution != null) _gridPixelsHeight = toPixelsY(_gridResolution.toDouble());
    if(_gridResolution != null) _gridPixelWidth = toPixelsX(_gridResolution.toDouble());
  }
  


 
  void draw()
  {
    if (_chartData == null) throw (new StateError("chart data is not initilazed"));
    if (_gridResolution != null)
    {  
      renderHorisontalGrid();
      
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
    _context.lineTo(_xAxisOffset, _graphAreaPixelHeight);
    _context.moveTo(_xAxisOffset, _graphAreaPixelHeight);
    _context.lineTo(_canvas.width, _graphAreaPixelHeight);
    _context.stroke();
    _context.closePath();
  }

  void renderHorisontalGrid() 
  {
    _context.strokeStyle = "gray";
    _context.lineWidth = 1;
    int currentY =  _gridResolution;
    while (currentY <= _graphAreaUnitHeight) 
    {
      _context.beginPath();
      _context.moveTo(_xAxisOffset, toPixelPositionY(currentY.toDouble()));
      _context.lineTo(_xAxisOffset +_graphAreaPixelWidth, toPixelPositionY(currentY.toDouble()));
      _context.stroke();
      _context.closePath();
      currentY += _gridResolution;
    }
  }
  
  void renderVerticalGrid() 
  {
    _context.strokeStyle = "gray";
    _context.lineWidth = 1;
    int currentX = _gridResolution;
    while (currentX <= _graphAreaUnitWidth) 
    {
      _context.beginPath();
      _context.moveTo(toPixelsX(currentX.toDouble()) + _xAxisOffset, 0);
      _context.lineTo(toPixelsX(currentX.toDouble()) + _xAxisOffset, _graphAreaPixelHeight);
      _context.stroke();
      _context.closePath();
      currentX += _gridResolution;
    }
  }
  
  void renderVerticalLabels() 
  {
    _context.textAlign = "left";
    _context.font  = _font;
    _context.fillStyle = "black";
    int currentY =  _gridResolution;
    while (currentY <= _graphAreaUnitHeight) 
    {
      String value = currentY.toString();
      _context.fillText(value, 0, toPixelPositionY(currentY.toDouble()));
      currentY += _gridResolution;
    }
  }

  int toPixelsY(double relative_value) 
  {
    return (relative_value * _ratioY).round();
  }
  
  int toPixelPositionY(double relative_position)
  {
    return _graphAreaPixelHeight - toPixelsY(relative_position);
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
  int _graphAreaPixelHeight,_xAxisOffset, _yAxisOffset, _graphAreaPixelWidth, _gridResolution, _gridPixelWidth,_gridPixelsHeight, _graphAreaUnitWidth, _graphAreaUnitHeight;
  String _font;
}
