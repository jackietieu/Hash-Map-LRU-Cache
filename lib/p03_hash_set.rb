require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash

    unless include?(num)
      resize! if @count == @store.length
      self[num] << key
      @count += 1
    end
  end

  def include?(key)
    num = key.hash
    self[num].include?(key)
  end

  def remove(key)
    num = key.hash
    self[num].delete(key) if include?(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }

    @store.each do |subarray|
      subarray.each do |num|
        new_store[num.hash % (num_buckets * 2)].push(num)
      end
    end

    @store = new_store
  end
end
