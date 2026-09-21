Locales = Locales or {}

Locales['hr'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "Polako.",
    ['dealer.alreadyHaveOrder'] = "Već imaš nešto na putu. Prvo to riješi.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "Ni riječi više. Donesi gotovinu za %s i idi na lokaciju koju ću ti uskoro poslati.",
    ['dealer.orderExpired']     = "Predugo je trajalo. Dogovor otpada.",
    ['dealer.dropLabel']        = 'Mjesto predaje',
    ['dealer.dropBody']         = "Evo. Ne muvaj se.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'Preuzmi narudžbu',
    ['collect.success']    = 'Zadovoljstvo je poslovati s tobom.',
    ['collect.failed']     = 'Neuspjelo',
    ['collect.tooFar']     = "Još nisi dovoljno blizu.",
    ['collect.noOrder']    = "Ništa te ne čeka.",
    ['collect.notEnoughCash'] = "Vrati se kad stvarno imaš novac.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'Išarana bilješka',
}
