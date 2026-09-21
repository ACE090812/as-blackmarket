Locales = Locales or {}

Locales['es'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "Cálmate un poco.",
    ['dealer.alreadyHaveOrder'] = "Ya tienes algo en camino. Soluciona eso primero.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "Sin más rodeos. Trae el efectivo para %s y ve a la ubicación que te voy a mandar.",
    ['dealer.orderExpired']     = "Has tardado demasiado. El trato se cancela.",
    ['dealer.dropLabel']        = 'Punto de entrega',
    ['dealer.dropBody']         = "Aquí es. No te quedes rondando.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'Recoger pedido',
    ['collect.success']    = 'Un placer hacer negocios.',
    ['collect.failed']     = 'Fallido',
    ['collect.tooFar']     = "Todavía no estás lo bastante cerca.",
    ['collect.noOrder']    = "No tienes nada esperando.",
    ['collect.notEnoughCash'] = "Vuelve cuando tengas el dinero de verdad.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'Nota garabateada',
}
