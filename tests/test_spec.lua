describe("Testing", function()
  before_each(function()
    print "before each"
  end)

  after_each(function()
    print "after each"
  end)

  it("Scenario 1", function()
    assert.equals([[hello alpha2phi]], "hello alpha2phi")
  end)

  it("Scenario 2", function()
    print("Scenario 2")
    assert.equals([[hello world]], "hello world")
  end)
end)
