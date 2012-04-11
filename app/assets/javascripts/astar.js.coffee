this.point = (x,y) ->
  {x:x,y:y}

class Cell
  constructor: (@x, @y) ->

class Grid
  constructor: (@height, @width, @start, @end) ->
    @matrix = {}
    for x in [0...@height]
      for y in [0...@width]
        @matrix["#{x}_#{y}"] = new Cell(x,y)
  
  map: (func) ->
    results = []
    for x in [0...@height]
      for y in [0...@width]
        results.push(func(@matrix["#{x}_#{y}"]))
    results
        
  all: ->
    @map((x)-> x)

class AStar
  findPath: (@start_cell, @end_cell) ->

this.Cell = Cell
this.Grid = Grid
this.AStar = AStar

# $(function() {
# 	var Grid = function(height,width) {
# 		this.height = height;
# 		this.width = width;
# 		this.matrix = {};
# 		this.container = $('<table>');
# 		this.container.appendTo('body');
# 		this.map = function(func) {
# 			var results = [];
# 			for(var y=0;y<this.height;y++) {
# 				for (var x=0;x<this.width;x++) {
# 					results.push(func(this.cell(x,y)));
# 				}
# 			}
# 			return results;
# 		}
# 		this.all = function() { return this.map(function(x) { return x; }); };
# 		this.cell = function(x,y,v1,v2) {
# 			if (x > this.width-1 || y > this.height-1) { throw 'out of range'; }
# 			var f = x+''+y;
# 			if (!this.matrix[f]) { this.matrix[f] = {}; }
# 			if (v1) {
# 				var cell = this.matrix[f];
# 				if (v2) {
# 					cell[v2] = value;
# 				} else {
# 					cell = _.extend(cell, v1);
# 				}
# 			} else {
# 				return _.extend(this.matrix[f] || {}, {x:x, y:y});
# 			}
# 		};
# 		this.adjacentCells = function(x,y) {
# 			var results = [];
# 			for(var a=x-1;a < x+2;a++) {
# 				for(var b=y-1; b < y+2; b++) {
# 					if (x === a && y === b) { continue; }
# 					if (a > 0 && a < this.width) {
# 						if (b > 0 && b < this.height) {
# 							results.push(this.cell(a,b));
# 						}
# 					}
# 				}
# 			}
# 			return results;
# 		};
# 		this.render = function() {
# 			this.container.empty();
# 			for(var y=0;y<this.height;y++) {
# 				var tr = $('<tr>');
# 				tr.appendTo(this.container);
# 				for (var x=0;x<this.width;x++) {
# 					var td = $('<td>');
# 					var cell = this.cell(x,y);
# 					var fields = {
# 						start: cell.start,
# 						end: cell.end,
# 						walkable: cell.walkable,
# 						path: cell.path,
# 						current: cell.current
# 					}
# 					var class_str = _.map(fields, function(v,k) { return k + "_" + v; });
# 					td.attr('class', class_str.join(' '));
# 					td.text(x + ',' + y);
# 					td.appendTo(tr);
# 				}
# 			}
# 		};
# 		this.getDistance = function(x1,y1,x2,y2) {
# 			return Math.sqrt(
# 				((x2-x1)^2) +
# 				((y2-y1)^2)
# 			)
# 		}
# 		this.getCellDistance = function(cell1, cell2){
# 			return this.getDistance(
# 				cell1.x,
# 				cell1.y,
# 				cell2.x,
# 				cell2.y
# 			);
# 		}
# 	};

# 	var AStar = function(grid) {
# 		this.grid = grid;
# 		this.openList = function() {
# 			return _.chain(this.grid.all())
# 				.filter(function(x) {	return x.state === 'open'; })
# 				.sortBy(function(x) { return x.F })
# 				.value();
# 		};
# 		this.closedList = function() {
# 			return x.state === 'closed';
# 		};
# 		this.scoreAdjacentNodes = function(cell) {
# 			cell.state = 'closed';
# 			var g = this.grid;
# 			var _self = this;
# 			var end = this.endCell; 
# 			var near = _.chain(g.adjacentCells(cell.x, cell.y))
# 				.filter(function(x) { return x.walkable !== false && x.state !== 'closed'; })
# 				.map(function(x) {
# 					x.A = cell;
# 					x.H = x.H || Math.abs(x.x - end.x) + Math.abs(x.y - end.y);
# 					// x.H = x.H || Math.abs(g.getCellDistance(cell, x));
# 					x.G = Math.abs(g.getCellDistance(cell, end));
# 					x.F = x.H + x.G;
# 					x.state = 'open';
# 					return x;
# 				})
# 				.value();

# 			var nearest = this.openList()[0];
# 			if (nearest === end) { return; }
# 			else if(nearest) {
# 				var render = function() {
# 					console.log('pass');
# 					_.each(g.all(), function(x) { x.current=false; x.path = false; });
# 					cell.current = 'true';
# 					var path = [];
# 					this.getPath(this.endCell, path);
# 					_.each(path, function(x) { x.path = true; });
# 					g.render();
# 					_self.scoreAdjacentNodes(nearest);
# 				}
# 				setTimeout(function() {	render.call(_self); }, 2000);
# 				// _self.scoreAdjacentNodes(nearest);
# 			}
# 		};
# 		this.getPath = function(cell, nodes) {
# 			if (!cell) { 
# 				return nodes; 
# 			}
# 			nodes.push(cell);
# 			this.getPath(cell.A, nodes);
# 		}
# 		this.findPath = function(s,e) {
# 			this.startCell = s; 
# 			this.endCell = e;
# 			this.startCell.state = 'open';
# 			this.scoreAdjacentNodes(this.startCell);
# 			// var path = [];
# 		};
# 	};

# 	grid = new Grid(10, 10);
# 	grid.cell(0,0, { start: true });
# 	grid.cell(9,3, { end: true });
# 	grid.cell(2,1,{ walkable:false });
# 	grid.cell(2,3,{ walkable:false });
# 	grid.cell(2,4,{ walkable:false });
# 	grid.cell(2,5,{ walkable:false });
# 	grid.cell(2,6,{ walkable:false });
# 	grid.cell(2,7,{ walkable:false });
# 	grid.cell(2,2,{ walkable:false });
# 	grid.cell(3,2,{ walkable:false });
# 	grid.cell(4,2,{ walkable:false });
# 	grid.cell(5,2,{ walkable:false });
# 	grid.cell(6,2,{ walkable:false });
# 	grid.cell(7,2,{ walkable:false });
# 	grid.cell(8,2,{ walkable:false });
# 	grid.cell(9,2,{ walkable:false });
# 	grid.cell(6,9,{ walkable:false });
# 	grid.cell(6,9,{ walkable:false });
# 	grid.cell(6,8,{ walkable:false });
# 	grid.cell(6,7,{ walkable:false });
# 	grid.cell(6,6,{ walkable:false });

# 	var astar = new AStar(grid);
# 	var s = _.find(grid.all(), function(x) { return x.start === true; });
# 	var e = _.find(grid.all(), function(x) { return x.end === true; });

# 	astar.findPath(s,e);
# 	// grid.render();
# });
