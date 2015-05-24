
part of chart;

class dBarChart extends dChart
{
// param: margin - int, distince between the chart bars.
// param: chartData - List<List<double>>, chart data representing each part of the bar. List of List<double> is used so that each part of the bar can be represented.
// param: xAxisLabels - List<String>, List of x-axis labels.
// param: yAxisLabels - List<String>, List of y-axis labels.(not implemented).
// param: font - String, font for x-axis labels in context object format. 
// param: xAxisLabelsRoom - int, room to be made for xAxisLabels.
// param: barValuePrecision - int, precision for bar value labels.
  dBarChart({DivElement container:null, int margin:0, List<List<double>> chartData:null, List<String> chartColors:null, List<String> xAxisLabels:null, List<String> yAxisLabels:null, String font:"bold 12px sans-serif", int xAxisLabelsRoom:40, int yAxisOffset:25, int barValuePrecision:3}):super(container, chartData, chartColors)  
  {
    
    _margin = margin;
    _xAxisLabels = xAxisLabels;
    _yAxisLabels = yAxisLabels;
    _font = font;
    _barValuePrecision = barValuePrecision;
    _xAxisLabelsRoom = xAxisLabelsRoom;
    _yAxisOffset = yAxisOffset;
  }

  // Method for drawing a  bar chart
  void draw() 
  {
    int numOfBars = _chartData.length;
    double barWidth;
    double ratio;
    double largestValue;
    int graphAreaWidth = _canvas.width;
    int graphAreaHeight = _canvas.height;
    int bar;
    double barValue;

    // If x axis labels exist then make room
    if (_xAxisLabels.length > 0) 
    {
      graphAreaHeight -= _xAxisLabelsRoom +_yAxisOffset;
    }
    
    // Calculate dimensions of the bar
    barWidth = (graphAreaWidth / numOfBars) - (_margin * 2);
    
    // Determine the largest bar value
    largestValue = 0.0;
    barValue = 0.0;   
    for (bar = 0; bar < _chartData.length; bar += 1) 
    {
      //sum all the parts of a bar
      barValue = sumTo(_chartData[bar], _chartData[bar].length);
      
      if (barValue > largestValue) 
      {
        largestValue = barValue;
      }
    }
    // Set the ratio of current bar compared  to largest value
    ratio = graphAreaHeight / largestValue;
    
    //For each bar
    for (bar = 0; bar < _chartData.length; bar += 1) 
    {
      double barValue  = sumTo(_chartData[bar], _chartData[bar].length);
      double top = 0.0;
      double left = 0.0;
      
      //first part of the bars start att y = graph area height, since the top corner of the graph area is 0  
      double bottom = graphAreaHeight.toDouble() +_yAxisOffset;
      
      //For each part of the bar
      int color = 0;
      for (int cat = 0; cat < _chartData[bar].length; cat++) 
      {          
        //calculate x and y value for each part of the bar
        left = _margin + bar * graphAreaWidth / numOfBars;
        double height = _chartData[bar][cat] * ratio;
        top = bottom - height;
        // Draw bar background for each part
        _context.fillStyle = "#333";
        _context.fillRect(left, top, barWidth, height); 
        //pick next color from chosen colors for each part of bar, if all have been used repeat
        color++;
        if (color == _chartColors.length) 
          color = 0;
        //fill in the color of each part of the bar 
        _context.fillStyle = _chartColors[color];
        _context.fillRect(left, top, barWidth, height);   
        //previous part of the bars top is next parts bottom
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
     _context.fillText(barValue.toStringAsPrecision(_barValuePrecision),left + barWidth/2,top - 4);
    } catch (ex) {}
   
    if (_xAxisLabels.length > 0) 
    {        
     // Use try / catch to stop IE 8 from going to error town        
     _context.fillStyle = "black";
     _context.font = _font;
     _context.textAlign = "center";
     try 
     {
       _context.fillText(_xAxisLabels[bar],left + barWidth/2 ,_canvas.height - _yAxisOffset);
     } catch (ex) {}
     }
   }
  }
  double sumTo(a, i) 
  {
    var sum = 0;
    for (var j = 0; j < i; j++) 
    {
      sum += a[j];
    }
    return sum;
  }
  //private fields
  DivElement _container;
  var _context;
  CanvasElement _canvas;

  //public fields
  int _margin;  
  List<List<double>> _chartData;
  List<String> _chartColors;
  List<String> _xAxisLabels;
  List<String> _yAxisLabels;
  int _xAxisLabelsRoom;
  String _font; 
  int _yAxisOffset;
  int _barValuePrecision;

  //getters and setters for public fields
  int get margin => _margin;
  List<List<double>> get chartData => _chartData;
  int get  yAxisOffset =>  _yAxisOffset;
  String get font => _font;
  List<String> get chartColors => _chartColors;
  List<String> get xAxisLabels => _xAxisLabels;
  List<String> get yAxisLabels => _yAxisLabels;
  int get xAxisLabelsRoom => _xAxisLabelsRoom;
  int get barValuePrecision => _barValuePrecision;
  
  set margin(int margin) => _margin = margin;
  set yAxisOffset(int yAxisOffset) => _yAxisOffset = yAxisOffset;
  set chartColors(List<String> chartColors) => _chartColors = chartColors;
  set xAxisLabels(List<String> xAxisLabels) => _xAxisLabels = xAxisLabels;
  set font(String font) => _font = font;
  set xAxisLabelsRoom(int xAxisLabelsRoom) => _xAxisLabelsRoom = xAxisLabelsRoom;
  set barValuePrecision(int barValuePrecision) => _barValuePrecision = barValuePrecision;
}
