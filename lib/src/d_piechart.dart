part of chart;
class dPieChart extends dChart
{
  // param: container - DivElement, div container for the canvas element that will contain the graph.
  // param: chartColors - List, containing chart colors
  dPieChart(DivElement container, List<RgbColor> chartColors):super(container, chartColors, null, null, null,null)  
  {
    if(_labels != null && !_labels.isEmpty)
    {
      _includeLabels = true;
    }
  }

  void setChartData(List<double> chartData)
  {
    _chartData = chartData;
    _chartDataIterator = _chartData.iterator;
    calculateAngels(_chartData);
  }
  
  List<double> calculateAngels(List<double> chartData)
  {
    double total = sumTo(_chartData,_chartData.length);
    double angle = 0.0;
    List<double> angels = new List(); 
    chartData.forEach((double part)
    {
      double angle = 0.0;
      angle = (part / total) * 360; 
      angels.add(angle);
    });
    _angels = angels;
    print(_angels);
    return angels;
  }


  void draw() 
  {
    super.draw();
    for (var i = 0; i < _angels.length; i++) 
      drawSegment(_canvas, _context, i, _angels[i], false, _includeLabels);
  }

  void drawSegment (CanvasElement canvas, var context, int i, double size, bool isSelected, bool includeLabels) 
  {
    context.save();
    int centerX = (canvas.width / 2).floor();
    int centerY = (canvas.height / 2).floor();
    int radius  = (canvas.width / 2).floor();
    
    var startingAngle = degreesToRadians(sumTo(_angels, i));
    var arcSize = degreesToRadians(size);
    var endingAngle = startingAngle + arcSize;
  
    context.beginPath();
    context.moveTo(centerX, centerY);
    context.arc(centerX, centerY, radius, startingAngle, endingAngle, false);
    context.closePath();
    context.fillStyle = _chartColors[i].toCssString();
    context.fill();
    context.restore();

      drawSegmentLabel(canvas, context, i, isSelected);
  }
  
  void drawSegmentLabel(CanvasElement canvas, var context, int i, bool isSelected) 
  {
    context.save();
    int x = (canvas.width / 2).floor();
    int y = (canvas.height / 2).floor();
    double angle;
    double angleD = sumTo(_angels, i);
    bool flip = (angleD < 90 || angleD > 270) ? false : true;

    context.translate(x, y);
    if (flip) 
    {
      angleD = angleD - 180;
      context.textAlign = "left";
      angle = degreesToRadians(angleD);
      context.rotate(angle);
      context.translate(-(x + (canvas.width * 0.5))+15, - (canvas.height * 0.05)-3);
    }
    else 
    {
      context.textAlign = "right";
      angle = degreesToRadians(angleD);
      context.rotate(angle);
    }
    //context.textAlign = "right";
    int fontSize = (canvas.height / 20).floor();
    context.font = "bold " + fontSize.toString() + "px" + " sans-serif";
    var dx = (canvas.width * 0.5).floor() - 10;
    var dy = (canvas.height * 0.05).floor();
    if(_labels != null && _labels.length == _chartData.length)
      context.fillText(_labels[i], dx, dy);
    else if (_labels == null)
      context.fillText((_angels[i] / 360 * 100).toStringAsPrecision(4) + " %", dx, dy); 
    else
      throw(new StateError("number of data segments must be the same as number of labels"));
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
  
  double sumTo(a, i) 
  {
    double sum = 0.0;
    for (var j = 0; j < i; j++) {
      sum += a[j];
  }
    return sum;
  }
  //public fields
  List<String> _labels;
  List<RgbColor> _chartColors;
  bool _includeLabels;
  List<double> _angels;
  //getters och setters for public fields
  get chartData => _chartData;
  get labels => _labels;
  get chartColors => _chartColors;
  set labels (List<String> labels) => _labels = labels;
  set chartColors (List<RgbColor> chartColors) => _chartColors = chartColors;
}
