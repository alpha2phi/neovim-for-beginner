describe("Text to Speech", function()
  before_each(function()
    print "before each"
  end)

  it("normal mode", function()
    vim.api.nvim_exec([[ Text2Speech]], true)
    assert.equals("hello", "hello")
  end)
end)
