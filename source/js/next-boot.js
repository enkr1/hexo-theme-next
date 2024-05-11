/* global NexT, CONFIG, Velocity */

NexT.boot = {};


NexT.boot.registerEvents = function () {
  NexT.utils.registerScrollPercent();
  NexT.utils.registerCanIUseTag();

  // Function to toggle mobile menu
  const toggleMenu = () => {
    console.log("toggling!")
    const siteNav = document.querySelector('.site-nav');
    const isMenuOpen = siteNav.classList.contains('site-nav-on');
    const animateAction = isMenuOpen ? 'slideUp' : 'slideDown';

    if (typeof Velocity === 'function') {
      Velocity(siteNav, animateAction, {
        duration: 200,
        complete: function () {
          siteNav.classList.toggle('site-nav-on');
        }
      });
    } else {
      siteNav.classList.toggle('site-nav-on');
    }
  }

  // Re-bind all menu related events
  document.addEventListener('pjax:success', () => bindMenuEvents());

  const bindMenuEvents = () => {
    document.querySelectorAll('.sidebar-nav li').forEach((element) => {
      element.removeEventListener('click', toggleMenu);  // Remove previous event listeners to avoid duplicates
      element.addEventListener('click', toggleMenu);
    });
  }

  // Mobile top menu bar toggle
  document.querySelector('.site-nav-toggle .toggle').addEventListener('click', event => {
    event.currentTarget.classList.toggle('toggle-close');
    toggleMenu();
  });

  // Use event delegation for dynamically loaded sidebar navigation items
  document.addEventListener('click', function (event) {
    if (event.target.closest('.sidebar-nav li')) {
      const item = event.target.closest('.sidebar-nav li');
      const activeTabClassName = 'sidebar-nav-active';
      const activePanelClassName = 'sidebar-panel-active';
      if (item.classList.contains(activeTabClassName)) return;

      // Close the menu if it's open when a sidebar item is clicked
      toggleMenu(); // This will close the menu

      const allItems = document.querySelectorAll('.sidebar-nav li');
      const index = Array.from(allItems).indexOf(item);
      const targets = document.querySelectorAll('.sidebar-panel');
      const target = targets[index];
      const currentTarget = document.querySelector(`.${activePanelClassName}`);

      if (currentTarget) {
        window.anime({
          targets: currentTarget,
          duration: 200,
          easing: 'linear',
          opacity: 0,
          complete: () => {
            currentTarget.classList.remove(activePanelClassName);
            target.style.opacity = 0;
            target.classList.add(activePanelClassName);
            window.anime({
              targets: target,
              duration: 200,
              easing: 'linear',
              opacity: 1
            });
          }
        });
      }

      [...allItems].forEach(el => {
        el.classList.remove(activeTabClassName);
      });
      item.classList.add(activeTabClassName);
    }
  });

  window.addEventListener('resize', NexT.utils.initSidebarDimension);

  window.addEventListener('hashchange', () => {
    const tHash = location.hash;
    if (tHash !== '' && !tHash.match(/%\S{2}/)) {
      const target = document.querySelector(`.tabs ul.nav-tabs li a[href="${tHash}"]`);
      target && target.click();
    }
  });
};

NexT.boot.refresh = function () {
  /**
   * Register JS handlers by condition option.
   * Need to add config option in Front-End at 'layout/_partials/head.swig' file.
   */
  CONFIG.fancybox && NexT.utils.wrapImageWithFancyBox();
  CONFIG.mediumzoom &&
    window.mediumZoom(".post-body :not(a) > img, .post-body > img");
  CONFIG.lazyload && window.lozad(".post-body img").observe();
  CONFIG.pangu && window.pangu.spacingPage();

  CONFIG.exturl && NexT.utils.registerExtURL();
  CONFIG.copycode.enable && NexT.utils.registerCopyCode();
  NexT.utils.registerTabsTag();
  NexT.utils.registerActiveMenuItem();
  NexT.utils.registerLangSelect();
  NexT.utils.registerSidebarTOC();
  NexT.utils.wrapTableWithBox();
  NexT.utils.registerVideoIframe();
};

NexT.boot.motion = function () {
  // Define Motion Sequence & Bootstrap Motion.
  if (CONFIG.motion.enable) {
    NexT.motion.integrator
      .add(NexT.motion.middleWares.logo)
      .add(NexT.motion.middleWares.menu)
      .add(NexT.motion.middleWares.postList)
      .add(NexT.motion.middleWares.sidebar)
      .bootstrap();
  }
  NexT.utils.updateSidebarPosition();
};

document.addEventListener("DOMContentLoaded", () => {
  NexT.boot.registerEvents();
  NexT.boot.refresh();
  NexT.boot.motion();
});
