document.addEventListener('turbolinks:load', function() {
  if (shouldConnect()) {
    if (!App.presence) {
      App.presence = App.cable.subscriptions.create("PresenceChannel", {
        connected: function() { },

        disconnected: function() { },

        received: function(data) {
          var online = data['online']
          var userId = data['user_id']
          var username = data['username']
          online ? this.notifyOnline(userId, username) : this.notifyOffline(userId)
        },

        notifyOnline: function(userId, username) {
          var emailForUser = this.emailForUser(userId)
          if (emailForUser) {
            emailForUser.classList.add('user-online')
            emailForUser.classList.remove('user-offline')
          }

          var onlineIndicator = this.onlineIndicator(userId)
          if (onlineIndicator) {
            onlineIndicator.classList.add('bg-purple')
            onlineIndicator.classList.remove('bg-secondary')
          }


          var notification = '<span class="is-online">' + username  + ' is now online</span>'
          var notificationHolder = document.querySelector('[data-is_online]')
          notificationHolder.innerHTML = ''
          notificationHolder.insertAdjacentHTML('afterbegin', notification)
        },

        notifyOffline: function(userId) {
          var emailForUser = this.emailForUser(userId)
          if (emailForUser) {
            emailForUser.classList.remove('user-online')
            emailForUser.classList.add('user-offline')
          }

          var onlineIndicator = this.onlineIndicator(userId)
          if (onlineIndicator) {
            onlineIndicator.classList.remove('bg-purple')
            onlineIndicator.classList.add('bg-secondary')
          }
        },

        emailForUser: function(userId) {
          return document.querySelector('[data-email_for_user="' + userId + '"]')
        },

        onlineIndicator: function(userId) {
          return document.querySelector('[data-online_indicator="' + userId + '"]')
        }
      })
    }
  }

  function shouldConnect() {
    // User is authenticated
    // TODO: Move this function to a shared object
    return Boolean(document.querySelector('meta[name="current_user"]'))
  }
})
