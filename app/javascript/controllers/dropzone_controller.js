import { Controller } from '@hotwired/stimulus'
import { destroy } from '@rails/request.js'

// Connects to data-controller="dropzone"
export default class extends Controller {
  static targets = ['process', 'continue']
  static values = {
    purgeUrl: String,
  }

  connect() {
    document.addEventListener('turbo:load', () => {
      const { element } = HSFileUpload.getInstance(this.element, true)

      const { dropzone } = element

      dropzone.on('addedfile', () => {
        //this.processTarget.classList.remove('hidden')
      })

      dropzone.on('success', () => {
        this.continueTarget.classList.remove('hidden')
        this.processTarget.classList.add('hidden')
      })

      dropzone.on('removedfile', async (file) => {
        if (!file.xhr) return

        const { id } = JSON.parse(file.xhr.response)
        const response = await destroy(this.purgeUrlValue.replace('__ID__', id))
      })
    })
  }

  process() {
    const { element } = HSFileUpload.getInstance(this.element, true)

    const { dropzone } = element

    dropzone.processQueue()
  }

  disconnect() {
    document.removeEventListener('turbo:load', () => {
      const { element } = HSFileUpload.getInstance(this.element, true)
      const { dropzone } = element
      dropzone.off('removedfile')
    })
  }
}
