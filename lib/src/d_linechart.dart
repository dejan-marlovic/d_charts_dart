part of chart;
class dLineChart extends dChart
{
  dLineChart(DivElement container, List<DataPoint> chartData, List<String> chartColors):super(container, chartData, chartColors)  
  {
    
  }
  void draw()
  {

  }
  
  void renderChart () 
  {
    renderBackground();
    renderLinesAndLabels();

    for (var i = 0; i < _chartData.length; i++) 
    {
        renderData(_chartData[i]);
    }
  }
  
  void render (dataObj) 
  {
    _data = dataObj;
    getMaxDataYValue();
    _xMax = _canvas.width - (_left + _right).toDouble();
    _yMax = _canvas.height - (_top + _bottom).toDouble();
    _ratio = _yMax / _maxYValue;
    renderChart();
  }
  
  void getMaxDataYValue()
  {
    for (var i = 0; i < _chartData.length; i++) 
    {
      if (_chartData[i].y > _maxYValue) _maxYValue = _chartData[i].y;
    }
  }
  
  void renderBackground()
  {
    var lingrad = _context.createLinearGradient(_left, _top, _xMax - _right, _yMax);
    lingrad.addColorStop(0.0, '#D4D4D4');
    lingrad.addColorStop(0.2, '#fff');
    lingrad.addColorStop(0.8, '#fff');
    lingrad.addColorStop(1, '#D4D4D4');
    _context.fillStyle = lingrad;
    _context.fillRect(_left, _top, _xMax - _left, _yMax - _top);
    _context.fillStyle = 'black';
  }
  
  void renderLinesAndLabels()   
  {
      //Vertical guide lines
      var yInc = _yMax / _chartData.length;
      var yPos = 0;
      var yLabelInc = (_maxYValue * _ratio) / _chartData.length;
      var xInc = getXInc();
      var xPos = _left;
      
      for (var i = 0; i < _chartData.length; i++) 
      {
          yPos += (i == 0) ? _top : yInc;
          //Draw horizontal lines
          drawLine(_left, yPos, _xMax, yPos, '#E8E8E8',2);
          //y axis labels
          _context.font = '10pt Calibri';
          var txt = (_maxYValue - ((i == 0) ? 0 : yPos / _ratio)).round();
          var txtSize = _context.measureText(txt);
          _context.fillText(txt, _left - ((txtSize.width >= 14) ? txtSize.width : 10) - 7, yPos + 4);

          //x axis labels
          txt = _chartData[i].x;
          txtSize = _context.measureText(txt);
          _context.fillText(txt, xPos, _yMax + (_bottom / 3));
          xPos += xInc;
      }

      //Vertical line
      drawLine(_left, _top, _left, _yMax, 'black',2);

      //Horizontal Line
      drawLine(_left, _yMax, _xMax, _yMax, 'black',2);
  }
  
   renderData () 
   {
     var xInc = getXInc();
     var prevX = 0, 
         prevY = 0;

     for (var i = 0; i < _chartData.length; i++) 
     {
         DataPoint pt = _chartData[i];
         double ptY = (_maxYValue - pt.y) * _ratio;
         if (ptY < _top) ptY = _top;
         var ptX = (i * xInc) + _left;
    
         //Draw connecting lines
         drawLine(ptX, ptY, prevX, prevY, 'black', 2);
        
         var radgrad = _context.createRadialGradient(ptX, ptY, 8, ptX - 5, ptY - 5, 0);
         radgrad.addColorStop(0, 'Green');
         radgrad.addColorStop(0.9, 'White');
         _context.beginPath();
         _context.fillStyle = radgrad;
         //Render circle
         _context.arc(ptX, ptY, 8, 0, 2 * PI, false);
         _context.fill();
         _context.lineWidth = 1;
         _context.strokeStyle = '#000';
         _context.stroke();
         _context.closePath();
         prevX = ptX;
         prevY = ptY;
     }
   }
  
   int getXInc() 
   {
       return ((_xMax / _chartData.length) - 1).round();
   }
   
   void drawLine(startX, startY, endX, endY, strokeStyle, lineWidth) 
   {
       if (strokeStyle != null) _context.strokeStyle = strokeStyle;
       if (lineWidth != null) _context.lineWidth = lineWidth;
       _context.beginPath();
       _context.moveTo(startX, startY);
       _context.lineTo(endX, endY);
       _context.stroke();
       _context.closePath();
   }

double _maxYValue;
double _ratio;
double _xMax;
double _yMax;
double _top = 40.0; 
double _left = 75.0; 
double _right = 0.0; 
double _bottom = 75.0; 
String _font = "19pt Arial";
var _data;
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