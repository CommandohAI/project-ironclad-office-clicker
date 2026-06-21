local NumberFormatter = {}

local function trimDecimal(text)
    return text:gsub("%.0([KMB])", "%1")
end

function NumberFormatter.FormatMoney(value)
    value = tonumber(value) or 0

    if value >= 1_000_000_000 then
        return "£" .. trimDecimal(string.format("%.1fB", value / 1_000_000_000))
    elseif value >= 1_000_000 then
        return "£" .. trimDecimal(string.format("%.1fM", value / 1_000_000))
    elseif value >= 1_000 then
        return "£" .. trimDecimal(string.format("%.1fK", value / 1_000))
    end

    return "£" .. tostring(math.floor(value))
end

return NumberFormatter
