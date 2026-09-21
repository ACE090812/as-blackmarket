Locales = Locales or {}

Locales['pl'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "Zwolnij.",
    ['dealer.alreadyHaveOrder'] = "Masz już coś w drodze. Najpierw to załatw.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "Nie mów więcej. Przynieś gotówkę za: %s i idź w miejsce, które zaraz ci wyślę.",
    ['dealer.orderExpired']     = "Za długo to trwało. Umowa odwołana.",
    ['dealer.dropLabel']        = 'Punkt odbioru',
    ['dealer.dropBody']         = "Proszę. Nie kręć się tu.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'Odbierz zamówienie',
    ['collect.success']    = 'Miło robić z tobą interesy.',
    ['collect.failed']     = 'Niepowodzenie',
    ['collect.tooFar']     = "Nie jesteś jeszcze wystarczająco blisko.",
    ['collect.noOrder']    = "Nic na ciebie nie czeka.",
    ['collect.notEnoughCash'] = "Wróć, gdy naprawdę zdobędziesz kasę.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'Nabazgrana notatka',
}
