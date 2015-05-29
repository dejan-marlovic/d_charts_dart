part of chart;

class dLineChart extends dChart 
{
  dLineChart({DivElement container: null,
      List<List<dDataPoint>> chartData: null, List<String> chartColors: null})
      : super(container, chartData, chartColors) {
        
    calcMaxDataValue();
    _ratioY = (_canvas.height.toDouble() / _maxYValue).roundToDouble();
    _ratioX = (_canvas.width.toDouble() / _maxXValue).roundToDouble();
  }
  void draw() 
  {
    drawAxis();
    renderGrid(10);
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
    _context.arc(toPixelsX(dp.x), _canvas.height - toPixelsY(dp.y), 5, 0,2 * PI, false);
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
    _context.moveTo(10, _canvas.height);

    while (iterator.moveNext()) 
    {
      _context.lineTo(toPixelsX(iterator.current.x),_canvas.height - toPixelsY(iterator.current.y));
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

  int _color = 0;
}

class dDataPoint 
{
  dDataPoint(double x, double y) {
    _x = x;
    _y = y;
  }
  double _x;
  double _y;
  get x => _x;
  get y => _y;
}
