describe("Text to Speech", function()
  it("Test Translate", function()
    local translated = vim.fn.Translate("zh", "hello world")
    translated = vim.fn.Translate("zh", "hello world")
    assert.equals("你好世界", translated)
  end)
end)
