App.pings = App.cable.subscriptions.create("PingsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  // TESTME
  received: function(data) {
    var unreadPings = document.querySelector('[data-unread_pings]')
    if (unreadPings) {
      unreadPings.insertAdjacentHTML('afterbegin', data.html)
    }
    unreadPingsCount = document.querySelector('[data-unread_pings_count]')
    count = parseInt(unreadPingsCount.textContent)
    unreadPingsCount.textContent = ++count
  }
});
