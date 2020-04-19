t1 = Team.create(name: 'team1')
t2 = Team.create(name: 'team2')

t1.players.create(
  [{ name: 'p1t1' }, { name: 'p2t1' },
   { name: 'p3t1' }, { name: 'p4t1' }, { name: 'p5t1' }]
)
t2.players.create(
  [{ name: 'p1t2' }, { name: 'p2t2' },
   { name: 'p3t2' }, { name: 'p4t2' }, { name: 'p5t2' }]
)

i1, i2 = Indicator.create(
  [{ name: 'пробежал 10+ км' }, { name: 'сделал 70+ % точных передач' }]
)

m1, m2 = Match.create(
  [{ name: 'match1', team1: t1, team2: t2 },
   { name: 'match2', team1: t2, team2: t1 }]
)

m1.teams.each do |t|
  t.players.each do |p|
    rnd1 = [true, false].sample
    rnd2 = [true, false].sample
    p.indicator_values.create(
      [{ indicator: i1, match: m1, val: rnd1 },
       { indicator: i2, match: m1, val: rnd2 }]
    )
  end
end

m2.teams.each do |t|
  t.players.each do |p|
    rnd1 = [true, false].sample
    rnd2 = [true, false].sample
    p.indicator_values.create(
      [{ indicator: i1, match: m2, val: rnd1 },
       { indicator: i2, match: m2, val: rnd2 }]
    )
  end
end
