Get %r{/dungeon/entrance\.xml} do
  Dupe.find(:room) {|r| r.id == 1}
end

Dupe.define :room do |attrs|
  attrs.exits []
  attrs.type :room
end
