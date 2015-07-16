part of chart;
class dPieChart extends dChart
{
  // param: container - DivElement, div container for the canvas element that will contain the graph.
  // param: chartColors - List<RgbColor>, containing chart colors for each segment. The number of colors must match number of segments specified.
  dPieChart(DivElement container, List<RgbColor> chartColors):super(container, chartColors, null, null, null,null)  
  {
    if(_labels != null && !_labels.isEmpty)
      _includeLabels = true;
  }

  //chartData in piecharts is represented by List<double>. Each value represents a segment.
  //number of segments must match number of specified labels. 
  //if labels are not specifed each segment will have its persentige as a label.
  void setChartData(List<double> chartData)
  {
    _chartData = chartData;
    _chartDataIterator = _chartData.iterator;
    _calculateAngels(_chartData);
  }
  
  List<double> _calculateAngels(List<double> chartData)
  {
    double total = _sumTo(_chartData,_chartData.length);
    double angle = 0.0;
    List<double> angels = new List(); 
    chartData.forEach((double part)
    {
      angle = 0.0;
      angle = (part / total) * 360; 
      angels.add(angle);
    });
    _angels = angels;
    return angels;
  }


  void draw() 
  {
    super.draw();
    if(_chartData.length == _chartColors.length)
    {
      for (var i = 0; i < _angels.length; i++) 
        _drawSegment(_canvas, _context, i, _angels[i], false, _includeLabels);
    }
    else
      throw(new StateError("number of colors must match number of segments"));
  }

  void _drawSegment (CanvasElement canvas, var context, int i, double size, bool isSelected, bool includeLabels) 
  {
    context.save();
    int centerX = (canvas.width / 2).floor();
    int centerY = (canvas.height / 2).floor();
    int radius  = (canvas.width / 2).floor();
    //starting angle is sum of previously drawn angles
    var startingAngle = _degreesToRadians(_sumTo(_angels, i));
    var arcSize = _degreesToRadians(size);
    //ending angle is sum of previously drawn angles plus current angle that is being drawn.
    var endingAngle = startingAngle + arcSize;
  
    context.beginPath();
    context.moveTo(centerX, centerY);
    context.arc(centerX, centerY, radius, startingAngle, endingAngle, false);
    context.closePath();
    context.fillStyle = _chartColors[i].toCssString();
    context.fill();
    context.restore();
    if (_includeLabels) _drawLabel(i);
  }
  
  void _drawSegmentLabel(CanvasElement canvas, var context, int i, bool isSelected) 
  {
    context.save();
    int x = (canvas.width / 2).floor();
    int y = (canvas.height / 2).floor();
    double angle;
    double angleD = _sumTo(_angels, i);
    //if sum of already drawn segments angels is bigger then 270 or lesser then 90 flip the lable.
    bool flip = (angleD < 90 || angleD > 270) ? false : true;

    context.translate(x, y);
    if (flip) 
    {
      angleD = angleD - 180;
      context.textAlign = "left";
      angle = _degreesToRadians(angleD);
      context.rotate(angle);
      context.translate(-(x + (canvas.width * 0.5))+15, - (canvas.height * 0.05)-3);
    }
    else 
    {
      context.textAlign = "right";
      angle = _degreesToRadians(angleD);
      context.rotate(angle);
    }
    
    int fontSize = (canvas.height / 18).floor();
    if (_font == null) 
      _font = "bold " + fontSize.toString() + "px" + " sans-serif";
    context.font = _font;
    var dx = (canvas.width * 0.5).floor() - 10;
    var dy = (canvas.height * 0.05).floor();
    
    if (_labels != null && _labels.length == _chartData.length)
      context.fillText(_labels[i], dx, dy);
    else if (_labels == null && _includeLabels)
      context.fillText((_angels[i] / 360 * 100).toStringAsPrecision(_precision) + "%", dx, dy); 
    else
      throw(new StateError("number of data segments must be the same as number of labels"));
  context.restore();
  }
  
  void _drawLabel (int i) 
  {
    _drawSegmentLabel(_canvas, _context, i,  false);
  }
  // helper functions
  double _degreesToRadians (degrees) 
  {
    return (degrees * PI)/180;
  }
  
  List<String> _labels;
  List<RgbColor> _chartColors;
  bool _includeLabels = true;
  List<double> _angels;
  int _precision = 4;
  //getters och setters 
  get chartData => _chartData;
  get labels => _labels;
  set font (String font) => _font = font;
  set precsion (int precision) => _precision  = precision;
  set labels (List<String> labels) => _labels = labels;
  set includeLabels (bool includeLabels) => _includeLabels = includeLabels;
}
