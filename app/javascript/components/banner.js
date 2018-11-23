import Typed from 'typed.js';

function loadDynamicBannerText() {
  new Typed('#banner-typed-text', {
    strings: ["Save Food", "Earn Money"],
    typeSpeed: 100,
    loop: true
  });
}

export { loadDynamicBannerText };
