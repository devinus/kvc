# KVC

A simple Elixir KVC module modelled after Ember.js KVC.

## Example

```elixir
list = [{ "foo", [[{ "bar", :baz }], [{ "bar", :quux }]]}]
KVC.get(list, "foo.@each.bar") #=> [:baz, :quux]
```
