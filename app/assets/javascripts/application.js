document.addEventListener('turbo:load', function() {
    const form = document.querySelector('form');
    const searchResults = document.getElementById('search-results');

    form.addEventListener('ajax:success', function(event) {
        const [data, status, xhr] = event.detail;
        searchResults.innerHTML = data;
    });
});
