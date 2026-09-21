Locales = Locales or {}

Locales['el'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "Χαλάρωσε.",
    ['dealer.alreadyHaveOrder'] = "Έχεις ήδη κάτι στο δρόμο. Πρώτα τακτοποίησε αυτό.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "Ούτε λέξη παραπάνω. Φέρε τα μετρητά για: %s και πήγαινε στην τοποθεσία που θα σου στείλω σε λίγο.",
    ['dealer.orderExpired']     = "Άργησες πολύ. Η συμφωνία ακυρώνεται.",
    ['dealer.dropLabel']        = 'Σημείο παράδοσης',
    ['dealer.dropBody']         = "Ορίστε. Μην χαζεύεις.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'Παραλαβή παραγγελίας',
    ['collect.success']    = 'Χάρηκα για τη συνεργασία.',
    ['collect.failed']     = 'Απέτυχε',
    ['collect.tooFar']     = "Δεν είσαι ακόμα αρκετά κοντά.",
    ['collect.noOrder']    = "Δεν έχεις τίποτα να σε περιμένει.",
    ['collect.notEnoughCash'] = "Γύρνα όταν έχεις πραγματικά τα λεφτά.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'Μουντζουρωμένο σημείωμα',
}
