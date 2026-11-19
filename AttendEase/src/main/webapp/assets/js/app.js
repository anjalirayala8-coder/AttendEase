document.addEventListener("DOMContentLoaded", function () {
  const modal = document.getElementById("studentModal");
  document.querySelectorAll("[data-modal-open]").forEach(button => button.addEventListener("click", () => {
    const target = document.getElementById(button.dataset.modalOpen);
    if (target) { target.classList.add("show"); target.setAttribute("aria-hidden", "false"); }
  }));
  document.querySelectorAll("[data-modal-close]").forEach(button => button.addEventListener("click", () => {
    const target = button.closest(".modal-backdrop");
    if (target) { target.classList.remove("show"); target.setAttribute("aria-hidden", "true"); }
  }));
  if (modal) modal.addEventListener("click", event => {
    if (event.target === modal) { modal.classList.remove("show"); modal.setAttribute("aria-hidden", "true"); }
  });

  document.querySelectorAll(".status-picker").forEach(picker => {
    picker.querySelectorAll("input[type=radio]").forEach(input => input.addEventListener("change", () => {
      picker.querySelectorAll(".status-option").forEach(label => label.classList.remove("selected"));
      input.closest(".status-option").classList.add("selected");
    }));
  });
  document.querySelectorAll("[data-set-all]").forEach(button => button.addEventListener("click", () => {
    const status = button.dataset.setAll;
    document.querySelectorAll("#attendanceForm .status-picker").forEach(picker => {
      const input = picker.querySelector('input[value="' + status + '"]');
      if (input) {
        input.checked = true;
        input.dispatchEvent(new Event("change", { bubbles: true }));
      }
    });
  }));
});