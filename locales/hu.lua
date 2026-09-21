Locales = Locales or {}

Locales['hu'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "Lassabban.",
    ['dealer.alreadyHaveOrder'] = "Már van valami úton. Intézd el azt először.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "Nincs több szó. Hozd a készpénzt ehhez: %s, és menj arra a helyre, amit mindjárt küldök.",
    ['dealer.orderExpired']     = "Túl sokáig tartott. Az üzlet dugába dőlt.",
    ['dealer.dropLabel']        = 'Átadási pont',
    ['dealer.dropBody']         = "Tessék. Ne lógj itt.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'Rendelés átvétele',
    ['collect.success']    = 'Öröm volt üzletelni veled.',
    ['collect.failed']     = 'Sikertelen',
    ['collect.tooFar']     = "Még nem vagy elég közel.",
    ['collect.noOrder']    = "Nem vár rád semmi.",
    ['collect.notEnoughCash'] = "Gyere vissza, ha tényleg megvan a pénz.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'Összefirkált cetli',
}
