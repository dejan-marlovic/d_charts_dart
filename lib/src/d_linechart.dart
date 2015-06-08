part of chart;

class dLineChart extends dChart 
{
  dLineChart({DivElement container: null,List<List<dDataPoint>> chartData: null, List<String> chartColors: null, List<String> xAxisLabels:null, int gridResolution:null}):super(container, chartData, chartColors,gridResolution, xAxisLabels) 
  {
    calcMaxDataValue();
    _ratioY = (_graphAreaWidth.toDouble() / _maxYValue).roundToDouble();
    _ratioX = (_graphAreaWidth.toDouble() / _maxXValue).roundToDouble();
  }
  
  void renderXAxisLabels()
  {
    
    if(_xAxisLabels != null)
      _gridResolution = toPixelsY(_xAxisLabels.length.toDouble());
    else
      _gridResolution = toPixelsY(_gridResolution.toDouble());
    
    //#dee5e1";
    _context.strokeStyle = "gray";
    _context.lineWidth = 2;
    //render grid
    int currentY = _gridResolution;
    while (currentY < _graphAreaWidth)
    {         
      _context.beginPath();
      _context.moveTo(_graphAreaWidth - currentY,0);
      _context.lineTo(_graphAreaWidth - currentY,_graphAreaHeight);
      _context.stroke();
      _context.closePath();
      currentY += _gridResolution;
    }
  }
  
  void draw() 
  {
    drawAxis();
    renderHorisontalGrid();
    renderVerticalGrid();
    renderVerticalGridLabel();
    renderXAxisLabels();
    
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
    _context.arc(toPixelsX(dp.x), _graphAreaWidth.height - toPixelsY(dp.y), 5, 0,2 * PI, false);
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
    _context.moveTo(0, _graphAreaWidth.height);

    while (iterator.moveNext()) 
    {
      _context.lineTo(toPixelsX(iterator.current.x),_graphAreaWidth.height - toPixelsY(iterator.current.y));
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
