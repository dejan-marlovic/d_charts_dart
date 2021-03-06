part of chart;

class dBarChart extends dChart 
{
  // param: container - DivElement, div container for the canvas element that will contain the graph.
  // param: margin - int, distance between the chart bars and between x-Axis and the first bar.
  // param: chartColors - List<RgbColor>, containing chart colors of type RgbColor, for each bar category (part of the bar). Colors specified will be repeated. 
  // param: gridResolution - int, grid resolution is used for calculation of horisontal grid height for bar charts. 
  // param: xAxisLabels - List<String>, labels that will appear under each bar. The number of labels must match the number of bars.
  // param: graphAreaUnitWidth - int, graph area width specified in units.
  // param: graphAreaUnitHeight - int, graph area height specified in units. Specified value must be heigher then largest bar if entire chart is to be shown.
  // param: font - String, font to be used for writing barcharts: y and x-axis labels and the value at the top of each bar. Font is to be specified in context object format ex: bold 10px sans-serif
  dBarChart(DivElement container, int margin, List<RgbColor> chartColors, int gridResolution, List<String> xAxisLabels, int graphAreaUnitWidth, int graphAreaUnitHeight, String font)
  : super(container, chartColors, gridResolution, graphAreaUnitWidth, graphAreaUnitHeight, font) 
  {
    _margin = margin;
    _barValuePrecision = 3;
    _xAxisLabels = xAxisLabels;
  }
  
  //chart data for bar charts is represented as List<List<double>> so that each part of the graph can be represented.
  //each list represents a bar, each list element represents part of a bar. (category)
  void setChartData (List<List<double>> chartData)
  {
    _chartData = chartData;
    _chartDataIterator = _chartData.iterator;
    if (_xAxisLabels.length != _chartData.length) 
      throw new StateError("number of labels supplied does not match number of chart bars");
    _numOfBars = _chartData.length;
    _barWidth = (_graphAreaPixelWidth / _numOfBars) - (_margin * 2);
  }

  void draw() 
  {
    super.draw();
    _renderHorisontalLabels();
    int bar;
    for (bar = 0; bar < _chartData.length; bar += 1) 
    {
      //sum each part of the bar to get each bar value
      double barValue = _sumTo(_chartData[bar], _chartData[bar].length);
      double top;
      double left;
      double bottom = _graphAreaPixelHeight.toDouble();
      double height;
      int color = 0;
      for (int cat = 0; cat < _chartData[bar].length; cat++) 
      {
        left = _margin + bar * _graphAreaPixelWidth / _numOfBars + _xAxisOffset;
        if (left > _canvas.width) throw new StateError("chart margin too big, bar out of visual bounds");
        height = _chartData[bar][cat] * _ratioY;
        top = bottom - height;
        _context.fillStyle = "#333";
        _context.fillRect(left, top, _barWidth, height);
        color++;
        if (color == _chartColors.length) color = 0;
        _context.fillStyle = _chartColors[color].toCssString();
        _context.fillRect(left, top, _barWidth, height);
        bottom = top;
      }
      _context.fillStyle = "black";
      _context.textAlign = "center";
      try 
      {
        _context.fillText(barValue.toStringAsPrecision(_barValuePrecision),left + _barWidth / 2, top - 4);
      } catch (ex) {}
    }
  }
  
  void _renderHorisontalLabels() 
  {
    if (_xAxisLabels.length > 0 && _chartData != null && _chartData.length != _xAxisLabels.length) 
      throw (new StateError("you have to specify" + _chartData.length.toString() + "labels for your chart"));
    if (_xAxisLabels.length > 0) 
    {
      _context.textAlign = "center";
      _context.font  = _font;
      _context.fillStyle = "black";
      try 
      {
        for (int i = 0; i < _xAxisLabels.length; i++) 
        {
          double left = _margin + i * _graphAreaPixelWidth / _numOfBars + _barWidth / 2 +_xAxisOffset;
          _context.fillText(_xAxisLabels[i],left,_graphAreaPixelHeight + _yAxisOffset-3);
        }
      } catch (ex) {}
    }
  }

  DivElement _container;
  var _context;
  int _margin, _barValuePrecision, _numOfBars;
  List<List<double>> _chartData;
  List<String>  _xAxisLabels;
  List<RgbColor> _chartColors;
  double _barWidth; 
 
  List<List<double>> get chartData => _chartData;
  String get font => _font;
  List<RgbColor> get chartColors => _chartColors;
  List<String> get xAxisLabels => _xAxisLabels;
  int get barValuePrecision => _barValuePrecision;
  
  set chartColors(List<RgbColor> chartColors) => _chartColors = chartColors;
  set xAxisLabels(List<String> xAxisLabels) => _xAxisLabels = xAxisLabels;
  set font(String font) => _font = font;
  set barValuePrecision(int barValuePrecision) => _barValuePrecision = barValuePrecision;
}
