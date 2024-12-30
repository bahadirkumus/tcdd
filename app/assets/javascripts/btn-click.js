document.addEventListener("DOMContentLoaded", function () {
    const buttons = document.querySelectorAll(".profile-section-button");
    const tabContents = document.querySelectorAll(".profile-tab-content");

    buttons.forEach((button) => {
        button.addEventListener("click", function () {
            tabContents.forEach((tab) => tab.style.display = "none");

            buttons.forEach((btn) => btn.classList.remove("selected"));

            this.classList.add("selected");

            const targetId = this.getAttribute("data-target");
            const targetTab = document.getElementById(targetId);
            if (targetTab) targetTab.style.display = "block";
        });
    });
});
