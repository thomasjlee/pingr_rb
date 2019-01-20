document.addEventListener('turbolinks:load', function() {
  if (shouldConnect()) {
    if (!App.presence) {
      App.presence = App.cable.subscriptions.create("PresenceChannel", {
        connected: function() {
          // Called when the subscription is ready for use on the server
        },

        disconnected: function() {
          // Called when the subscription has been terminated by the server
        },

        received: function(data) {
          // Called when there's incoming data on the websocket for this channel
          this.update(data)
        },

        update: function(data) {
          var userId = data['user_id']
          var online = data['online']
          this.updateOnlineIndicator(userId, online)
          this.updateUserEmail(userId, online)
        },

        updateOnlineIndicator: function(userId, online) {
          var onlineIndicator = this.onlineIndicator(userId)
          if (onlineIndicator) {
            if (online) {
              onlineIndicator.classList.remove('bg-secondary')
              onlineIndicator.classList.add('bg-purple')
            } else {
              onlineIndicator.classList.add('bg-secondary')
              onlineIndicator.classList.remove('bg-purple')
            }
          }
        },

        updateUserEmail: function(userId, online) {
          var userEmail = this.userEmail(userId)
          if (userEmail) {
            if (online) {
              userEmail.classList.add('user-online')
              userEmail.classList.remove('user-offline')
            } else {
              userEmail.classList.add('user-offline')
              userEmail.classList.remove('user-online')
            }
          }
        },

        onlineIndicator: function(userId) {
          return document.querySelector('[data-online_indicator="' + userId + '"]')
        },

        userEmail: function(userId) {
          return document.querySelector('[data-email_for_user="' + userId + '"]')
        }
      })
    }
  }

  function shouldConnect() {
    // User is authenticated
    return Boolean(document.querySelector('meta[name="current_user"]'))
  }
})
