// Wait for the DOM to be fully loaded before running the script
document.addEventListener("DOMContentLoaded", function () {
    function initializeDropdownMenu() {
        const settingsButton = document.getElementById('settings-button');
        const dropdownMenu = document.getElementById('dropdown-menu');

        if (settingsButton && dropdownMenu) {
            settingsButton.onclick = null;
            document.onclick = null;

            settingsButton.addEventListener('click', function (event) {
                event.stopPropagation();
                dropdownMenu.style.display = dropdownMenu.style.display === 'block' ? 'none' : 'block';
            });

            document.addEventListener('click', function (event) {
                if (!dropdownMenu.contains(event.target) && event.target !== settingsButton) {
                    dropdownMenu.style.display = 'none';
                }
            });
        }
    }

    window.addEventListener('pageshow', initializeDropdownMenu);
});