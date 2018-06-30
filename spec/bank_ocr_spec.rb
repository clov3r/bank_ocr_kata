describe BankOcr do

  it "parses entries into a string of digits" do
    bankOcr = BankOcr.new fixture( 'use_case_1_in' )

    expect( bankOcr.parsedEntries.join("\n") )
        .to eq fixture( 'use_case_1_out' ).chomp

    expect( bankOcr.parsedEntries[10] ).to eq ( "123456789" )
  end

  it "validates account number checksums" do
    expect( BankOcr.validateChecksum( "000000000" ) ).to be true
    expect( BankOcr.validateChecksum( "111111111" ) ).to be false
    expect( BankOcr.validateChecksum( "222222222" ) ).to be false
    expect( BankOcr.validateChecksum( "333333333" ) ).to be false
    expect( BankOcr.validateChecksum( "444444444" ) ).to be false
    expect( BankOcr.validateChecksum( "555555555" ) ).to be false
    expect( BankOcr.validateChecksum( "666666666" ) ).to be false
    expect( BankOcr.validateChecksum( "777777777" ) ).to be false
    expect( BankOcr.validateChecksum( "888888888" ) ).to be false
    expect( BankOcr.validateChecksum( "999999999" ) ).to be false
    expect( BankOcr.validateChecksum( "123456789" ) ).to be true
  end

  it "prints results with ERR or ILL when an entry is erroneous or illegible" do
    bankOcr = BankOcr.new fixture( "use_case_3_in" )
    expect( bankOcr.results ).to eq fixture( "use_case_3_out" )
  end
end
