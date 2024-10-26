/* global NexT, CONFIG, Velocity */
const WIDTH_THRESHOLD = 1200;
NexT.boot = {};

NexT.utils.handleHashChange = () => {
  const tHash = location.hash;
  if (tHash !== '' && !tHash.match(/%\S{2}/)) {
    const target = document.querySelector(`.tabs ul.nav-tabs li a[href="${tHash}"]`);
    target && target.click();
  }
};

// WIP: ....................................................................
NexT.boot.registerEvents = function () {
  NexT.utils.registerScrollPercent();
  NexT.utils.registerCanIUseTag();
  // Function to handle mobile menu toggle
  const siteNav = document.querySelector('.site-nav');
  let isMobile = window.innerWidth < WIDTH_THRESHOLD;

  console.debug(`window.innerWidth ${window.innerWidth}`)

  // Log on window resize
  window.addEventListener("resize", function () {
    console.debug("Updated width after resize:", window.innerWidth);
    isMobile = window.innerWidth < WIDTH_THRESHOLD;
  });

  const toggleMenu = () => {
    console.debug(`~> Toggle isMobile: ${isMobile}, size:`, window.innerWidth)
    if (!isMobile) return;

    console.debug("Toggle ON")
    const isMenuOpen = siteNav.classList.contains('site-nav-on');
    const animateAction = isMenuOpen ? 'slideUp' : 'slideDown';

    if (typeof Velocity === 'function') {
      Velocity(siteNav, animateAction, {
        duration: 200,
        complete: () => siteNav.classList.toggle('site-nav-on')
      });
    } else {
      siteNav.classList.toggle('site-nav-on');
    }
  }

  const bindMenuEvents = () => {
    if (!isMobile) return;
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

  // Bind events to sidebar items
  const sidebarNavItems = document.querySelectorAll('.sidebar-nav li');
  const sidebarPanels = document.querySelectorAll('.sidebar-panel');
  const activeTabClassName = 'sidebar-nav-active';
  const activePanelClassName = 'sidebar-panel-active';

  sidebarNavItems.forEach((item, index) => {
    item.addEventListener('click', () => {

      // Check if the clicked item is already active
      if (!item.classList.contains(activeTabClassName)) {
        // TODO: Not load when clicking on the same tab
        // if (!isMobile) return;

        // Remove active classes from all items
        sidebarNavItems.forEach(el => el.classList.remove(activeTabClassName));
        // Add active class to the clicked item
        item.classList.add(activeTabClassName);

        // Handle panel visibility
        sidebarPanels.forEach((panel, idx) => {
          if (panel.classList.contains(activePanelClassName)) {
            panel.classList.remove(activePanelClassName);
            panel.style.display = 'none'; // Hide non-active panels
          }
          if (idx === index) {
            panel.classList.add(activePanelClassName);
            panel.style.display = 'block'; // Show active panel
          }
        });
      }

    });
  });


  // Re-bind all menu related events
  document.addEventListener('pjax:success', () => bindMenuEvents());
  window.addEventListener('resize', NexT.utils.initSidebarDimension);
  window.addEventListener('hashchange', NexT.utils.handleHashChange);

  // Initial state setup: Ensure site-nav-on is not added on page load
  if (siteNav.classList.contains('site-nav-on')) {
    siteNav.classList.remove('site-nav-on');  // Ensure sidebar is not visible initially
  }
};


NexT.boot.refresh = function () {
  /**
   * Register JS handlers by condition option.
   * Need to add config option in Front-End at 'layout/_partials/head.swig' file.
   */
  CONFIG.fancybox && NexT.utils.wrapImageWithFancyBox();
  CONFIG.mediumzoom && window.mediumZoom(".post-body :not(a) > img, .post-body > img");
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
