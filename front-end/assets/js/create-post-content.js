document.addEventListener("DOMContentLoaded", () => {
            const writePostBtn = document.getElementById("write-post-btn");
            const photoPostBtn = document.getElementById("photo-post-btn");
            const writePostForm = document.getElementById("write-post-form");
            const photoPostForm = document.getElementById("photo-post-form");


            // Toggle between forms
            writePostBtn.addEventListener("click", () => {
                writePostForm.classList.add("active");
                photoPostForm.classList.remove("active");
                writePostBtn.classList.add("active");
                photoPostBtn.classList.remove("active");
            });

            photoPostBtn.addEventListener("click", () => {
                photoPostForm.classList.add("active");
                writePostForm.classList.remove("active");
                photoPostBtn.classList.add("active");
                writePostBtn.classList.remove("active");
            });
        });