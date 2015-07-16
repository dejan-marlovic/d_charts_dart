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
  // param: graphtAreaUnitWidth - int, graph area width specified in units.  
  // param: graphtAreaUnitHeight - int, graph area height specified in units.
  // param: font - String, font to be used for writing y and x-axis labels and piechat segment labels. Font is to be specified in context object format ex: bold 10px sans-serif
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
    if(_gridResolution != null) _gridPixelsHeight = _toPixelsY(_gridResolution.toDouble());
    if(_gridResolution != null) _gridPixelWidth = _toPixelsX(_gridResolution.toDouble());
  }
  
  void draw()
  {
    if (_chartData == null) throw (new StateError("chart data is not initilazed"));
    if (_gridResolution != null)
    {  
      _renderHorisontalGrid();
      _renderVerticalLabels();
    }
    if (this is dLineChart) _renderVerticalGrid();
    if (!(this is dPieChart)) _drawAxis(); 
  }
  
  void _drawAxis() 
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

  void _renderHorisontalGrid() 
  {
    _context.strokeStyle = "gray";
    _context.lineWidth = 1;
    int currentY =  _gridResolution;
    while (currentY <= _graphAreaUnitHeight) 
    {
      _context.beginPath();
      _context.moveTo(_xAxisOffset, _toPixelPositionY(currentY.toDouble()));
      _context.lineTo(_xAxisOffset +_graphAreaPixelWidth, _toPixelPositionY(currentY.toDouble()));
      _context.stroke();
      _context.closePath();
      currentY += _gridResolution;
    }
  }
  
  void _renderVerticalGrid() 
  {
    _context.strokeStyle = "gray";
    _context.lineWidth = 1;
    int currentX = _gridResolution;
    while (currentX <= _graphAreaUnitWidth) 
    {
      _context.beginPath();
      _context.moveTo(_toPixelsX(currentX.toDouble()) + _xAxisOffset, 0);
      _context.lineTo(_toPixelsX(currentX.toDouble()) + _xAxisOffset, _graphAreaPixelHeight);
      _context.stroke();
      _context.closePath();
      currentX += _gridResolution;
    }
  }
  
  void _renderVerticalLabels() 
  {
    _context.textAlign = "left";
    _context.font  = _font;
    _context.fillStyle = "black";
    int currentY =  _gridResolution;
    while (currentY <= _graphAreaUnitHeight) 
    {
      String value = currentY.toString();
      _context.fillText(value, 0, _toPixelPositionY(currentY.toDouble()));
      currentY += _gridResolution;
    }
  }

  int _toPixelsY(double relative_value) 
  {
    return (relative_value * _ratioY).round();
  }
  
  int _toPixelPositionY(double relative_position)
  {
    return _graphAreaPixelHeight - _toPixelsY(relative_position);
  }

  int _toRelativeY(int pixel_value) 
  {
    return (pixel_value.toDouble() / _ratioY).round();
  }

  int _toPixelsX(double relative_value) 
  {
    return (relative_value * _ratioX).round();
  }

  int _toRelativeX(int pixel_value) 
  {
    return (pixel_value / _ratioX).round();
  }
  
  double _sumTo(a, i) 
  {
    double sum = 0.0;
    for (int j = 0; j < i; j++) 
    {
      sum += a[j];
    }
    return sum;
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
