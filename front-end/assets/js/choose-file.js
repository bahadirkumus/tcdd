    document.getElementById('choose-file-input').addEventListener('change', function () {
      const fileName = this.files[0] ? this.files[0].name : "No file selected";
      document.getElementById('file-name').textContent = fileName;
    });