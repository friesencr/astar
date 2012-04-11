#= require astar

describe "Grid", ->

  describe "#constructor", ->

    it "takes a height", ->
      grid = new Grid(10, null)
      expect(grid.height).toBe(10)

    it "takes a width", ->
      grid = new Grid(null, 20)
      expect(grid.width).toBe(20)

    it "takes a start point", ->
      grid = new Grid(null, null, point(0,0), null)
      expect(grid.start).toEqual({x:0,y:0})

  describe "#matrix", ->
    grid = null
    beforeEach -> grid = new Grid(10,10)

    it 'is defined', ->
      expect(grid.matrix).toBeTruthy()

  describe "#map", ->
    grid = null
    beforeEach -> grid = new Grid(10,10)

    it 'returns 100 records', ->
      a_list = grid.map((x)->'a')
      expect(a_list.length).toBe(100)

  describe "#all", ->
    grid = null
    beforeEach -> grid = new Grid(10,10)
    
    it "returns 100 cells", ->
      cells = grid.all()
      expect(cells.length).toBe(100)
      all = true
      for c in cells
        all = c.x? && c.y?
        break if all is false
      expect(all).toBe(true)

  describe "#get_adjacent_cells", ->
    grid = null
    beforeEach -> grid = new Grid(10,10)

    it "finds adjacent cells", ->


        
      


describe "Cell", ->

describe "AStar", ->
  it "has a spec", ->
    astar = new AStar(null)
    expect astar?
