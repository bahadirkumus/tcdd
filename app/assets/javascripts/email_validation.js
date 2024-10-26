document.addEventListener("DOMContentLoaded", function () {
    const emailInput = document.querySelector("#user_email");

    emailInput.addEventListener("input", function () {
        const email = emailInput.value;
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!emailPattern.test(email)) {
            emailInput.classList.remove("valid");
            emailInput.classList.add("invalid");
            console.log("Invalid email format");
            return;
        }

        fetch(`/users/check_email?email=${encodeURIComponent(email)}`)
            .then(response => response.json())
            .then(data => {
                console.log(data); // Log the response data
                if (data.exists) {
                    emailInput.classList.remove("valid");
                    emailInput.classList.add("invalid");
                } else {
                    emailInput.classList.remove("invalid");
                    emailInput.classList.add("valid");
                }
            })
            .catch(error => {
                console.error("Error:", error);
            });
    });
});