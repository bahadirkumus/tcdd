function animateIntro() {
    let intro = document.querySelector('.intro');
    let logo = document.querySelector('.logo-header');
    let logoSpan = document.querySelectorAll('.logo');

    if (!intro || !logo || logoSpan.length === 0) {
        console.warn('Required elements for animation not found.');
        return;
    }

    setTimeout(() => {
        logoSpan.forEach((span, idx) => {
            setTimeout(() => {
                span.classList.add('active');
            }, (idx + 1) * 400);
        });

        setTimeout(() => {
            logoSpan.forEach((span, idx) => {
                setTimeout(() => {
                    span.classList.remove('active');
                    span.classList.add('fade');
                }, (idx + 1) * 50);
            });
        }, 2000);

        setTimeout(() => {
            intro.style.top = '-100vh';
        }, 2300);
    });
}

document.addEventListener('DOMContentLoaded', animateIntro);
document.addEventListener('turbo:load', animateIntro);

if (window.location.search.includes('trigger_animation=true')) {
    animateIntro();
}
