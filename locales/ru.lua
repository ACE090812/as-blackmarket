Locales = Locales or {}

Locales['ru'] = {
    -- Dealer text messages (sent to the player through the phone's Messages app)
    ['dealer.orderCooldown']    = "Не спеши.",
    ['dealer.alreadyHaveOrder'] = "У тебя уже есть заказ в пути. Сначала разберись с ним.",
    -- Cash-on-collection: the dealer brings the item, you bring the money. Naming it here is
    -- just so the text confirms what you actually ordered, not an instruction to bring it.
    ['dealer.orderConfirmed']   = "Без лишних слов. Принеси наличные за: %s и отправляйся на точку, которую я сейчас скину.",
    ['dealer.orderExpired']     = "Слишком долго. Сделка отменяется.",
    ['dealer.dropLabel']        = 'Точка передачи',
    ['dealer.dropBody']         = "Вот. Не задерживайся.",

    -- Order / catalog text
    ['order.multiLabel']   = '%dx %s',
    ['catalog.entry']      = '%s - $%d',

    -- Collection at the drop point
    ['collect.target']     = 'Забрать заказ',
    ['collect.success']    = 'Приятно иметь с тобой дело.',
    ['collect.failed']     = 'Не удалось',
    ['collect.tooFar']     = "Ты ещё недостаточно близко.",
    ['collect.noOrder']    = "Тебя ничего не ждёт.",
    ['collect.notEnoughCash'] = "Вернись, когда у тебя реально будут деньги.",

    -- Sticky note popup (NUI)
    ['ui.noteHeading']     = 'Нацарапанная записка',
}
