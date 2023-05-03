local neotest_status, neotest = pcall(require, "neotest")
if not neotest_status then
	return
end
local gtest_status, gtest = pcall(require, "neotest-gtest")
if not gtest_status then
	return
end
gtest.setup({})
neotest.setup({
	adapters = {
		gtest,
	},
})
