Locales = Locales or {}

Locales['tr'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "Yavaş ol.",
    ['dealer.alreadyHaveOrder'] = "Zaten yolda bir şeyin var. Önce onu hallet.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "Tamam, fazla söze gerek yok. %s için nakiti getir ve birazdan göndereceğim konuma git.",
    ['dealer.orderExpired']     = "Çok uzattın. Anlaşma iptal.",
    ['dealer.dropLabel']        = 'Bırakma noktası',
    ['dealer.dropBody']         = "İşte burası. Oyalanma.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'Siparişi al',
    ['collect.success']    = 'Seninle iş yapmak bir zevkti.',
    ['collect.failed']     = 'Başarısız',
    ['collect.tooFar']     = "Henüz yeterince yakın değilsin.",
    ['collect.noOrder']    = "Seni bekleyen bir şey yok.",
    ['collect.notEnoughCash'] = "Gerçekten paran olunca gel.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'Karalanmış not',
}
