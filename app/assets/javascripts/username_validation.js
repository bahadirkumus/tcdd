document.addEventListener("DOMContentLoaded", function () {
    const usernameInput = document.querySelector("#user_username");

    usernameInput.addEventListener("input", function () {
        const username = usernameInput.value;
        const minLength = 4;
        const maxLength = 16;
        const usernamePattern = /^(?=.*[a-zA-Z])[a-z0-9_]+$/;

        if (username.length < minLength || username.length > maxLength || !usernamePattern.test(username)) {
            usernameInput.classList.remove("valid");
            usernameInput.classList.add("invalid");
            return;
        }

        fetch(`/users/check_username?username=${encodeURIComponent(username)}`)
            .then(response => response.json())
            .then(data => {
                if (data.exists) {
                    usernameInput.classList.remove("valid");
                    usernameInput.classList.add("invalid");
                } else {
                    usernameInput.classList.remove("invalid");
                    usernameInput.classList.add("valid");
                }
            });
    });
});