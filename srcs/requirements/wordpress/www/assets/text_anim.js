document.addEventListener("DOMContentLoaded", () => {
    const title = document.querySelector("h1");
    if (title) {
        title.addEventListener("mouseenter", () => {
            gsap.to(".distort feDisplacementMap", {
                duration: 1,
                attr: { scale: 100 },
                ease: "circ.out"
            });
            gsap.to(".distort feTurbulence", {
                duration: 1,
                attr: { baseFrequency: '2.08 .08' },
                ease: "circ.out"
            });
            gsap.to(title, {
                duration: 1,
                fontVariationSettings: "'wght' 650",
                ease: "back.out"
            });
        });

        title.addEventListener("mouseleave", () => {
            gsap.to(".distort feDisplacementMap", {
                duration: 1,
                attr: { scale: 0 },
                ease: "circ.out"
            });
            gsap.to(".distort feTurbulence", {
                duration: 1,
                attr: { baseFrequency: '2.01 .01' },
                ease: "circ.out"
            });
            gsap.to(title, {
                duration: 1,
                fontVariationSettings: "'wght' 700",
                ease: "back.out"
            });
        });
    }
});
