local startup_status, startup = pcall(require, "startup")
if not startup_status then
	return
end

startup.setup()
