part of chart;
class dLineChart extends dChart
{
  dLineChart({DivElement container:null, List<List<dDataPoint>> chartData:null, List<String> chartColors:null}):super(container, chartData, chartColors)  
  {
    getMaxDataValue();
    _ratioY = _canvas.height /_maxYValue;
    _ratioX =  _canvas.width / _maxXValue;
  
  }
  void draw()
  {
    
    _chartData.forEach((line)
    {
      line.forEach(renderDataPoints);
      renderLines(line);
      
    });
    
  }
  void renderDataPoints(dDataPoint dp)
  {
    
    _context.beginPath();
    _context.fillStyle = _chartColors[_color]; 
    _context.arc(dp.x *_ratioX - 10, _canvas.height - (dp.y * _ratioY - 10), 5, 0, 2 * PI, false);
    _context.fill();
    _context.closePath();
  }
  
  void renderLines(List<dDataPoint> line)
  {
    
    Iterator iterator = line.iterator;
    _context.fillStyle = _chartColors[_color]; 
    _context.strokeStyle = _chartColors[_color]; 
    _context.lineWidth = 2;
    _context.beginPath();
    _context.moveTo(0, _canvas.height);
    
    while (iterator.moveNext())
    {
     _context.lineTo(iterator.current.x *_ratioX - 10, _canvas.height - (iterator.current.y * _ratioY - 10));    
    }
    _context.stroke();
    _context.closePath();
    _color > _chartColors.length ? _color = 0 : _color++;
  }
  
  void getMaxDataValue()  
  {
      
    _chartData.forEach((line)
    {
      line.forEach((dp)
      {
        if (dp.y > _maxYValue) _maxYValue = dp.y;
        if (dp.x > _maxXValue) _maxXValue = dp.x; 
       
      });
    });
  }
  
double _maxYValue = 0.00;
double _maxXValue = 0.00;
double _ratioY = 0.00;
double _ratioX = 0.00;
int _color=0;
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