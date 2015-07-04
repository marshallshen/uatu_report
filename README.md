# Features

```ruby
count "deal_import_state" do
  DealImportState.count(...)
end

expect "deal_import_state has no null inactive" do
  DealImportState.count(...) < 0
end
```
