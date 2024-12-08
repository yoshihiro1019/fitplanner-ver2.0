import "@hotwired/turbo-rails"
import "./controllers"

// turbo:loadイベントでイベントリスナを再登録
document.addEventListener("turbo:load", function() {
  const form = document.getElementById("question-form");
  const loadingIndicator = document.getElementById("loading-indicator");

  if (form && loadingIndicator) {
    // 送信前にスピナー表示
    form.addEventListener("turbo:submit-start", function() {
      loadingIndicator.style.display = "flex";
    });

    // レスポンス取得後（回答表示後）にスピナー非表示
    form.addEventListener("turbo:submit-end", function() {
      loadingIndicator.style.display = "none";
    });
  }
});

