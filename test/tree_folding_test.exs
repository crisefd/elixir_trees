defmodule ElixirTreesTest do
  use ExUnit.Case
  alias ElixirTrees.TreeFolding
  alias ElixirTrees.Tree
  doctest ElixirTrees


  test "sum of nodes in tree" do
    sum = fn (x, y) -> x + y end
    concat = fn (x, y) -> x <> y end
    sep = fn (x, y) -> x <> "-" <> y   end
    tree1 = %Tree{ value: 1,
                  children: [
                    %Tree{value: 2},
                    %Tree{value: 3,
                          children: [
                            %Tree{value: 4}
                          ]}
                  ] }
    tree2 = %Tree{ value: "a",
                  children: [
                    %Tree{value: "b"},
                    %Tree{value: "c",
                          children: [
                            %Tree{value: "d"}
                          ]},
                    %Tree{value: "e"},
                    %Tree{value: "f", children: [
                      %Tree{value: "g"},
                      %Tree{value: "h"}
                      ]}
                  ] }

    assert TreeFolding.fold(tree1, sum, sum, 0) == 10
    assert TreeFolding.fold(tree2, concat, concat, "") == "abcdefgh"
    assert TreeFolding.fold(tree2, sep, concat, "") == "a-b-c-d-e-f-g-h"
  end

end