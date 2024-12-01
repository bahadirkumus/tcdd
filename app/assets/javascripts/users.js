document.addEventListener("DOMContentLoaded", function () {
    const bioForm = document.getElementById("bio-form");
    if (bioForm) {
        bioForm.addEventListener("ajax:success", function (event) {
            const [data, status, xhr] = event.detail;
            document.getElementById("bio-update-message").innerHTML = "<p class='alert alert-success'>Bio was successfully updated.</p>";
        });

        bioForm.addEventListener("ajax:error", function (event) {
            const [data, status, xhr] = event.detail;
            document.getElementById("bio-update-message").innerHTML = "<p class='alert alert-danger'>Failed to update bio.</p>";
        });
    }

    const locationForm = document.getElementById("location-form");
    if (locationForm) {
        locationForm.addEventListener("ajax:success", function (event) {
            const [data, status, xhr] = event.detail;
            document.getElementById("location-update-message").innerHTML = "<p class='alert alert-success'>Location was successfully updated.</p>";
        });

        locationForm.addEventListener("ajax:error", function (event) {
            const [data, status, xhr] = event.detail;
            document.getElementById("location-update-message").innerHTML = "<p class='alert alert-danger'>Failed to update location.</p>";
        });
    }
});