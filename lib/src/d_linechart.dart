part of chart;

class dLineChart extends dChart 
{
  // param: container - DivElement, div container for the canvas element that will contain the graph.
  // param: chartColors - List<RgbColor>, containing Rgb colors for each line in line chart. If the number of colors specified is lesser then number of lines the colors will be reused.
  // param: gridResolution - int, gridResolution is used to calculate horisontal grid height and vertical grid width.
  // param: graphtAreaUnitWidth - int, graph area width specified in units. Specified value must be heigher then heighest x-value of all datapoints in the specific graph if entire graph is to be shown. 
  // param: graphtAreaUnitHeight - int, graph area height specified in units. Specified value must be heigher then heighest y-value of all datapoints in the specific graph if entire graph is to be shown.
  // param: font - String, font to be used for drawing y and x-axis labels. Font is to be specified in context object format ex: bold 10px sans-serif
  dLineChart(DivElement container, List<RgbColor> chartColors, int gridResolution, int graphtAreaUnitWidth, int graphtAreaUnitHeight, String font)
  :super(container, chartColors, gridResolution, graphtAreaUnitWidth, graphtAreaUnitHeight, font) 
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
    renderHorisontalLabels();
    _chartData.forEach((graph) 
    {
      graph.forEach(renderDataPoint);
      renderLines(graph);
    });
  }
  void renderDataPoint(dDataPoint dp) 
  {
    _context.beginPath();
    _context.fillStyle = _chartColors[_color].toCssString();
    _context.arc(toPixelsX(dp.x) + _xAxisOffset, toPixelPositionY((dp.y)), 5, 0,2 * PI, false);
    _context.fill();
    _context.closePath();
  }

  void renderLines(List<dDataPoint> path) 
  {

    Iterator iterator = path.iterator;
    _context.fillStyle = _chartColors[_color].toCssString();
    _context.strokeStyle = _chartColors[_color].toCssString();
    _context.lineWidth = 2;
    _context.beginPath();
    while (iterator.moveNext()) 
    {
      _context.lineTo(toPixelsX(iterator.current.x) + _xAxisOffset, toPixelPositionY(iterator.current.y));
    }
    _context.stroke();
    _context.closePath();
    _color > _chartColors.length ? _color = 0 : _color++;
  }
  
   void renderHorisontalLabels() 
   {
   _context.textAlign = "center";
   _context.font  = _font;
   _context.fillStyle = "black";  
   
   int noOfVerticalGrids = _graphAreaUnitHeight ~/_gridResolution;  
   if (_xAxisLabels != null)
   {
     if(noOfVerticalGrids == _xAxisLabels.length)
     {
       int currentX = _gridResolution;
       _xAxisLabels.forEach((label)
       {  
        _context.fillText(label, toPixelsX(currentX.toDouble()) + _xAxisOffset ,_graphAreaPixelHeight + _yAxisOffset);  
        currentX += _gridResolution;   
       });
     }
     else 
        throw (new StateError("you need to specify " + noOfVerticalGrids.toString() + " x-axis labels"));
   }
   else
   {
     int currentX = _gridResolution;
     String value;
     while (currentX <= _graphAreaUnitWidth)   
     {
       value = currentX.toString();
       _context.fillText(value, toPixelsX(currentX.toDouble()) + _xAxisOffset ,_graphAreaPixelHeight + _yAxisOffset);
       currentX += _gridResolution;
     }
    }
 }
   
 calculateProjected(List <dDataPoint> dataPoints, {int extensionX})
 {
   //we have to reset variables before each calculation
   _meanX = 0.0; 
   _meanY = 0.0;
   _varianceX = 0.0;
   _varianceY = 0.0;  
   _sumX = 0.0; 
   _sumY = 0.0;
   _sumX2 = 0.0; 
   _sumY2 = 0.0; 
   _sumXY = 0.0; 
   _standardDeviationX =  0.0; 
   _standardDeviationY = 0.0;
   _pearsonsCorrelation = 0.0;  
   _regressionLineCoefficient = 0.0; 
   _regressonLineStartValue = 0.0; 
   _regressonLineEndValue = 0.0; 
   _regressionLineExtensionEndValue = 0.0; 
   
   int n = dataPoints.length;
   
   dataPoints.forEach((dp)
   {
     _meanX += dp.x;
     _meanY += dp.y;
   });
   //calculate mean
   _meanY = _meanY / n;
   _meanX  = _meanX / n;
   
   dataPoints.forEach((dp)
   {
    _varianceX += (dp.x - _meanX) * (dp.x - _meanX); 
    _varianceY += (dp.y - _meanY) * (dp.y - _meanY); 
    _sumX2 += dp.x * dp.x;
    _sumY2 += dp.y * dp.y;
    _sumXY += dp.y * dp.x;
    _sumX += dp.x;
    _sumY += dp.y;
   });
   //calculate variance
   _varianceX = _varianceX / n;
   _varianceY = _varianceY / n;
   _standardDeviationX = sqrt(_varianceX).abs();
   _standardDeviationY = sqrt(_varianceY).abs();
   _pearsonsCorrelation  = ((n * _sumXY) - _sumX * _sumY) /  sqrt((n * _sumX2 - _sumX * _sumX)*(n * _sumY2 - _sumY * _sumY));

   _regressionLineCoefficient = _pearsonsCorrelation * (_standardDeviationY / _standardDeviationX);
   //regression line starts y-Axis intercept
   _regressonLineStartValue = _meanY - _regressionLineCoefficient * _meanX;
   _regressonLineEndValue = _regressionLineCoefficient * dataPoints.last.x + _regressonLineStartValue;
   if (extensionX != null) _regressionLineExtensionEndValue = _regressionLineCoefficient * (extensionX + dataPoints.last.x) + _regressonLineStartValue;
   
 }
 
 drawProjected({int graph_index, int extension_x})
 {
      int  extensionX  =  extension_x; 
      int graphIndex = graph_index;
      if (graphIndex != null && graphIndex < _chartData.length && graphIndex >= 0)
      {
        List<dDataPoint> targetGraph = _chartData[graphIndex];
        calculateProjected(targetGraph, extensionX : (extension_x == null) ? 0 : extension_x);
          
        _context.beginPath();
        if(extensionX != 0)
        {
          _context.moveTo(_xAxisOffset, toPixelPositionY(_regressonLineStartValue));
          _context.lineTo(_xAxisOffset  + toPixelsX(targetGraph.last.x + extensionX.toDouble()),toPixelPositionY(_regressionLineExtensionEndValue));
        }
        else
        { 
          _context.moveTo(_xAxisOffset, toPixelPositionY(_regressonLineStartValue));
          _context.lineTo(_xAxisOffset + toPixelsX(targetGraph.last.x), toPixelPositionY(_regressonLineEndValue));
        }
        
        _context.strokeStyle =  ColorFilter.lighten(_chartColors[graph_index],[0.50,0.50,0.50]).toRgbColor().toCssString();
        _context.stroke();
        _context.closePath();
      }
      else
      {
        List<dDataPoint> allDataPoints = new List<dDataPoint>();
        _chartData.forEach((graph)
         {
          graph.forEach((dp)
          {
            allDataPoints.add(dp);
          });
         });
        allDataPoints.sort();
        calculateProjected(allDataPoints, extensionX : (extension_x == null) ? 0 : extension_x);

        _context.beginPath();
        if(extensionX != 0)
        {
          _context.moveTo(_xAxisOffset, toPixelPositionY(_regressonLineStartValue));
          _context.lineTo(_xAxisOffset  + toPixelsX(allDataPoints.last.x + extensionX.toDouble()),toPixelPositionY(_regressionLineExtensionEndValue));
        }
        else
        { 
          _context.moveTo(_xAxisOffset, toPixelPositionY(_regressonLineStartValue));
          _context.lineTo(_xAxisOffset + toPixelsX(allDataPoints.last.x), toPixelPositionY(_regressonLineEndValue));
        }
        RgbColor allDataPointsRegressionLineColor = new RgbColor(125,125,125);
        _context.strokeStyle = allDataPointsRegressionLineColor.toCssString();
        _context.stroke();
        _context.closePath();
      }  
        
}
 
List<String> _xAxisLabels;
get  xAxisLabels => _xAxisLabels;
set xAxisLabels (List <String> xAxisLabels) => _xAxisLabels = xAxisLabels;
int _color = 0;
double _meanX = 0.0, _meanY = 0.0,_varianceX = 0.0,_varianceY = 0.0 , _sumX = 0.0, _sumY = 0.0;
double _sumX2 = 0.0, _sumY2 = 0.0, _sumXY = 0.0, _standardDeviationX =  0.0, _standardDeviationY = 0.0;
double _pearsonsCorrelation = 0.0 , _regressionLineCoefficient = 0.0, _regressonLineStartValue = 0.0, _regressonLineEndValue = 0.0, _regressionLineExtensionEndValue = 0.0; 
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