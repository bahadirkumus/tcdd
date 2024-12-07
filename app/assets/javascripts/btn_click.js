document.addEventListener("DOMContentLoaded", function() {
    const btnSignIn = document.getElementById("btn-sign-in");
    const btnCreateAccount = document.getElementById("btn-create-account");
    const navbarProfileButton = document.getElementById("navbar-profile-button");

    // Check if #btn-sign-in exists
    if (btnSignIn) {
        btnSignIn.addEventListener("click", function() {
            window.location.href = "profile.html";
        });
    }

    // Check if #navbar-profile-button exists
    if (btnCreateAccount) {
        btnCreateAccount.addEventListener("click", function() {
            window.location.href = "create-account.html";
        });
    }
    if (navbarProfileButton) {
        navbarProfileButton.addEventListener("click", function() {
            window.location.href = "index.html";
        });
    }
});

