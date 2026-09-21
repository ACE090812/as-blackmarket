Locales = Locales or {}

Locales['fr'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "Doucement.",
    ['dealer.alreadyHaveOrder'] = "Tu as déjà quelque chose en route. Règle ça d'abord.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "Pas un mot de plus. Apporte le cash pour %s et rends-toi à l'endroit que je vais t'envoyer.",
    ['dealer.orderExpired']     = "Tu as pris trop de temps. L'affaire est annulée.",
    ['dealer.dropLabel']        = 'Point de livraison',
    ['dealer.dropBody']         = "Voilà. Ne traîne pas.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'Récupérer la commande',
    ['collect.success']    = 'Un plaisir de faire affaire.',
    ['collect.failed']     = 'Échec',
    ['collect.tooFar']     = "Tu n'es pas encore assez près.",
    ['collect.noOrder']    = "Tu n'as rien qui t'attend.",
    ['collect.notEnoughCash'] = "Reviens quand tu auras vraiment l'argent.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'Note griffonnée',
}
