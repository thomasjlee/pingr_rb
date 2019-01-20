App.pings = App.cable.subscriptions.create("PingsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  // TESTME
  received: function(data) {
    console.dir(data)
    var unreadPings = document.querySelector('[data-unread_pings]')
    if (unreadPings) {
      unreadPings.insertAdjacentHTML('afterbegin', data.html['ping'])
    }

    unreadPingsCount = document.querySelector('[data-unread_pings_count]')
    count = parseInt(unreadPingsCount.textContent)
    unreadPingsCount.textContent = ++count

    var markAllAsRead = document.querySelector('form[action$="mark_all_as_read"]')
    if (!markAllAsRead) {
      unreadPings.insertAdjacentHTML('afterend', data.html['mark_all_as_read'])
    }
  }
});
