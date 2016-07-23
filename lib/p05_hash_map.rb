require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store.each do |list|
      return true if list.include?(key)
    end

    false
  end

  def set(key, val)
    unless include?(key)
      resize! if @store.count == count
      @count += 1
    end

    @store[key.hash % num_buckets].insert(key, val)
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    if include?(key)
      @count -= 1
      @store[key.hash % num_buckets].remove(key)
    end
  end

  def each(&blk)
    @store.each do |list|
      current_link = list.first
      until current_link.next.nil?
        blk.call(current_link.key, current_link.val)
        current_link = current_link.next
      end
    end

  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { LinkedList.new }

    @store.each do |list|
      list.each do |link|
        new_index = link.key.hash % (num_buckets * 2)
        new_store[new_index].insert(link.key, link.val)
      end
    end
    @store = new_store


  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
