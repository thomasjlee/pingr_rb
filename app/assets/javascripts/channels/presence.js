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
            emailForUser.classList.remove('user-offline', 'user-away')
            emailForUser.textContent = emailForUser.textContent.replace(/away|offline/, 'online')
          }

          var onlineIndicator = this.onlineIndicator(userId)
          if (onlineIndicator) {
            onlineIndicator.classList.add('online-indicator')
            onlineIndicator.classList.remove('offline-indicator', 'away-indicator')
          }

          var notification = '<span class="is-online">' + username  + ' is now online</span>'
          var notificationHolder = document.querySelector('[data-is_online]')
          notificationHolder.innerHTML = ''
          notificationHolder.insertAdjacentHTML('afterbegin', notification)
        },

        notifyOffline: function(userId) {
          var emailForUser = this.emailForUser(userId)
          if (emailForUser) {
            emailForUser.classList.remove('user-online', 'user-away')
            emailForUser.classList.add('user-offline')
            emailForUser.textContent = emailForUser.textContent.replace(/away|online/, 'offline')
          }

          var onlineIndicator = this.onlineIndicator(userId)
          if (onlineIndicator) {
            onlineIndicator.classList.remove('online-indicator', 'away-indicator')
            onlineIndicator.classList.add('offline-indicator')
          }
        },

        emailForUser: function(userId) {
          return document.querySelector('[data-email-for-user="' + userId + '"]')
        },

        onlineIndicator: function(userId) {
          return document.querySelector('[data-online-indicator="' + userId + '"]')
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
