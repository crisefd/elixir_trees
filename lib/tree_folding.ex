defmodule ElixirTrees.TreeFolding do
  alias ElixirTrees.Tree

  @type tree() :: Tree.t()

  @spec foldr([tree], function, function, any) :: any

  def foldr(trees, parent_fun, children_fun, acc)

  def foldr([], _, _, acc), do: acc

  def foldr([tree | trees], parent_fun, children_fun, acc) do
    children_fun.(
      fold(tree, parent_fun, children_fun, acc),
      foldr(trees, parent_fun, children_fun, acc)
    )
  end

  @spec fold(tree, function, function, any) :: any

  def fold(tree, parent_fun, children_fun, acc)

  def fold(%Tree{value: value, children: children}, parent_fun, children_fun, acc) do
    parent_fun.(value, foldr(children, parent_fun, children_fun, acc))
  end
end
