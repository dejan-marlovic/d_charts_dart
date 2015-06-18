library chart;

import "dart:html";
import "dart:math";

///namnge subklassernas filer;
part "d_barchart.dart";
part "d_piechart.dart";
part "d_linechart.dart";

abstract class dChart 
{
  // param: container - DivElement, div container for canvas element that will contain the graph.
  // param: chartDate - List containing chart data
  // param: chartColors - List containing chartColors
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
    _yAxisOffset = 20;
    _xAxisOffset = 20;
    _graphAreaHeight = _canvas.height -_yAxisOffset;
    _graphAreaWidth = _canvas.width - _xAxisOffset;
    _font = "bold 12px sans-serif";
    _gridResolution = gridResolution;
  }

  double calcMaxDataValue();
  void renderHorisontalLabels();
 

  
  void draw()
  {
    if(_chartData == null) throw (new StateError("chart data is not initilazed"));
    if(_gridResolution != null)
    {  
      renderHorisontalGrid();
      renderHorisontalLabels();
      renderVerticalLabels();
    }
    if(this is dLineChart)
    {
      renderVerticalGrid();
    }
    if(!(this is dPieChart))
      drawAxis();
 
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
    _context.lineWidth = 2;
    //render grid
    int girdHeight = toPixelsY((_gridResolution).toDouble());
    int currentY;
    currentY = _graphAreaHeight - girdHeight;
    while (currentY > 0) 
    {
      _context.beginPath();
      _context.moveTo(_xAxisOffset, currentY);
      _context.lineTo(_graphAreaWidth + _xAxisOffset, currentY);
      _context.stroke();
      _context.closePath();
      currentY -= girdHeight;
    }
  }
  
  void renderVerticalLabels() 
  {
    _context.textAlign = "left";
    _context.font  = "bold 12px sans-serif";
    _context.fillStyle = "black";
    int currentY;
    int girdHeight = (toPixelsY((_gridResolution).toDouble()));
    currentY = _graphAreaHeight - girdHeight;
    while (currentY > 0) 
    {
      String value = toRelativeY(_graphAreaHeight-currentY).toString();
      _context.fillText(value, 0, (currentY));
      currentY -= girdHeight;
    }
  }
  
  void renderVerticalGrid() 
  {
    _context.strokeStyle = "gray";
    _context.lineWidth = 2;
    //render grid
    int gridWidth = toPixelsX((_gridResolution).toDouble());
    int currentX = gridWidth + _xAxisOffset;
    while (currentX < _graphAreaWidth + _xAxisOffset) 
    {
      _context.beginPath();
      _context.moveTo(currentX, 0);
      _context.lineTo(currentX, _graphAreaHeight);
      _context.stroke();
      _context.closePath();
      currentX += gridWidth;
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

  CanvasElement _canvas;
  DivElement _container;
  List _chartData;
  var _context;
  List _chartColors;
  Iterator _chartDataIterator;
  double _maxYValue = 0.0;
  double _maxXValue = 0.0;
  double _ratioY = 0.00;
  double _ratioX = 0.00;
  int _graphAreaHeight;
  int _xAxisOffset = 0;
  int _yAxisOffset=0;
  int _graphAreaWidth = 0;
  int _gridResolution;
  String _font;

}
