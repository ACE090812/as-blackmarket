Locales = Locales or {}

Locales['en'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "Slow down.",
    ['dealer.alreadyHaveOrder'] = "You've already got something on the way. Sort that out first.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "Say no more. Bring the cash for that %s and go to the location I'm about to send you.",
    ['dealer.orderExpired']     = "You took too long. Deal's off.",
    ['dealer.dropLabel']        = 'Drop point',
    ['dealer.dropBody']         = "Here. Don't hang about.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'Collect Order',
    ['collect.success']    = 'Pleasure doing business.',
    ['collect.failed']     = 'Failed',
    ['collect.tooFar']     = "You're not close enough yet.",
    ['collect.noOrder']    = "You don't have anything waiting.",
    ['collect.notEnoughCash'] = "Come back when you've actually got the money.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'Scrawled Note',
}
