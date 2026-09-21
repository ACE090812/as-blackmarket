Locales = Locales or {}

Locales['de'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "Mach langsam.",
    ['dealer.alreadyHaveOrder'] = "Du hast schon etwas unterwegs. Klär das zuerst.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "Verstanden. Bring das Bargeld für %s mit und geh zu dem Ort, den ich dir gleich schicke.",
    ['dealer.orderExpired']     = "Du hast zu lange gebraucht. Der Deal ist geplatzt.",
    ['dealer.dropLabel']        = 'Übergabepunkt',
    ['dealer.dropBody']         = "Hier. Trödel nicht rum.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'Bestellung abholen',
    ['collect.success']    = 'War mir ein Vergnügen.',
    ['collect.failed']     = 'Fehlgeschlagen',
    ['collect.tooFar']     = "Du bist noch nicht nah genug dran.",
    ['collect.noOrder']    = "Bei dir wartet nichts.",
    ['collect.notEnoughCash'] = "Komm wieder, wenn du wirklich das Geld hast.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'Hingekritzelte Notiz',
}
