Locales = Locales or {}

Locales['nl'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "Rustig aan.",
    ['dealer.alreadyHaveOrder'] = "Je hebt al iets onderweg. Regel dat eerst.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "Genoeg gezegd. Neem het geld mee voor %s en ga naar de locatie die ik je zo stuur.",
    ['dealer.orderExpired']     = "Je deed er te lang over. De deal is van de baan.",
    ['dealer.dropLabel']        = 'Dropplek',
    ['dealer.dropBody']         = "Hier. Hang niet rond.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'Bestelling ophalen',
    ['collect.success']    = 'Prettig zaken met je te doen.',
    ['collect.failed']     = 'Mislukt',
    ['collect.tooFar']     = "Je bent nog niet dichtbij genoeg.",
    ['collect.noOrder']    = "Er ligt niets voor je klaar.",
    ['collect.notEnoughCash'] = "Kom terug als je echt het geld hebt.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'Gekrabbelde notitie',
}
