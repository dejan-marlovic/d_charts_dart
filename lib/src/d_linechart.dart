part of chart;

class dLineChart extends dChart 
{
  dLineChart(DivElement container, List<String> chartColors, int gridResolution, int unitX, int unitY, String font)
  :super(container, chartColors, gridResolution, unitX, unitY, font) 
  {

  }
  
  
  void setChartData(List<List<dDataPoint>> chartData)
  {
    _chartData = chartData;
    _chartData.forEach((graph)=> graph.sort());
    _chartDataIterator = _chartData.iterator;
  }
  
  void draw() 
  {
    super.draw();
    renderVerticalGrid();
    _chartData.forEach((graph) 
    {
      graph.forEach(renderDataPoint);
      renderLines(graph);
    });
  }
  void renderDataPoint(dDataPoint dp) 
  {
    _context.beginPath();
    _context.fillStyle = _chartColors[_color];
    _context.arc(toPixelsX(dp.x) + _xAxisOffset, _graphAreaPixelHeight - toPixelsY(dp.y), 5, 0,2 * PI, false);
    _context.fill();
    _context.closePath();
  }

  void renderLines(List<dDataPoint> path) 
  {

    Iterator iterator = path.iterator;
    _context.fillStyle = _chartColors[_color];
    _context.strokeStyle = _chartColors[_color];
    _context.lineWidth = 2;
    _context.beginPath();
   // _context.moveTo(_xAxisOffset, _graphAreaHeight);

    while (iterator.moveNext()) 
    {
      _context.lineTo(toPixelsX(iterator.current.x) + _xAxisOffset, _graphAreaPixelHeight-toPixelsY(iterator.current.y));
    }
    _context.stroke();
    _context.closePath();
    _color > _chartColors.length ? _color = 0 : _color++;
  }

  double calcMaxDataValue() 
  {
    _chartData.forEach((line) 
    {
      line.forEach((dp) 
      {
        if (dp.y > _maxYValue) _maxYValue = dp.y;
        if (dp.x > _maxXValue) _maxXValue = dp.x;
      });
    });
    _maxYValue *= 1.1;
    _maxXValue *= 1.1;
    
    return _maxYValue;
  }  

   void renderHorisontalLabels() 
   {
   int noOfVerticalGrids = _graphAreaUnitHeight ~/_gridResolution;  
   if (_xAxisLabels != null)
   {
     if(noOfVerticalGrids == _xAxisLabels.length)
     {
       int currentX = _gridResolution;
       _context.textAlign = "center";
       _context.font  = _font;
       _context.fillStyle = "black";
       _xAxisLabels.forEach((label)
       {  
        _context.fillText(label, toPixelsX(currentX.toDouble()) + _xAxisOffset ,_graphAreaPixelHeight + _yAxisOffset);  
        currentX += _gridResolution;   
       });
     }
     else 
        throw (new StateError("you need do specify " + noOfVerticalGrids.toString() + " x-axis labels"));
   }
 else
 {
   _context.textAlign = "center";
   _context.font  = _font;
   _context.fillStyle = "black";
   int currentX;
   currentX = _gridResolution;
   String value;
   while (currentX <= _graphAreaUnitWidth)   
   {
     value = currentX.toString();
     _context.fillText(value, toPixelsX(currentX.toDouble()) + _xAxisOffset ,_graphAreaPixelHeight + _yAxisOffset);
     currentX += _gridResolution;
   }
 }

 }

 drawProjected(String color, int graphIndex, {int extensionX})
 {
      double meanX=0.0;
      double meanY=0.0;
      double varianceX=0.0;
      double varianceY=0.0;
      double sumX=0.0;
      double sumY=0.0;
      double sumX2=0.0;
      double sumY2=0.0;
      double sumXY=0.0;
      
      List<dDataPoint> targetGraph = _chartData[graphIndex];
      int n = targetGraph.length;
      
      targetGraph.forEach((dp)
      {
        meanX += dp.x;
        meanY += dp.y;
      });
      meanY = meanY / n;
      meanX  = meanX / n;
      
      targetGraph.forEach((dp)
      {
       varianceX += (dp.x - meanX)*(dp.x - meanX); 
       varianceY += (dp.y - meanY)*(dp.y - meanY); 
       sumX2 += dp.x * dp.x;
       sumY2 += dp.y * dp.y;
       sumXY += dp.y*dp.x;
       sumX += dp.x;
       sumY += dp.y;
      });
      varianceX = varianceX/n;
      varianceY = varianceY/n;
      double p;
      double standardDeviationX = sqrt(varianceX).abs();
      double standardDeviationY = sqrt(varianceY).abs();
      p = sqrt((n * sumX2 - sumX*sumX)*(n * sumY2 - sumY*sumY));
      double pearsonsCorrelation  = ((n * sumXY) - sumX * sumY) / p;
      
      double regressionLineCoefficient = pearsonsCorrelation * (standardDeviationY/standardDeviationX);
      double yIntercept = meanY - regressionLineCoefficient * meanX;
      _context.beginPath();
      
      if(extensionX != null)
      {
        extensionX *= _gridResolution;
        _context.moveTo(_xAxisOffset,_graphAreaPixelHeight - toPixelsY(yIntercept));
        _context.lineTo(_xAxisOffset  + toPixelsX(extensionX.toDouble()), _graphAreaPixelHeight -  toPixelsY(regressionLineCoefficient * extensionX + yIntercept));
      }
      else
      { 
        _context.moveTo(_xAxisOffset,_graphAreaPixelHeight - toPixelsY(yIntercept));
        _context.lineTo(_xAxisOffset + toPixelsX(targetGraph.last.x),_graphAreaPixelHeight - toPixelsY(regressionLineCoefficient * targetGraph.last.x + yIntercept));
      }
      _context.strokeStyle = color;
      _context.stroke();
      _context.closePath();
 }
 
 double calcAverageCoefficient(List<dDataPoint> dataPoints)
 {
   Iterator dataPointIterator = dataPoints.iterator;
   double coefficient = 0.0;
   dDataPoint previous = new dDataPoint(0.0, 0.0);
   
   while (dataPointIterator.moveNext())
   {     
     double dX = previous.x - dataPointIterator.current.x;
     double dY = previous._y - dataPointIterator.current.y;
     
     coefficient += (dY/dX);     
     previous = dataPointIterator.current;     
   }
   
   return coefficient / dataPoints.length;
 }

int _color = 0;
double _maxYValue = 0.0;
double _maxXValue = 0.0;
List<String> _xAxisLabels;
get  xAxisLabels => _xAxisLabels;
set xAxisLabels (List <String> xAxisLabels) => _xAxisLabels = xAxisLabels;
}

class dDataPoint extends Comparable
{
  dDataPoint(double x, double y) 
  {
    _x = x;
    _y = y;
  }
  double _x;
  double _y;
  get x => _x;
  get y => _y;
  
  int compareTo(dDataPoint other)
  {
    if(this._x < other._x) return -1;
    else if (this._x > other._x) return 1;
    else return 0;
  }
}