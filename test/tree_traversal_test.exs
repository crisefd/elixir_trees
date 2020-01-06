defmodule ElixirTreeTraversalTest do
  use ExUnit.Case
  alias ElixirTrees.TreeTraversal
  alias ElixirTrees.Tree
  doctest ElixirTrees

  setup_all do
     tree1 = %Tree{value: 8,
              children: [
                %Tree{ value: 3,
                       children: [
                        %Tree{value: 1},
                        %Tree{value: 6,
                              children: [
                                %Tree{value: 4},
                                %Tree{value: 7}
                          ]
                        }
                        ]
                      },
                %Tree{value: 10, 
                      children: [
                        %Tree{ value: 14,
                               children: [
                                %Tree{value: 13}
                                ]
                              }
                  ]}
              ]
          }
      tree2 = %Tree{ value: "A",
               children: [
                %Tree{ value: "B",
                       children: [
                          %Tree{value: "K",
                                children: [
                                  %Tree{value: "N"},
                                  %Tree{ value: "M"}
                                ]},
                          %Tree{ value: "j"}
                        ]},
                %Tree{ value: "F"},
                %Tree{ value: "D", 
                       children: [
                        %Tree{value: "G"}
                       ]},
                %Tree{ value: "E",
                       children: [
                         %Tree{value: "C"},
                         %Tree{ value: "H"},
                         %Tree{ value: "I",
                                children: [
                                  %Tree{ value: "L"}
                                ]},

                       ]
                     },
               ]}
    {:ok,
      trees: {tree1, tree2}
    }
  end

  test "depth-first search works", state do
      identity = fn(x, _, _) -> {:continue, x} end
      tree1 = elem(state[:trees], 0)
      assert TreeTraversal.traverse(tree1, identity , :dfs)
             == [1, 4, 7, 6, 3, 13, 14, 10, 8]

      tree2 = elem(state[:trees], 1)
      assert TreeTraversal.traverse(tree2, identity , :dfs)
             == ["N", "M", "K", "j", "B", "F", "G", "D", 
                 "C", "H", "L", "I", "E", "A"]
  end

  test "breadth-first search works", state do
      sum = fn (x, _, []) -> {:continue, x}
               (x, _, h) -> {:continue, x + hd(h)} end
      tree1 = elem(state[:trees], 0)
      assert TreeTraversal.traverse(tree1, sum , :bfs) |> List.first()
             == 66
      downcase_exists? = fn(x, _, _) -> 
        if  x == String.downcase(x)  do
          {:stop, x}
        else
          {:continue, x}
        end
      end
      tree2 = elem(state[:trees], 1)
      assert TreeTraversal.traverse(tree2, downcase_exists?, :bfs)  |> List.first()
             == "j"
  end

end
