# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@stimulus-components/notification", to: "@stimulus-components--notification.js" # @3.0.0
pin "stimulus-use" # @0.52.2
pin "air-datepicker/air-datepicker.css", to: "air-datepicker--air-datepicker.css.js" # @3.5.3
pin "air-datepicker/locale/en", to: "air-datepicker--locale--en.js" # @3.5.3
pin "air-datepicker", to: "air-datepicker--air-datepicker.js.js" # @3.5.3
pin "@hotwired/stimulus", to: "stimulus.min.js"
