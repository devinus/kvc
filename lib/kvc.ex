defmodule KVC do
  @path_separator "."

  @doc """
  Get deeply nested data using key-value coding.

  iex> list = [{ "foo", [[{ "bar", :baz }], [{ "bar", :quux }]]}]
  iex> KVC.get(list, "foo.@each.bar")
  [:baz, :quux]
  """

  @spec get(Dict.t, String.t) :: any
  def get(thing, path) when is_binary(path) do
    KVC.Protocol.get(thing, split_path(path))
  end

  defp split_path(path) do
    String.split(path, @path_separator)
  end
end

defprotocol KVC.Protocol do
  def get(thing, path)
end

defimpl KVC.Protocol, for: [List, HashDict] do
  @each_key "@each"

  def get(dict, [key]), do: Dict.get(dict, key)

  def get(dict, [@each_key | path]) do
    Enum.map dict, &KVC.Protocol.get(&1, path)
  end

  def get(dict, [key | path]) do
    case Dict.get(dict, key) do
      nil -> nil
      value -> KVC.Protocol.get(value, path)
    end
  end
end
