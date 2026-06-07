/**
 * - desktop--scale-fit (kurs): макет 1920×1080, вписать в окно
 * - desktop--scale-adaptive (account, курсы): 100vw×100vh как в оригинале,
 *   при узком окне — только уменьшение scale (без смены системы координат)
 * - desktop--home: масштаб по ширине, прокрутка
 */
(function () {
  'use strict';

  var DESIGN_WIDTH = 1920;
  var DESIGN_HEIGHT = 1080;
  var HOME_HEIGHT = 2800;

  function ensureShell(desktop) {
    var parent = desktop.parentElement;
    if (parent && parent.classList.contains('page-shell')) {
      return parent;
    }
    var shell = document.createElement('div');
    shell.className = 'page-shell';
    desktop.parentNode.insertBefore(shell, desktop);
    shell.appendChild(desktop);
    return shell;
  }

  function unwrapShell(desktop) {
    var parent = desktop.parentElement;
    if (!parent || !parent.classList.contains('page-shell')) {
      return;
    }
    parent.parentNode.insertBefore(desktop, parent);
    parent.parentNode.removeChild(parent);
  }

  function clearInline(desktop) {
    desktop.style.width = '';
    desktop.style.height = '';
    desktop.style.transform = '';
    desktop.style.transformOrigin = '';
  }

  /** kurs: фиксированный холст 1920×1080 */
  function fitScaleFit(desktop) {
    var shell = ensureShell(desktop);
    var vw = document.documentElement.clientWidth;
    var vh = document.documentElement.clientHeight;
    var scale = Math.min(vw / DESIGN_WIDTH, vh / DESIGN_HEIGHT);

    desktop.style.width = DESIGN_WIDTH + 'px';
    desktop.style.height = DESIGN_HEIGHT + 'px';
    desktop.style.transform = 'scale(' + scale + ')';
    desktop.style.transformOrigin = 'top left';

    shell.style.width = DESIGN_WIDTH * scale + 'px';
    shell.style.height = DESIGN_HEIGHT * scale + 'px';
    shell.classList.remove('page-shell--home');

    return true;
  }

  /** account, курсы: оригинальный 100vw×100vh + scale при необходимости */
  function fitScaleAdaptive(desktop) {
    clearInline(desktop);

    var isCoursePage = (typeof location !== 'undefined') && (
      location.pathname.indexOf('html.html') !== -1 ||
      location.pathname.indexOf('css_page.html') !== -1 ||
      location.pathname.indexOf('js_page.html') !== -1 ||
      location.pathname.indexOf('ts_page.html') !== -1 ||
      location.pathname.indexOf('vue_page.html') !== -1 ||
      location.pathname.indexOf('angular.html') !== -1 ||
      location.pathname.indexOf('react_page.html') !== -1
    );

    if (isCoursePage) {
      unwrapShell(desktop);
      return false;
    }

    var vw = document.documentElement.clientWidth;
    var vh = document.documentElement.clientHeight;
    var scale = Math.min(vw / DESIGN_WIDTH, vh / DESIGN_HEIGHT, 1);

    if (scale >= 0.999) {
      unwrapShell(desktop);
      return false;
    }

    var shell = ensureShell(desktop);
    shell.classList.remove('page-shell--home');

    var isAccountPage = (typeof location !== 'undefined') && (
      location.pathname.indexOf('account.html') !== -1 ||
      location.href.indexOf('account.html') !== -1
    );

    if (!isAccountPage) {
      shell.style.marginLeft = '0px';
      shell.style.marginRight = 'auto';
      shell.style.alignSelf = 'flex-start';
    } else {
      shell.style.marginLeft = '';
      shell.style.marginRight = '';
      shell.style.alignSelf = '';
    }

    desktop.style.transform = 'scale(' + scale + ')';
    desktop.style.transformOrigin = 'top left';

    var w = desktop.offsetWidth;
    var h = desktop.offsetHeight;
    shell.style.width = Math.ceil(w * scale) + 'px';
    shell.style.height = Math.ceil(h * scale) + 'px';

    return true;
  }

  /** home: длинная страница, масштаб по ширине */
  function fitHome(desktop) {
    var shell = ensureShell(desktop);
    shell.classList.add('page-shell--home');

    var vw = document.documentElement.clientWidth;
    var scale = Math.min(vw / DESIGN_WIDTH, 1);

    desktop.style.width = DESIGN_WIDTH + 'px';
    desktop.style.height = HOME_HEIGHT + 'px';
    desktop.style.transform = 'scale(' + scale + ')';
    desktop.style.transformOrigin = 'top left';

    shell.style.width = DESIGN_WIDTH * scale + 'px';
    shell.style.height = HOME_HEIGHT * scale + 'px';

    return true;
  }

  function fitAll() {
    document.body.classList.remove('page-canvas', 'page-canvas-scroll');

    var mode = null;

    document.querySelectorAll('.desktop').forEach(function (desktop) {
      var scaled = false;

      if (desktop.classList.contains('desktop--scale-fit')) {
        scaled = fitScaleFit(desktop);
        mode = 'canvas';
      } else if (desktop.classList.contains('desktop--scale-adaptive')) {
        scaled = fitScaleAdaptive(desktop);
        mode = scaled ? 'canvas' : mode;
      } else if (desktop.classList.contains('desktop--home')) {
        scaled = fitHome(desktop);
        mode = 'scroll';
      }

      if (!scaled && !desktop.classList.contains('desktop--home')) {
        unwrapShell(desktop);
      }
    });

    if (mode === 'scroll') {
      document.body.classList.add('page-canvas-scroll');
    } else if (mode === 'canvas') {
      document.body.classList.add('page-canvas');
    }
  }

  var resizeTimer;
  function onResize() {
    clearTimeout(resizeTimer);
    resizeTimer = setTimeout(fitAll, 50);
  }

  function init() {
    fitAll();
    window.addEventListener('load', fitAll);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  window.addEventListener('resize', onResize);
  window.addEventListener('orientationchange', onResize);
})();
