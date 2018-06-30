FIXTURE_DIR = "/Users/clov3r/Dev/bank_ocr_kata/fixtures/"

class BankOcrTestClient
  include BankOcr
end

describe BankOcr do
  @bankOcr = nil
  before(:all) do
    @bankOcr = BankOcrTestClient.new
    @entries =
      @bankOcr.readEntriesFromFile( fixture( 'use_case_1_in' ) )
  end

  it "is a module" do
    expect(BankOcr).to be_a Module
  end

  it "splits a file into entries" do
            expect( @entries ).to be_an Array
     expect( @entries.length ).to be 11
  end

  it "parses an entry into a string of digits" do

    (0..9).each { |entry|
      expect( @entries[entry] )
        .to eq ( (1..9).collect{ entry }.join ) }

    expect( @entries[10] ).to eq ( "123456789")
  end
end
