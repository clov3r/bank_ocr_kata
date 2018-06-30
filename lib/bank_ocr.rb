module BankOcr
  def readEntriesFromFile( file )
    # chunks a file into entries of 4 lines each
    entries = [];

    file.split("\n")
      .each_slice(4) { |entry| entries.push entry.take( 3 ) }

    parseDigits =  entries.map { |entry| separateDigits( entry ) }
    puts "parseDigits"
    p parseDigits
    parseDigits
  end


  def separateDigits( entryLines )
    puts "entryLines"
    p entryLines
    digits = entryLines
      .map { |line; split_line|
        split_line = []
        # puts "line"
        # p line
        line.split('').each_slice( 3 ) { | digitLine |
          split_line.push( digitLine.join ) }
        # puts "split_line"
        # p split_line
        split_line }
      .transpose()

    puts "separateDigits"
    p digits
    # return digits
  end

  def matchDigit( digit )
    digit.join('\n')
  end
end
