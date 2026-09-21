Locales = Locales or {}

Locales['ar'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "على مهلك.",
    ['dealer.alreadyHaveOrder'] = "لديك شيء في الطريق بالفعل. أنهِ ذلك أولاً.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "كفى كلامًا. أحضر النقود مقابل %s واذهب إلى الموقع الذي سأرسله لك الآن.",
    ['dealer.orderExpired']     = "تأخرت كثيرًا. الصفقة ألغيت.",
    ['dealer.dropLabel']        = 'نقطة التسليم',
    ['dealer.dropBody']         = "تفضل. لا تتلكأ.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'استلام الطلب',
    ['collect.success']    = 'سعدت بالتعامل معك.',
    ['collect.failed']     = 'فشل',
    ['collect.tooFar']     = "لم تقترب بما يكفي بعد.",
    ['collect.noOrder']    = "ليس لديك شيء بانتظارك.",
    ['collect.notEnoughCash'] = "عد عندما يكون معك المال فعلًا.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'ملاحظة مخربشة',
}
