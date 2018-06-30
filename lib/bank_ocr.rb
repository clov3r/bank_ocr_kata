NumbersAs3x3Matrix =
[ " _ " +
  "| |" +
  "|_|" ,
  "   " +
  "  |" +
  "  |" ,
  " _ " +
  " _|" +
  "|_ " ,
  " _ " +
  " _|" +
  " _|" ,
  "   " +
  "|_|" +
  "  |" ,
  " _ " +
  "|_ " +
  " _|" ,
  " _ " +
  "|_ " +
  "|_|" ,
  " _ " +
  "  |" +
  "  |" ,
  " _ " +
  "|_|" +
  "|_|" ,
  " _ " +
  "|_|" +
  " _|" ]

LookupNumberFor = Hash[ NumbersAs3x3Matrix.zip ( 0..9 ) ]

class BankOcr
  def initialize( file )
    @file = file
  end

  # chunks a file into entries of 4 lines each
  def rawEntries
    @entries = [];

    @file.split("\n")
      .each_slice(4) { |entry| @entries.push entry.take( 3 ) }

    @entries
  end

  def rawEntriesChunkedByDigit
    rawEntries.map { |entry| separateDigits( entry ) }
  end

  def parsedEntries
    rawEntriesChunkedByDigit.map { |entry|
      entry.map { |digitAs3x3Matrix|
        LookupNumberFor[ digitAs3x3Matrix.join ] || "?" }.join }
  end

  private
    def separateDigits( entryLines )
      entryLines
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
    end

end
