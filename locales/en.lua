Lang = {
    orderCooldown       = "Slow down.",
    alreadyHaveOrder    = "You've already got something on the way. Sort that out first.",
    unknownItem         = Config.conversation.vettedFallback,
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    orderConfirmed      = "Say no more. Bring the cash for that %s and go to the location I'm about to send you.",
    noStock              = "Can't get that right now.",
    collectTooFar        = "You're not close enough yet.",
    collectNoOrder       = "You don't have anything waiting.",
    collectNotEnoughCash = "Come back when you've actually got the money.",
    collectSuccess       = "Pleasure doing business.",
    orderExpiredNotice   = "You took too long. Deal's off.",
}

---Formats a translation, falling back to the English default when a placeholder swap fails.
---@param key string
---@param ... any
function BMT(key, ...)
    local str = Lang[key]
    if not str then return key end
    local okFormat, formatted = pcall(string.format, str, ...)
    return okFormat and formatted or str
end
