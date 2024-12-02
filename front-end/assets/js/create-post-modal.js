        document.addEventListener("DOMContentLoaded", () => {
            const createPostButton = document.getElementById("create-post-button");
            const modal = document.getElementById("create-post-modal");
            const closeButton = document.querySelector(".create-post-modal-close-button");

            createPostButton.addEventListener("click", () => {
                modal.style.display = "flex"; // Make the modal visible
            });

            // Close modal when close button is clicked
            closeButton.addEventListener("click", () => {
                modal.style.display = "none";
            });

            // Close modal when clicking outside the modal content
            modal.addEventListener("click", (e) => {
                if (e.target === modal) {
                    modal.style.display = "none";
                }
            });
        });