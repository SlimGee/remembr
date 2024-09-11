import { Controller } from '@hotwired/stimulus'
import Dropzone from 'dropzone'
import { DirectUpload } from '@rails/activestorage'
import { destroy } from '@rails/request.js'
import { getMetaValue, findElement, removeElement, insertAfter } from '../helpers'

// Connects to data-controller="dropzone"
export default class extends Controller {
  static targets = ['input', 'clickable', 'previewsContainer', 'previewTemplate']

  static values = { existingFiles: Array, destroyUrl: String }

  connect() {
    this.dropZone = createDropZone(this)
    this.hideFileInput()
    this.bindEvents()
  }

  hideFileInput() {
    this.inputTarget.disabled = true
    this.inputTarget.style.display = 'none'
  }

  bindEvents() {
    this.dropZone.on('addedfile', (file) => {
      setTimeout(() => {
        file.accepted && createDirectUploadController(this, file).start()
      }, 500)
    })

    this.dropZone.on('removedfile', (file) => {
      file.controller && removeElement(file.controller.hiddenInput)
    })

    this.dropZone.on('canceled', (file) => {
      file.controller && file.controller.xhr.abort()
    })

    this.dropZone.on('processing', (file) => {
      this.submitButton.disabled = true
    })

    this.dropZone.on('queuecomplete', (file) => {
      this.submitButton.disabled = false
    })

    this.dropZone.on('removedfile', (file) => {
      if (file.status === Dropzone.SUCCESS) {
        destroy(this.destroyUrlValue.replace(':id', file.id), {
          contentType: 'application/json',
          headers: { accept: 'application/json' },
        })
      }
    })
  }

  get headers() {
    return { 'X-CSRF-Token': getMetaValue('csrf-token') }
  }

  get url() {
    return this.inputTarget.getAttribute('data-direct-upload-url')
  }

  get maxFiles() {
    return this.data.get('maxFiles') || 1
  }

  get maxFileSize() {
    return this.data.get('maxFileSize') || 256
  }

  get acceptedFiles() {
    return this.data.get('acceptedFiles')
  }

  get addRemoveLinks() {
    return this.data.get('addRemoveLinks') || false
  }

  get form() {
    return this.element.closest('form')
  }

  get submitButton() {
    return findElement(this.form, 'input[type=submit], button[type=submit]')
  }

  get clickable() {
    return this.hasClickableTarget ? this.clickableTargets : this.element
  }

  get previewsContainer() {
    return this.previewsContainerTarget || this.element
  }

  get previewTemplate() {
    return this.previewTemplateTarget.innerHTML
  }

  get existingFiles() {
    return this.existingFilesValue
  }

  get dropZoneOptions() {
    return JSON.parse(this.data.get('options') || '{}')
  }
}

class DirectUploadController {
  constructor(source, file) {
    this.directUpload = createDirectUpload(file, source.url, this)
    this.source = source
    this.file = file
  }

  start() {
    this.file.controller = this
    this.hiddenInput = this.createHiddenInput()
    this.directUpload.create((error, attributes) => {
      if (error) {
        removeElement(this.hiddenInput)
        this.emitDropzoneError(error)
      } else {
        this.hiddenInput.value = attributes.signed_id
        this.file.id = attributes.id
        this.emitDropzoneSuccess()
      }
    })
  }

  // Private
  createHiddenInput() {
    const input = document.createElement('input')
    input.type = 'hidden'
    input.name = this.source.inputTarget.name
    insertAfter(input, this.source.inputTarget)
    return input
  }

  directUploadWillStoreFileWithXHR(xhr) {
    this.bindProgressEvent(xhr)
    this.emitDropzoneUploading()
  }

  bindProgressEvent(xhr) {
    this.xhr = xhr
    this.xhr.upload.addEventListener('progress', (event) => this.uploadRequestDidProgress(event))
  }

  uploadRequestDidProgress(event) {
    const element = this.source.element
    const progress = (event.loaded / event.total) * 100
    if (findElement(this.file.previewTemplate, '.dz-upload')) {
      findElement(this.file.previewTemplate, '.dz-upload').style.width = `${progress}%`
    }
  }

  emitDropzoneUploading() {
    this.file.status = Dropzone.UPLOADING
    this.source.dropZone.emit('processing', this.file)
  }

  emitDropzoneError(error) {
    this.file.status = Dropzone.ERROR
    this.source.dropZone.emit('error', this.file, error)
    this.source.dropZone.emit('complete', this.file)
  }

  emitDropzoneSuccess() {
    this.file.status = Dropzone.SUCCESS
    this.source.dropZone.emit('success', this.file)
    this.source.dropZone.emit('complete', this.file)
  }
}

function createDirectUploadController(source, file) {
  return new DirectUploadController(source, file)
}

function createDirectUpload(file, url, controller) {
  return new DirectUpload(file, url, controller)
}

function createDropZone(controller) {
  return new Dropzone(
    controller.element,
    Object.assign(
      {
        url: controller.url,
        headers: controller.headers,
        maxFiles: controller.maxFiles,
        maxFilesize: controller.maxFileSize,
        acceptedFiles: controller.acceptedFiles,
        addRemoveLinks: controller.addRemoveLinks,
        autoQueue: false,
        clickable: controller.clickable,
        previewsContainer: controller.previewsContainer,
        previewTemplate: controller.previewTemplate,
        init: function () {
          let thisDropzone = this

          thisDropzone.on('thumbnail', function (file) {
            if (file.status === Dropzone.SUCCESS) {
              if (findElement(file.previewTemplate, '.dz-upload')) {
                findElement(file.previewTemplate, '.dz-upload').style.width = `100%`
              }
            }
          })

          controller.existingFiles.forEach((file) => {
            const mockFile = {
              id: file.id,
              name: file.name,
              size: file.size,
              status: Dropzone.SUCCESS,
            }
            thisDropzone.options.addedfile.call(thisDropzone, mockFile)
            thisDropzone.emit('thumbnail', mockFile, file.url)
          })
        },
      },
      controller.dropZoneOptions,
    ),
  )
}
