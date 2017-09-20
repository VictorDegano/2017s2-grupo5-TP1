require_relative '../src/Board.rb'

describe Board do
  it "should find all sourrounding positions for a cell in the middle" do
    board = Board.new(5, 8)

    expect(board.find_neighboring(2, 2)).to eq([
      [1, 1], [1, 2], [1, 3],
      [2, 1],         [2, 3],
      [3, 1], [3, 2], [3, 3]
    ])
  end

  it "shouldn't give out of the board cells for (1, 1)" do
    board = Board.new(5, 5)

    expect(board.find_neighboring(0, 0)).to eq([
      [0, 1], [1, 0], [1, 1]
    ])
  end

  it "shouldn't give out of the board cells for a cell next to y-axis" do
    board = Board.new(5, 5)

    expect(board.find_neighboring(0, 3)).to eq([
      [0, 2], [0, 4], [1, 2], [1, 3], [1, 4]
    ])
  end

  it "shouldn't give out of the board cells for a cell next to x-axis" do
    board = Board.new(5, 5)

    expect(board.find_neighboring(3, 0)).to eq([
      [2, 0], [2, 1], [3, 1], [4, 0], [4, 1]
    ])
  end

  it "should work with a cell too close to the end corner of the board" do
    board = Board.new(5, 5)

    expect(board.find_neighboring(4, 4)).to eq([
      [3, 3], [3, 4], [4, 3] 
    ])
  end

  it "neighboring_area()" do
    board = Board.new(5, 5)
    expect(board.neighboring_area(4, 5)).to eq([3, 4])
    expect(board.neighboring_area(0, 5)).to eq([0, 1])
  end


end