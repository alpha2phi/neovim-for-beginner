describe("Text to Speech", function()
  before_each(function()
    print "before each"
  end)

  it("Test Command", function()
    local result = vim.fn.text2speech()
    print(result)
    assert.equals("1hello", "hello")
  end)
end)
