defmodule KVCTest do
  use ExUnit.Case, async: true

  doctest KVC

  test "get on a List" do
    assert KVC.get([{ "foo", [{ "bar", :baz }]}], "foo.bar") == :baz
  end

  test "get on a List with an @each" do
    list = [{ "foo", [[{ "bar", :baz }], [{ "bar", :quux }]]}]
    assert KVC.get(list, "foo.@each.bar") == [:baz, :quux]
  end

  test "get on a HashDict" do
    dict = HashDict.new [{ "foo", [{ "bar", :baz }]}]
    assert KVC.get(dict, "foo.bar") == :baz
  end

  test "get on a HashDict with an @each" do
    dict = HashDict.new [{ "foo", [[{ "bar", :baz }], [{ "bar", :quux }]]}]
    assert KVC.get(dict, "foo.@each.bar") == [:baz, :quux]
  end
end
