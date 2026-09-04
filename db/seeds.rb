Tag.create([
  { name: '懇親会向け' },
  { name: 'デート向け' },
  { name: '一人カラオケ向け' },
  { name: '友達とカラオケ' },
  { name: '盛り上がる' },
  { name: '落ち着く' },
  { name: '年代問わず' },
  { name: '最初の曲向け' },
  { name: '最後の曲向け' },
  Tag.find_or_create_by(name: tag_name)
])