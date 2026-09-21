Locales = Locales or {}

Locales['cs'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "Zpomal.",
    ['dealer.alreadyHaveOrder'] = "Už něco máš na cestě. Nejdřív to vyřeš.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "Ani slovo víc. Přines hotovost za: %s a jdi na místo, které ti hned pošlu.",
    ['dealer.orderExpired']     = "Trvalo ti to moc dlouho. Obchod je zrušen.",
    ['dealer.dropLabel']        = 'Místo předání',
    ['dealer.dropBody']         = "Tady. Neflákej se.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'Vyzvednout objednávku',
    ['collect.success']    = 'Bylo mi potěšením.',
    ['collect.failed']     = 'Selhalo',
    ['collect.tooFar']     = "Ještě nejsi dost blízko.",
    ['collect.noOrder']    = "Nic na tebe nečeká.",
    ['collect.notEnoughCash'] = "Vrať se, až budeš mít opravdu peníze.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'Naškrábaný vzkaz',
}
