document.addEventListener('turbolinks:load', function() {
  if (shouldConnect()) {
    if (!App.pings) {
      App.pings = App.cable.subscriptions.create("PingsChannel", {
        connected: function() {
          // Called when the subscription is ready for use on the server
        },

        disconnected: function() {
          // Called when the subscription has been terminated by the server
        },

        // TESTME
        received: function(data) {
          var unreadPingsUl     = this.unreadPingsUl()
          var markAllAsReadForm = this.markAllAsReadForm()

          if (unreadPingsUl) {
            unreadPingsUl.insertAdjacentHTML('afterbegin', data.html['ping'])

            if (!markAllAsReadForm) {
              unreadPingsUl.insertAdjacentHTML('afterend', data.html['mark_all_as_read'])
            }
          }

          this.updateUnreadPingsCount()
          this.exclaim()
        },

        updateUnreadPingsCount: function() {
          unreadPingsCount = this.unreadPingsCountSpan()
          count = parseInt(unreadPingsCount.textContent)
          unreadPingsCount.textContent = ++count
          unreadPingsCount.classList.add('badge-purple')
          unreadPingsCount.classList.remove('badge-secondary')
        },

        exclaim: function() {
          this.unreadPingsCountSpan().insertAdjacentHTML('beforebegin', '<span class="exclaim">!</span>')
        },

        unreadPingsUl: function() {
          return document.querySelector('[data-unread_pings]')
        },

        markAllAsReadForm: function() {
          return document.querySelector('form[action$="mark_all_as_read"]')
        },

        unreadPingsCountSpan: function() {
          return document.querySelector('[data-unread_pings_count]')
        }
      })
    }
  }

  function shouldConnect() {
    // User is authenticated
    return Boolean(document.querySelector('meta[name="current_user"]'))
  }
})
