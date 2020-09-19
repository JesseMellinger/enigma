module Generatable

  def generate_keys(random_num)
    {
      a: random_num[0..1],
      b: random_num[1..2],
      c: random_num[2..3],
      d: random_num[3..5]
    }
  end

  def generate_offsets(date)
    num = (date.to_i ** 2).to_s[-4..-1]

    {
      a: num[0],
      b: num[1],
      c: num[2],
      d: num[3]
    }
  end

  def generate_shifts(keys, offsets)
    {
      a: keys[:a].to_i + offsets[:a].to_i,
      b: keys[:b].to_i + offsets[:b].to_i,
      c: keys[:c].to_i + offsets[:c].to_i,
      d: keys[:d].to_i + offsets[:d].to_i
    }
  end

end
