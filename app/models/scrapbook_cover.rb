class ScrapbookCover
  def initialize(scrapbook)
    @scrapbook = scrapbook
  end

  def main_memory
    memories.first
  end

  def secondary_memories
    Array.new(2).map.with_index do |memory, i|
      memories[i+1] # skip the first memory as that is the main memory
    end
  end

  def memory_count
    memories.length
  end

  private

  def memories
    @memories ||= @scrapbook.try(:memories) || []
  end
end

