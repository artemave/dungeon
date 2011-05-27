Get %r{/dungeon/entrance\.xml} do
  Dupe.find(:room) {|r| r.id == 1}
end

Dupe.define :room |attrs| do
  attrs.exits []
  attre.type :room
end
