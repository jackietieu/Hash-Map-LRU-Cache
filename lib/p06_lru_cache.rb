require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc#(prc.nil? ? Proc.new {|x| x ** 2} : prc)
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      @store.each do |link|
        if link.key == key
          update_link!(link)
          return key
        end
      end
    else

      value = @prc.call(key)

      if @max == count
        @map.delete(@store.first.key)
        @store.remove(@store.first.key)
      end

      @map.set(key, value)
      @store.insert(key, value)
      return value
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    @store.remove(link.key)
    @store.insert(link.key, link.val)
    # suggested helper method; move a link to the end of the list
  end

  def eject!

  end
end
