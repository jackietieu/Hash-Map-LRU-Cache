class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash = 0

    self.each_with_index do |num, i|
      hash = hash ^ (num.hash * (i + 1))
    end

    hash
  end
end

class String
  def hash
    hash = 0

    self.each_char.with_index do |char, i|
      hash = hash ^ (char.ord.hash * (i + 1))
    end

    hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    keys = self.keys.sort
    values = self.values.sort

    keys.hash ^ values.hash
    #0
  end
end
