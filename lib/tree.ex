defmodule ElixirTrees.Tree do

    defstruct value: nil, key: nil, children: []

    @type t :: %ElixirTrees.Tree{value: any, key: any, children: [t]}
end