part of chart;

class dBarChart extends dChart 
{
  // param: container - DivElement, div container for the canvas element that will contain the graph.
  // param: margin - int, distance between the chart bars and between x-Axis and the first bar.
  // param: chartColors - List, containing chart colors
  // param: gridResolution - int, grid resolution is used for calculation of horisontal grid height for bar charts. 
  // param: xAxisLabels - List<String>, labels that will appear under each bar. The number of labels must match the number of bars.
  dBarChart(DivElement container, int margin, List<String> chartColors, int gridResolution, List<String> xAxisLabels): super(container, chartColors, gridResolution) 
  {
    _margin = margin;
    _barValuePrecision = 3;
    _xAxisLabels = xAxisLabels;
  }
  
  void renderHorisontalLabels() 
  {
    if(_xAxisLabels.length > 0 && _chartData != null && _chartData.length != _xAxisLabels.length) throw (new StateError("you have to specify" + _chartData.length.toString() + "labels for your chart"));
    
    if (_xAxisLabels.length > 0) 
    {
      _context.textAlign = "center";
      _context.font  = "bold 12px sans-serif";
      _context.fillStyle = "black";
      // Use try / catch to stop IE 8 from going to error town
      try 
      {
        for (int i = 0; i < _xAxisLabels.length; i++) 
        {
          double left = _margin + i * _graphAreaWidth / _numOfBars + _barWidth / 2 +_xAxisOffset;
          _context.fillText(_xAxisLabels[i],left,_graphAreaHeight+yAxisOffset-3);
        }
      } catch (ex) {}
    }
  }
  
  double calcMaxDataValue()  
  {
    double largestValue;
    while (_chartDataIterator.moveNext()) 
    {
      largestValue = sumTo(_chartDataIterator.current, _chartDataIterator.current.length);
      if (_chartDataIterator.moveNext()) 
      {
        if (largestValue < sumTo(_chartDataIterator.current,_chartDataIterator.current.length)) 
          largestValue = sumTo(_chartDataIterator.current, _chartDataIterator.current.length);
      }
    }
    _largestValue = largestValue * 1.1;
    return largestValue * 1.1;
  }
  
  // Method for drawing a  bar chart
  void draw() 
  {
    super.draw();

    int bar;
    //For each bar
    for (bar = 0; bar < _chartData.length; bar += 1) 
    {
      double barValue = sumTo(_chartData[bar], _chartData[bar].length);
      double top = 0.0;
      double left = 0.0;
      double bottom = _graphAreaHeight.toDouble();
      //For each part of the bar
      int color = 0;
      for (int cat = 0; cat < _chartData[bar].length; cat++) 
      {
        //calculate x and y value for each part of the bar
        left = _margin + bar * _graphAreaWidth / _numOfBars + _xAxisOffset;
        if (left > _canvas.width) throw new StateError("chart margin too big, bar out of visual bounds");
        double height = _chartData[bar][cat] * _ratioY;
        top = bottom - height;
        // Draw bar background for each part
        _context.fillStyle = "#333";
        _context.fillRect(left, top, _barWidth, height);
        //pick next color from chosen colors for each part of bar, if all have been used repeat
        color++;
        if (color == _chartColors.length) color = 0;
        //fill in the color of each part of the bar
        _context.fillStyle = _chartColors[color];
        _context.fillRect(left, top, _barWidth, height);
        //previous part of this bars top is next parts bottom
        bottom = top;
      }
      // Write bar value
      _context.fillStyle = "black";
      _context.font = _font;
      _context.textAlign = "center";
      // Use try / catch to stop IE 8 from going to error town
      try 
      {
        //using last top which is bar top
        _context.fillText(barValue.toStringAsPrecision(_barValuePrecision),left + _barWidth / 2, top - 4);
      } catch (ex) {}
    }
  }

  double sumTo(a, i) 
  {
    var sum = 0;
    for (var j = 0; j < i; j++) {
      sum += a[j];
    }
    return sum;
  }

  DivElement _container;
  var _context;
  
  int _margin;
  List<List<double>> _chartData;
  List<String> _chartColors;
  List<String> _yAxisLabels;
  int _barValuePrecision;
  double _largestValue;
  int _numOfBars = 0;
  double _barWidth = 0.0;
  List<String> _xAxisLabels; 

  List<List<double>> get chartData => _chartData;
  int get yAxisOffset => _yAxisOffset;
  String get font => _font;
  List<String> get chartColors => _chartColors;
  List<String> get xAxisLabels => _xAxisLabels;
  List<String> get yAxisLabels => _yAxisLabels;
  int get xAxisOffset => _xAxisOffset;
  int get barValuePrecision => _barValuePrecision;
  
  void setChartData (List<List<double>> chartData)
  {
    
    _chartData = chartData;
    _chartDataIterator = _chartData.iterator;
    _largestValue = calcMaxDataValue();
    if(_xAxisLabels.length != _chartData.length) throw new StateError("number of labels supplied does not match number of chart bars");
    _numOfBars = _chartData.length;
    _barWidth = (_graphAreaWidth / _numOfBars) - (_margin * 2);
    _ratioY = _graphAreaHeight / _largestValue;
    _ratioX = _graphAreaWidth / _largestValue;
    _gridHeight = toPixelsY((_gridResolution).toDouble());
    _gridWidth = toPixelsX(_gridResolution.toDouble());
  }
  set yAxisOffset(int yAxisOffset) => _yAxisOffset = yAxisOffset;
  set chartColors(List<String> chartColors) => _chartColors = chartColors;
  set xAxisLabels(List<String> xAxisLabels) => _xAxisLabels = xAxisLabels;
  set font(String font) => _font = font;
  set xAxisOffset(int xAxisOffset) => _xAxisOffset= xAxisOffset;
  set barValuePrecision(int barValuePrecision) => _barValuePrecision = barValuePrecision;
}
