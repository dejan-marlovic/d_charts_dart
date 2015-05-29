
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
  dChart(DivElement container, List chartData, List charColors)
  {
    _chartData = chartData;
    _container = container;
    _canvas = new CanvasElement();
    _container.append(_canvas);
    _context = _canvas.getContext("2d");
    _canvas.width = (_container.getBoundingClientRect().width as double).toInt();
    _canvas.height = (_container.getBoundingClientRect().height as double).toInt();
    _chartData = chartData;
    _container = container;
    _chartColors = charColors;
    _chartDataIterator = _chartData.iterator;
  }
  
  void draw();
  
  void drawAxis()
  {
    _context.beginPath();
    _context.lineWidth = 2;
    _context.strokeStyle = "black";
    _context.moveTo(10, _canvas.height);
    _context.lineTo(10,10);
    _context.moveTo(10, _canvas.height);
    _context.lineTo(_canvas.width,_canvas.height);
    _context.stroke();
    _context.closePath();
  }
  
  void renderGridLabel(int y)
  {
    _context.fillText(toRelativeY(_canvas.height-y).toString(), 12,(y));
  }
  
  void renderGrid(int resolution)
  {
    _gridResolutionPixel = toPixelsY(resolution.toDouble());
    //noOfGridLines = (_graphAreaHeight ~/ _gridHeightPixel);

    _context.strokeStyle = "gray";
    _context.lineWidth = 2;
    //render grid
    int currentY = _gridResolutionPixel;
    while (currentY < _canvas.height)
    {         
      _context.beginPath();
      _context.moveTo(10, _canvas.height - currentY);
      _context.lineTo(_canvas.width, _canvas.height - currentY);
      renderGridLabel(_canvas.height - currentY);
      _context.stroke();
      _context.closePath();
      currentY += _gridResolutionPixel;
    }
    
  }
  
  void renderXAxisLabels()
  {
    
  
  }
  
  void renderYAxisLabels()
  {
  
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
int _gridResolutionPixel;
double _minYValue = 0.0;
int _longestListSize = 0;
int noOfGridLines = 0;
double _minXValue = 0.0;
}



