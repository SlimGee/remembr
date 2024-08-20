// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails'
import * as _ from 'lodash'
import Dropzone from 'dropzone'

window.Dropzone = Dropzone
window._ = _

import './controllers'

import 'swiper/css/bundle'

import 'preline'
import '@preline/remove-element'

document.addEventListener('turbo:load', () => {
  window.HSStaticMethods.autoInit()
})
