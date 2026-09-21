Locales = Locales or {}

Locales['it'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "Vacci piano.",
    ['dealer.alreadyHaveOrder'] = "Hai già qualcosa in arrivo. Sistema prima quello.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "Non dire altro. Porta i contanti per %s e vai al posto che sto per mandarti.",
    ['dealer.orderExpired']     = "Ci hai messo troppo. L'affare è saltato.",
    ['dealer.dropLabel']        = 'Punto di consegna',
    ['dealer.dropBody']         = "Ecco. Non stare a bighellonare.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'Ritira l\'ordine',
    ['collect.success']    = 'È stato un piacere fare affari.',
    ['collect.failed']     = 'Fallito',
    ['collect.tooFar']     = "Non sei ancora abbastanza vicino.",
    ['collect.noOrder']    = "Non hai niente che ti aspetta.",
    ['collect.notEnoughCash'] = "Torna quando avrai davvero i soldi.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'Biglietto scarabocchiato',
}
