class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @tail = Link.new
    @head = Link.new
    @tail.next = @head
    @head.prev = @tail

  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @tail.next
  end

  def last
    @head.prev
  end

  def empty?
    @head.prev == @tail
  end

  def get(key)
    current_link = @head

    until current_link.prev.nil?
      current_link = current_link.prev
      return current_link.val if current_link.key == key
    end
    nil
  end

  def include?(key)
    current_link = @head

    until current_link.prev.nil?
      current_link = current_link.prev
      return true if current_link.key == key
    end

    false
  end

  def insert(key, val)
    new_link = Link.new(key, val)
    shifted_link = @head.prev
    new_link.next = @head
    new_link.prev = shifted_link
    @head.prev = new_link
    shifted_link.next = new_link
  end

  def remove(key)
    current_link = @head.prev

    until current_link.prev.nil?
      if current_link.key == key
        current_link.prev.next = current_link.next
        current_link.next.prev = current_link.prev
      end

      current_link = current_link.prev
    end
  end

  def each(&blk)
    current_link = @tail.next

    until current_link == @head
      blk.call(current_link)
      current_link = current_link.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
