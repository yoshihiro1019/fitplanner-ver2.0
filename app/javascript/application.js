// ✅ これは app/javascript/application.js に配置してください！

import "@hotwired/turbo-rails"
import "./controllers"

console.log("✅ application.js 読み込まれた");

document.addEventListener("turbo:load", function () {
  console.log("✅ turbo:load イベント発火");

  const form = document.getElementById("question-form");
  const loadingIndicator = document.getElementById("loading-indicator");

  if (form && loadingIndicator) {
    form.addEventListener("turbo:submit-start", function () {
      loadingIndicator.style.display = "flex";
    });

    form.addEventListener("turbo:submit-end", function () {
      loadingIndicator.style.display = "none";
    });
  }

  const menuToggle = document.getElementById("menu-toggle");
  const menu = document.getElementById("menu");

  if (menuToggle && menu) {
    menuToggle.addEventListener("click", function () {
      menu.classList.toggle("hidden");
    });
  }
});
