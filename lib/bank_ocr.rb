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

  def self.validateChecksum( accountNumber )
    if accountNumber.length != 9 || accountNumber.match( /\D/ )
      return false
    end
    checksum = 0
    accountNumber.split('').reverse.each_with_index { |digit,i|
      checksum += ( i + 1 ) * digit.to_i }
    return ( checksum % 11 ) === 0
  end

  def initialize( file )
    @file = file
  end

  def parsedEntries
    rawEntriesChunkedByDigit.map { |entry|
      entry.map { |digitAs3x3Matrix|
        LookupNumberFor[ digitAs3x3Matrix.join ] || "?" }.join }
  end

  def results
    parsedEntries.map { |entry|
      case
        when self.class.validateChecksum( entry )
          entry
        when entry.match( /\?/ )
          entry + ' ILL'
        else
          entry + ' ERR'
        end }
      .join("\n") + "\n"
  end

  private
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
