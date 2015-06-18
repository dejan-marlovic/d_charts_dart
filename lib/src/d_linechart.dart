part of chart;

class dLineChart extends dChart 
{
  dLineChart(DivElement container, List<String> chartColors, int gridResolution):super(container, chartColors, gridResolution) 
  {

  }
  
  
  void setChartData(List<List<dDataPoint>> chartData)
  {
    _chartData = chartData;
    calcMaxDataValue();
    _ratioY = (_graphAreaHeight.toDouble() / _maxYValue).roundToDouble();
    _ratioX = (_graphAreaWidth.toDouble() / _maxXValue).roundToDouble();
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
    _context.arc(toPixelsX(dp.x) + _xAxisOffset, _graphAreaHeight - toPixelsY(dp.y), 5, 0,2 * PI, false);
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
    _context.moveTo(_xAxisOffset, _graphAreaHeight);

    while (iterator.moveNext()) 
    {
      _context.lineTo(toPixelsX(iterator.current.x) + _xAxisOffset, _graphAreaHeight-toPixelsY(iterator.current.y));
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
   int noOfVerticalGrids = (_graphAreaWidth/toPixelsX(_gridResolution.toDouble())).floor();  
   if (_xAxisLabels != null)
   {
     if(noOfVerticalGrids == _xAxisLabels.length)
     {
       int gridWidth = toPixelsX(_gridResolution.toDouble());
       int currentX = gridWidth;
       _context.textAlign = "center";
       _context.font  = "bold 12px sans-serif";
       _context.fillStyle = "black";
       _xAxisLabels.forEach((label)
       {  
        _context.fillText(label, currentX + _xAxisOffset ,_graphAreaHeight + _yAxisOffset);  
        currentX += gridWidth;   
       });
     }
     else 
        throw (new StateError("you need do specify " + noOfVerticalGrids.toString() + " x-axis labels"));
   }
 else
 {
   _context.textAlign = "center";
   _context.font  = "bold 12px sans-serif";
   _context.fillStyle = "black";
   int currentX;
   int girdWidth = (toPixelsX((_gridResolution).toDouble()));
   currentX = girdWidth;
   String value;
   while (currentX < _graphAreaWidth)   
   {
     value = toRelativeX(currentX).toString();
     _context.fillText(value, currentX + _xAxisOffset ,_graphAreaHeight + _yAxisOffset);
     currentX += girdWidth;
   }
 }

 }

int _color = 0;
List<String> _xAxisLabels;
get  xAxisLabels => _xAxisLabels;
set xAxisLabels (List <String> xAxisLabels) => _xAxisLabels = xAxisLabels;
}
class dDataPoint 
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
}