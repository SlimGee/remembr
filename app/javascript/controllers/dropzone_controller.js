import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dropzone"
export default class extends Controller {
  static targets = ["process", "continue"];
  connect() {
    document.addEventListener("turbo:load", () => {
      const { element } = HSFileUpload.getInstance(this.element, true);

      const { dropzone } = element;

      dropzone.on("addedfile", () => {
        this.processTarget.classList.remove("hidden");
      });
      dropzone.on("completemultiple", () => {
        console.log("completemultiple");
        this.continueTarget.classList.remove("hidden");
        this.processTarget.classList.add("hidden");
      });
    });
  }

  process() {
    const { element } = HSFileUpload.getInstance(this.element, true);

    const { dropzone } = element;

    dropzone.processQueue();
  }
}
