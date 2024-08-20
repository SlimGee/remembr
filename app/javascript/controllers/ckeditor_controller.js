import { Controller } from '@hotwired/stimulus'
import {
  ClassicEditor,
  Essentials,
  CKFinderUploadAdapter,
  Autoformat,
  Bold,
  Italic,
  BlockQuote,
  CKBox,
  CKFinder,
  EasyImage,
  Heading,
  Image,
  ImageCaption,
  ImageStyle,
  ImageToolbar,
  ImageUpload,
  PictureEditing,
  Indent,
  Link,
  List,
  MediaEmbed,
  Paragraph,
  PasteFromOffice,
  Table,
  TableToolbar,
  TextTransformation,
  CloudServices,
} from 'ckeditor5'

import 'ckeditor5/ckeditor5.css'

class Editor extends ClassicEditor {
  static builtinPlugins = [
    Essentials,
    CKFinderUploadAdapter,
    Autoformat,
    Bold,
    Italic,
    BlockQuote,
    CKBox,
    CKFinder,
    CloudServices,
    EasyImage,
    Heading,
    Image,
    ImageCaption,
    ImageStyle,
    ImageToolbar,
    ImageUpload,
    Indent,
    Link,
    List,
    MediaEmbed,
    Paragraph,
    PasteFromOffice,
    PictureEditing,
    Table,
    TableToolbar,
    TextTransformation,
  ]

  static defaultConfig = {
    toolbar: {
      items: [
        'undo',
        'redo',
        '|',
        'heading',
        '|',
        'bold',
        'italic',
        '|',
        'link',
        'uploadImage',
        'insertTable',
        'blockQuote',
        'mediaEmbed',
        '|',
        'bulletedList',
        'numberedList',
        'outdent',
        'indent',
      ],
    },
    image: {
      toolbar: [
        'imageStyle:inline',
        'imageStyle:block',
        'imageStyle:side',
        '|',
        'toggleImageCaption',
        'imageTextAlternative',
      ],
    },
    table: {
      contentToolbar: ['tableColumn', 'tableRow', 'mergeTableCells'],
    },
    language: 'en',
  }
}

// Connects to data-controller="ckeditor"
export default class extends Controller {
  connect() {
    Editor.create(this.element, Editor.defaultConfig)
  }
}
