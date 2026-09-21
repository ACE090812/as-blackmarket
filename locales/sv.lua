Locales = Locales or {}

Locales['sv'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "Ta det lugnt.",
    ['dealer.alreadyHaveOrder'] = "Du har redan något på väg. Ordna det först.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "Säg inget mer. Ta med kontanter för %s och åk till platsen jag strax skickar.",
    ['dealer.orderExpired']     = "Du tog för lång tid. Affären är inställd.",
    ['dealer.dropLabel']        = 'Överlämningsplats',
    ['dealer.dropBody']         = "Här. Stå inte och hänga.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'Hämta beställning',
    ['collect.success']    = 'Ett nöje att göra affärer.',
    ['collect.failed']     = 'Misslyckades',
    ['collect.tooFar']     = "Du är inte tillräckligt nära än.",
    ['collect.noOrder']    = "Du har inget som väntar.",
    ['collect.notEnoughCash'] = "Kom tillbaka när du faktiskt har pengarna.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'Nedkrafsad lapp',
}
