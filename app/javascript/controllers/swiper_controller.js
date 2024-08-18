import { Controller } from "@hotwired/stimulus";
import Swiper from "swiper/bundle";
//import "swiper/css/bundle";

// Connects to data-controller="swiper"
export default class extends Controller {
  connect() {
    console.log("Swiper connected");
    this.swiper = new Swiper(this.element, {
      // Swiper configuration options
      pagination: {
        el: ".swiper-pagination",
      },
      loop: true,
      effect: "fade",
      fadeEffect: {
        crossFade: true,
      },
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
    });
  }
}
