describe BankOcr do

  it "parses entries into a string of digits" do
    @bankOcr = BankOcr.new fixture( 'use_case_1_in' )

    expect( @bankOcr.parsedEntries.join("\n") )
        .to eq fixture( 'use_case_1_out' ).chomp

    expect( @bankOcr.parsedEntries[10] ).to eq ( "123456789" )
  end
end
