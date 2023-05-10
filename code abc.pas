# code
program sudoku;

const
  size = 9;
  sqrSize = 3;

type
  board = array[1..size, 1..size] of integer;

var
  puzzle, solution: board;
  solved: boolean;

procedure printBoard(b: board);
var
  i, j: integer;
begin
  for i := 1 to size do begin
    for j := 1 to size do
      write(b[i, j], ' ');
    writeln;
  end;
end;

function validMove(b: board; row, col, num: integer): boolean;
var
  i, j, rowStart, colStart: integer;
begin
  rowStart := (row - 1) div sqrSize * sqrSize + 1;
  colStart := (col - 1) div sqrSize * sqrSize + 1;

  { Check if num already appears in row or column }
  for i := 1 to size do
    if (b[row, i] = num) or (b[i, col] = num) then
      exit(false);

  { Check if num already appears in 3x3 square }
  for i := 0 to sqrSize - 1 do
    for j := 0 to sqrSize - 1 do
      if b[rowStart + i, colStart + j] = num then
        exit(false);

  exit(true);
end;

procedure solveBoard(var b: board; row, col: integer);
var
  i, nextRow, nextCol: integer;
begin
  { If we've reached the end of the board, we've found a solution }
  if row > size then begin
    solution := b;
    solved := true;
    exit;
  end;

  nextRow := row;
  nextCol := col + 1;
  if nextCol > size then begin
    nextRow := row + 1;
    nextCol := 1;
  end;

  { If the current cell is already filled, move on to the next cell }
  if b[row, col] <> 0 then
    solveBoard(b, nextRow, nextCol)
  else begin
    { Try filling in each number from 1 to 9 }
    for i := 1 to size do begin
      if validMove(b, row, col, i) then begin
        b[row, col] := i;
        solveBoard(b, nextRow, nextCol);
        if solved then
          exit;
        b[row, col] := 0;
      end;
    end;
  end;
end;

begin
  puzzle := (
    (5, 3, 0, 0, 7, 0, 0, 0, 0),
    (6, 0, 0, 1, 9, 5, 0, 0, 0),
    (0, 9, 8, 0, 0, 0, 0, 6, 0),
    (8, 0, 0, 0, 6, 0, 0, 0, 3),
    (4, 0, 0, 8, 0, 3, 0, 0, 1),
    (7, 0, 0, 0, 2, 0, 0, 0, 6),
    (0, 6, 0, 0, 0, 0, 2, 8, 0
