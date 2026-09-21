Locales = Locales or {}

Locales['pt-br'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "Calma aí.",
    ['dealer.alreadyHaveOrder'] = "Você já tem uma encomenda a caminho. Resolva isso primeiro.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "Sem mais delongas. Traga a grana para %s e vá até o local que vou te mandar.",
    ['dealer.orderExpired']     = "Você demorou demais. Negócio cancelado.",
    ['dealer.dropLabel']        = 'Ponto de entrega',
    ['dealer.dropBody']         = "Aqui. Não fique de bobeira.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'Retirar encomenda',
    ['collect.success']    = 'Foi um prazer fazer negócio.',
    ['collect.failed']     = 'Falhou',
    ['collect.tooFar']     = "Você ainda não está perto o suficiente.",
    ['collect.noOrder']    = "Você não tem nada esperando.",
    ['collect.notEnoughCash'] = "Volte quando tiver o dinheiro de verdade.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'Bilhete rabiscado',
}
