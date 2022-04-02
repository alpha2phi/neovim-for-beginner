describe("Testing", function()
  before_each(function()
    print "before each"
  end)

  it("test case 1", function()
    -- vim.api.nvim_exec([[ lua print("Testing")]], true)
    -- vim.notify "testing"
    assert.equals("helloj", "helloj")
  end)
end)
