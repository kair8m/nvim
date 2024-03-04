local status, wrapping = pcall(require, "wrapping")
if not status then
    return
end

wrapping.setup()
