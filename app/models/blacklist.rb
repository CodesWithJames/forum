class Blacklist
  LIST = %w(porra caralho buceta foda vsf foda-se fdp filho da puta pqp puta cuzão viado veado bixa viadinho)

  def self.filter string
    LIST.each do |word|
      string_down = string.downcase
      if string_down.include?(word)
        init_index = string_down.index(word)
        end_index = init_index + word.size
        string[init_index..end_index] = "xxxx " 
      end
    end
    string
  end
end