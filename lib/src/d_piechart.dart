part of chart;
class dPieChart extends dChart
{
  // param: includeLabels - boolean, determines whether to include the specified labels when drawing the chart. If false, the labels are stored in the pie chart but not drawn by default. You can draw a label for a segment with  the drawLabel method.
  // param: chartData - List<int>, List of data items. Should be positive integer adding up to 360.
  // param: labels - List<String>, List of labels. Should have at least as many items as data.
  // param: chartColors List of Lists (string) chartColors. First is used to draw segment, second to draw a selected segment.
  dPieChart(DivElement container, List<List<String>> chartColors):super(container, chartColors, null, null, null,null)  
  {
    if(_labels != null && !_labels.isEmpty)
    {
      _includeLabels = true;
    }
  }
  double calcMaxDataValue()
  {
    return 1.1;
  }
  void renderHorisontalLabels()
  {
    
  }
  
  void setChartData(List chartData)
  {
    _chartData = chartData;
    _chartDataIterator = _chartData.iterator;
  }
  
  void select(int segment)
  {
    for(int i=0; i <_chartData.length; i++)
    {
      drawSegment(_canvas,_context,segment,_chartData[segment], true, _includeLabels);
    }  
  }

  void draw() 
  {
    super.draw();
    for (var i = 0; i < _chartData.length; i++) 
      drawSegment(_canvas, _context, i, _chartData[i], false, _includeLabels);
  }

  void drawSegment (CanvasElement canvas, var context, int i, int size, bool isSelected, bool includeLabels) 
  {
    context.save();
    int centerX = (canvas.width / 2).floor();
    int centerY = (canvas.height / 2).floor();
    int radius  = (canvas.width / 2).floor();
    
    var startingAngle = degreesToRadians(sumTo(_chartData, i));
    var arcSize = degreesToRadians(size);
    var endingAngle = startingAngle + arcSize;
  
    context.beginPath();
    context.moveTo(centerX, centerY);
    context.arc(centerX, centerY, radius, startingAngle, endingAngle, false);
    context.closePath();
    
    isSelected ? context.fillStyle = _chartColors[i][1] : context.fillStyle = _chartColors[i][0];
    
    context.fill();
    context.restore();
  
    if (_labels != null)
    {
      drawSegmentLabel(canvas, context, i, isSelected);
    }
  }
  
  void drawSegmentLabel(CanvasElement canvas, var context, int i, bool isSelected) 
  {
    context.save();
    var x = (canvas.width / 2).floor();
    var y = (canvas.height / 2).floor();
    var angle;
    var angleD = sumTo(_chartData, i);
    var flip = (angleD < 90 || angleD > 270) ? false : true;

    context.translate(x, y);
    if (flip) 
    {
      angleD = angleD-180;
      context.textAlign = "left";
      angle = degreesToRadians(angleD);
      context.rotate(angle);
      context.translate(-(x + (canvas.width * 0.5))+15, - (canvas.height * 0.05)-10);
    }
    else 
    {
      context.textAlign = "right";
      angle = degreesToRadians(angleD);
      context.rotate(angle);
    }
    //context.textAlign = "right";
    int fontSize = (canvas.height / 25).floor();
    context.font = fontSize.toString() + "pt Helvetica";

    var dx = (canvas.width * 0.5).floor() - 10;
    var dy = (canvas.height * 0.05).floor();
    context.fillText(_labels[i], dx, dy);

    context.restore();
  }
  
  void drawLabel (int i) 
  {
    drawSegmentLabel(_canvas, _context, i,  false);
  }
  // helper functions
  double degreesToRadians (degrees) 
  {
    return (degrees * PI)/180;
  }
  
  int sumTo(a, i) 
  {
    var sum = 0;
    for (var j = 0; j < i; j++) {
      sum += a[j];
  }
    return sum;
  }
  //public fields
  List<String> _labels;
  List<List<String>> _chartColors;
  bool _includeLabels;
  //getters och setters for public fields
  get chartData => _chartData;
  get labels => _labels;
  get chartColors => _chartColors;
  set labels (List<String> labels) => _labels = labels;
  set chartColors (List<List<String>> chartColors) => _chartColors = chartColors;
}
