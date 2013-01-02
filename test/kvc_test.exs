Code.require_file "../test_helper.exs", __FILE__

defmodule KVCTest do
  use ExUnit.Case

  test "get on a List" do
    assert KVC.get([{ "foo", [{ "bar", :baz }]}], "foo.bar") == :baz
  end

  test "get on a List with an @each" do
    list = [{ "foo", [[{ "bar", :baz }], [{ "bar", :quux }]]}]
    assert KVC.get(list, "foo.@each.bar") == [:baz, :quux]
  end

  test "get on a Binary.Dict" do
    dict = Binary.Dict.new [{ "foo", Binary.Dict.new [{ "bar", :baz }]}]
    assert KVC.get(dict, "foo.bar") == :baz
  end

  test "get on a Binary.Dict with an @each" do
    dict = Binary.Dict.new [{ "foo", [[{ "bar", :baz }], [{ "bar", :quux }]]}]
    assert KVC.get(dict, "foo.@each.bar") == [:baz, :quux]
  end

  test "get on a HashDict" do
    dict = HashDict.new [{ "foo", [{ "bar", :baz }]}]
    assert KVC.get(dict, "foo.bar") == :baz
  end

  test "get on a OrdDict" do
    dict = OrdDict.new [{ "foo", [{ "bar", :baz }]}]
    assert KVC.get(dict, "foo.bar") == :baz
  end
end
