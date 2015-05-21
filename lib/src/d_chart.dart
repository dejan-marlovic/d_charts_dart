
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
    _canvas.width = _container.getBoundingClientRect().width.floor();
    _canvas.height = _container.getBoundingClientRect().height.floor();
    _chartData = chartData;
    _container = container;
    _chartColors = charColors;
  }
  
  void draw();

CanvasElement _canvas;
DivElement _container;
List _chartData;
var _context;
List _chartColors;
}



