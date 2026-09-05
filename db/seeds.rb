["懇親会向け", "デート向け", "一人カラオケ向け", "友達とカラオケ", "盛り上がる", "落ち着く", "年代問わず", "最初の曲向け", "最後の曲向け"].each do |tag_name|
  Tag.find_or_create_by(name: tag_name)
end