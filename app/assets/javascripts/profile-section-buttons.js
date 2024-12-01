// Wait for the DOM to be fully loaded before running the script
document.addEventListener("DOMContentLoaded", function () {
    // Select all buttons and content sections
    const buttons = document.querySelectorAll(".profile-section-button");
    const tabs = document.querySelectorAll(".profile-tab-content");

    // Function to handle the button click
    function handleButtonClick(event) {
        // Get the closest button with the "profile-section-button" class
        const button = event.target.closest(".profile-section-button");

        if (button) {
            // Remove "selected" class from all buttons
            buttons.forEach(btn => btn.classList.remove("selected"));

            // Add "selected" class to the clicked button
            button.classList.add("selected");

            // Hide all tabs
            tabs.forEach(tab => tab.style.display = "none");

            // Get the target tab from the button's data attribute
            const targetId = button.getAttribute("data-target");
            const targetTab = document.getElementById(targetId);

            // Display the target tab if it exists
            if (targetTab) {
                targetTab.style.display = "block";
            }
        }
    }

    // Add click event listeners to each button
    buttons.forEach(button => {
        button.addEventListener("click", handleButtonClick);
    });
});