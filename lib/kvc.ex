defmodule KVC do
  @path_separator "."

  def get(thing, path) when is_binary(path) do
    KVC.Protocol.get(thing, split_path(path))
  end

  defp split_path(path) do
    :binary.split(path, @path_separator, [:global])
  end
end

defprotocol KVC.Protocol do
  def get(thing, path)
end

defimpl KVC.Protocol, for: List do
  @each_key "@each"

  def get([], _path), do: nil

  def get([{ key, value }], [key]), do: value

  def get([{ _key, _value }], [_other]), do: nil

  def get(list, [@each_key | path]) do
    lc value inlist list, do: get(value, path)
  end

  def get(list, [key | path]) do
    case :lists.keyfind(key, 1, list) do
      { ^key, value } -> KVC.Protocol.get(value, path)
      false -> nil
    end
  end
end

defimpl KVC.Protocol, for: [Binary.Dict, HashDict, OrdDict] do
  def get(dict, [key]), do: Dict.get(dict, key)

  def get(dict, [key | path]) do
    case Dict.get(dict, key) do
      nil -> nil
      value -> KVC.Protocol.get(value, path)
    end
  end
end
