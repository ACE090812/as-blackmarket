Locales = Locales or {}

Locales['ro'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "Încet.",
    ['dealer.alreadyHaveOrder'] = "Ai deja ceva pe drum. Rezolvă mai întâi asta.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "Nu mai spune nimic. Adu banii cash pentru %s și du-te la locația pe care ți-o trimit imediat.",
    ['dealer.orderExpired']     = "Ai întârziat prea mult. Înțelegerea e anulată.",
    ['dealer.dropLabel']        = 'Punct de predare',
    ['dealer.dropBody']         = "Uite. Nu pierde vremea.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'Ridică comanda',
    ['collect.success']    = 'Mă bucur că am făcut afaceri.',
    ['collect.failed']     = 'Eșuat',
    ['collect.tooFar']     = "Nu ești încă destul de aproape.",
    ['collect.noOrder']    = "Nu ai nimic care te așteaptă.",
    ['collect.notEnoughCash'] = "Întoarce-te când ai banii cu adevărat.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'Bilet mâzgălit',
}
