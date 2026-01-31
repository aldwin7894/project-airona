import "iconify-icon";
import Alpine from "alpinejs";
import { Chart, PieController, ArcElement, Tooltip } from "chart.js";
import Tippy, { followCursor } from "tippy.js";
import { themeChange } from "theme-change";

import "tippy.js/dist/tippy.css";
import "tippy.js/themes/light.css";
import "tippy.js/animations/perspective-subtle.css";
import "tippy.js/animations/shift-away-subtle.css";

import "~/stylesheets/application.css.scss";
import "../controllers";

const initElems = (parent = null) => {
  // popover
  const tippyPopoverList = Array.prototype.slice.call(
    (parent || document).querySelectorAll("[data-tippy=popover]"),
  );
  Tippy(tippyPopoverList, {
    theme: "light",
    trigger: "click",
    animation: "shift-away-subtle",
    placement: "bottom",
    interactive: true,
    content(reference) {
      const id = reference.dataset.tippyTemplate;
      const template = document.getElementById(id);
      return template.innerHTML;
    },
    allowHTML: true,
  });

  // tooltip
  const tippyTooltipList = Array.prototype.slice.call(
    (parent || document).querySelectorAll("[data-tippy=tooltip]"),
  );
  Tippy(tippyTooltipList, {
    theme: "light",
    placement: "top",
    followCursor: "horizontal",
    animation: "perspective-subtle",
    plugins: [followCursor],
    allowHTML: true,
  });
};

const fadeIn = id =>
  new Promise((resolve, _reject) => {
    const element = document.getElementById(id);
    element.style.willChange = "opacity";
    element.classList.add("animate__fadeIn", "animate__animated");

    function handleAnimationEnd(event) {
      event.stopPropagation();
      initElems(element);
      element.classList.remove("animate__fadeIn", "animate__animated");
      element.style.willChange = "auto";
      resolve("Animation ended");
    }

    element.addEventListener("animationend", handleAnimationEnd, {
      once: true,
    });
  });

const fadeOut = id =>
  new Promise((resolve, _reject) => {
    const element = document.getElementById(id);
    element.style.willChange = "opacity";
    element.classList.add("animate__fadeOut", "animate__animated");

    function handleAnimationEnd(event) {
      event.stopPropagation();
      element.classList.remove("animate__fadeOut", "animate__animated");
      element.style.willChange = "auto";
      resolve("Animation ended");
    }

    element.addEventListener("animationend", handleAnimationEnd, {
      once: true,
    });
  });

// fade animations
window.addEventListener("load", () => {
  const loader = document.getElementById("loader");
  const main = document.getElementById("main");
  const footer = document.getElementById("footer");

  loader?.classList?.add("animate__animated", "animate__fadeOut");
  loader?.addEventListener("animationend", () => {
    loader?.classList?.remove("animate__animated", "animate__fadeOut");
    loader?.classList?.add("hidden");
    main?.classList?.remove("hidden");
    footer?.classList?.remove("hidden");
    main?.classList?.add("animate__fadeIn", "animate__animated");
    initElems();
  });
});

Chart.register(PieController, ArcElement, Tooltip);

Object.assign(globalThis, {
  Alpine,
  Chart,
  Tippy,
  Navigation,
  fadeIn,
  fadeOut,
});
Alpine.start();
themeChange();
