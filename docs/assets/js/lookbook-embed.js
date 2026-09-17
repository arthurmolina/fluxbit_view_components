(function () {
  var BASEURL = window.SITE_BASEURL || '';

  function replaceLookbookEmbeds() {
    var embeds = document.querySelectorAll('lookbook-embed');
    embeds.forEach(function (el) {
      var preview = el.getAttribute('preview') || '';
      var scenario = el.getAttribute('scenario') || '';
      var label = preview.replace(/Fluxbit::(Components::|Form::|Typography::)?/, '').replace('Preview', '') + ' / ' + scenario.replace(/_/g, ' ');

      var wrapper = document.createElement('div');
      wrapper.className = 'lookbook-embed-placeholder';
      wrapper.style.cssText = [
        'border: 1px solid #334155',
        'border-radius: 8px',
        'padding: 12px 16px',
        'margin: 16px 0',
        'background: rgba(30,41,59,0.5)',
        'display: flex',
        'align-items: center',
        'gap: 12px',
      ].join(';');

      wrapper.innerHTML =
        '<span style="font-size:1.25rem">&#128250;</span>' +
        '<div>' +
          '<div style="font-size:0.8rem;color:#94a3b8;margin-bottom:4px">Interactive preview:</div>' +
          '<span style="color:#60a5fa;font-weight:500;font-size:0.9rem">' + label + '</span>' +
        '</div>';

      el.parentNode.replaceChild(wrapper, el);
    });
  }

  // Fix absolute image paths that reference /yes.png, /no.png, /fluxbit.png
  function fixImages() {
    var imageMap = {
      '/yes.png':     BASEURL + '/assets/images/yes.png',
      '/no.png':      BASEURL + '/assets/images/no.png',
      '/fluxbit.png': BASEURL + '/assets/images/fluxbit.png',
    };

    document.querySelectorAll('img').forEach(function (img) {
      var src = img.getAttribute('src');
      if (imageMap[src]) {
        img.src = imageMap[src];
      }
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function () {
      replaceLookbookEmbeds();
      fixImages();
    });
  } else {
    replaceLookbookEmbeds();
    fixImages();
  }
})();
