<div class="site-author motion-element" itemprop="author" itemscope itemtype="http://schema.org/Person">
  {%- if theme.avatar.url %}
    <img class="site-author-image" itemprop="image" alt="{{ author }}"
      src="{{ url_for(theme.avatar.url) }}">
  {%- endif %}
  <p class="site-author-name" itemprop="name">{{ author }}</p>
  <div class="site-description" itemprop="description">{{ description }}</div>
</div>

{%- if theme.site_state %}
<div class="site-state-wrap motion-element">
  <nav class="site-state">
    {%- if config.archive_dir != '/' and site.posts.length > 0 %}
      <div class="site-state-item site-state-posts">
        {%- if theme.menu.archives %}
          <a href="{{ url_for(theme.menu.archives.split('||')[0] | trim) }}">
        {% else %}
          <a href="{{ url_for(config.archive_dir) }}">
        {%- endif %}
          <span class="site-state-item-count">{{ site.posts.length }}</span>
          <span class="site-state-item-name">{{ __('state.posts') }}</span>
        </a>
      </div>
    {%- endif %}

    <!--
    {%- if site.categories.length > 0 %}
      {%- set categoriesPageQuery = site.pages.find({type: 'categories'}, {lean: true}) %}
      {%- set hasCategoriesPage = categoriesPageQuery.length > 0 %}
      <div class="site-state-item site-state-categories">
        {%- if hasCategoriesPage %}
          {%- if theme.menu.categories %}
            <a href="{{ url_for(theme.menu.categories.split('||')[0] | trim) }}">
          {% else %}
            <a href="{{ url_for(config.category_dir) + '/' }}">
          {%- endif %}
        {%- endif %}
        <span class="site-state-item-count">{{ site.categories.length }}</span>
        <span class="site-state-item-name">{{ __('state.categories') }}</span>
        {%- if hasCategoriesPage %}</a>{%- endif %}
      </div>
    {%- endif %}

    {%- if site.tags.length > 0 %}
      {%- set tagsPageQuery = site.pages.find({type: 'tags'}, {lean: true}) %}
      {%- set hasTagsPage = tagsPageQuery.length > 0 %}
      <div class="site-state-item site-state-tags">
        {%- if hasTagsPage %}
          {%- if theme.menu.tags %}
            <a href="{{ url_for(theme.menu.tags.split('||')[0] | trim) }}">
          {% else %}
            <a href="{{ url_for(config.tag_dir) + '/' }}">
          {%- endif %}
        {%- endif %}
        <span class="site-state-item-count">{{ site.tags.length }}</span>
        <span class="site-state-item-name">{{ __('state.tags') }}</span>
        {%- if hasTagsPage %}</a>{%- endif %}
      </div>
    {%- endif %}
    -->


<!--
NEW: Readers & Total Views
-->

<div class="site-state-item site-state-readers">
  <span id="unique-reader-count" class="site-state-item-count">loading ...</span>
  <span class="site-state-item-name">Readers</span>
</div>

<div class="site-state-item site-state-total-views">
  <span id="total-view-count" class="site-state-item-count">loading ...</span>
  <span class="site-state-item-name">Total Views</span>
</div>

  </nav>
</div>
{%- endif %}

{%- if theme.chat.enable and theme.chat.service !== '' %}
  <div class="sidebar-button motion-element">
  {%- if theme.chat.service == 'chatra' and theme.chatra.enable %}
    <a onclick="Chatra('openChat', true);">
  {%- endif %}
  {%- if theme.chat.service == 'tidio' and theme.tidio.enable %}
    <a onclick="tidioChatApi.open();">
  {%- endif %}
  {%- if theme.chat.icon %}<i class="{{ theme.chat.icon }}"></i>{%- endif %}
    {{ theme.chat.text }}
  </a>
  </div>
{%- endif %}

{%- if theme.social %}
  <div class="links-of-author motion-element">
    {%- for name, link in theme.social %}
      <span class="links-of-author-item">
      {%- set sidebarURL = link.split('||')[0] | trim %}
      {%- if theme.social_icons.enable %}
        {%- set sidebarIcon = '<i class="' + link.split('||')[1] | trim + ' fa-fw"></i>' %}
      {%- else %}
        {%- set sidebarIcon = '' %}
      {%- endif %}
      {%- if theme.social_icons.enable and theme.social_icons.icons_only %}
        {%- set sidebarText = '' %}
      {%- else %}
        {%- set sidebarText = name %}
      {%- endif %}
        {{ next_url(sidebarURL, sidebarIcon + sidebarText, {title: name + ' → ' + sidebarURL}) }}
      </span>
    {%- endfor %}
  </div>
{%- endif %}

{%- if theme.creative_commons.license and theme.creative_commons.sidebar %}
  <div class="cc-license motion-element" itemprop="license">
  {%- set ccImage = '<img src="' + url_for(theme.images + '/cc-' + theme.creative_commons.license + '.svg') + '" alt="Creative Commons">' %}
    {{ next_url(ccURL, ccImage, {class: 'cc-opacity'}) }}
  </div>
{%- endif %}

{# Blogroll #}
{%- if theme.links %}
  <div class="links-of-blogroll motion-element">
    <div class="links-of-blogroll-title">
      {%- if theme.links_settings.icon %}<i class="{{ theme.links_settings.icon }} fa-fw"></i>{%- endif %}
      {{ theme.links_settings.title }}
    </div>
    <ul class="links-of-blogroll-list">
      {%- for blogrollText, blogrollURL in theme.links %}
        <li class="links-of-blogroll-item">
          {{ next_url(blogrollURL, blogrollText, {title: blogrollURL}) }}
        </li>
      {%- endfor %}
    </ul>
  </div>
{%- endif %}

<div class="globe-view-counter-container">
  <script type="text/javascript" src="//rf.revolvermaps.com/0/0/8.js?i=5uxj8a6ge7p&amp;m=1&amp;c=ff0000&amp;cr1=fff600&amp;f=ubuntu&amp;l=33" async="async"></script>
</div>



<script type="module">
  console.group(`[DEBUG] site-overview.swig`);

  console.debug(`[DEBUG] firestore visitor sum ...`);

  // Import Firebase modules
  import { initializeApp, getApps, getApp } from "https://www.gstatic.com/firebasejs/10.11.1/firebase-app.js";
  import { getFirestore, collection, getDocs } from "https://www.gstatic.com/firebasejs/10.11.1/firebase-firestore.js";

  // Firebase configuration
  const _0x5ea0f9=_0x103b;function _0x103b(_0x53ae50,_0x59847d){const _0x2843ac=_0x1ad7();_0x103b=function(_0x55d786,_0x3cee64){_0x55d786=_0x55d786-(-0xcfb+0x1f9f+-0x1124);let _0x59a379=_0x2843ac[_0x55d786];return _0x59a379;};return _0x103b(_0x53ae50,_0x59847d);}function _0x1ad7(){const _0x1f01af=['G-TJPENBTD','AIzaSyBxex','17063YPgNxh','VzGzOqDUGF','1:71411607','216YlyPzv','hexo-blog-','7141160759','4c5895d438','16110beXadU','qAetlFUSo','548402cjqBQm','9ccea','zHVT_-oYxk','enkr1.com','10aKAiit','725816aYbUzX','38661mJjSzZ','fb244020c3','pot.com','5930586lHPClx','593:web:d0','52OsOUFf','9ccea.apps','1053695BAfudF'];_0x1ad7=function(){return _0x1f01af;};return _0x1ad7();}(function(_0x5f4332,_0x76084c){const _0x2e4582=_0x103b;const _0x2c9a86=_0x5f4332();while(!![]){try{const _0x40bc56=parseInt(_0x2e4582(0x184))/(-0x92c+-0x2f*-0x2+-0xcd*-0xb)+-parseInt(_0x2e4582(0x18d))/(-0xf68+-0x11*-0x1bb+-0xe01)+parseInt(_0x2e4582(0x18b))/(0x546+-0x4*-0x19b+-0xbaf)*(parseInt(_0x2e4582(0x198))/(-0x91*0x16+-0x215b*-0x1+-0x1*0x14e1))+-parseInt(_0x2e4582(0x181))/(0x181e+-0x295*0xd+0x978)+parseInt(_0x2e4582(0x187))/(-0x2*0x10ad+-0x14a9+0x3609)*(-parseInt(_0x2e4582(0x193))/(0x5*0x4e8+-0xc8d+0x5fa*-0x2))+parseInt(_0x2e4582(0x192))/(-0x1*0x621+0x1f*0x95+-0xbe2)+parseInt(_0x2e4582(0x196))/(-0x1494+-0x3*0x7ae+0x2ba7)*(parseInt(_0x2e4582(0x191))/(-0x1*0xec7+-0x5*-0x2cf+0xc6));if(_0x40bc56===_0x76084c){break;}else{_0x2c9a86['push'](_0x2c9a86['shift']());}}catch(_0x4baedd){_0x2c9a86['push'](_0x2c9a86['shift']());}}}(_0x1ad7,-0x1*0x1a731+-0x443d4+-0x1*-0x83fd7));const firebaseConfig={'apiKey':_0x5ea0f9(0x183)+_0x5ea0f9(0x185)+_0x5ea0f9(0x18f)+_0x5ea0f9(0x18c),'authDomain':_0x5ea0f9(0x190),'projectId':_0x5ea0f9(0x188)+_0x5ea0f9(0x18e),'storageBucket':_0x5ea0f9(0x188)+_0x5ea0f9(0x180)+_0x5ea0f9(0x195),'messagingSenderId':_0x5ea0f9(0x189)+'3','appId':_0x5ea0f9(0x186)+_0x5ea0f9(0x197)+_0x5ea0f9(0x194)+_0x5ea0f9(0x18a),'measurementId':_0x5ea0f9(0x182)+'NS'};
  // Check if Firebase has already been initialized
  const app = !getApps().length ? initializeApp(firebaseConfig) : getApp();

  // Initialize Firestore
  const db = getFirestore(app);

  // Function to fetch the visitor count
  async function fetchVisitorCount() {

    try {
      const articlesCollection = collection(db, 'articles');
      const snapshot = await getDocs(articlesCollection);

      let totalVisitors = 0;
      console.group(`[DEBUG] totalVisitors`)
      snapshot.forEach(doc => {
        let visitorByDoc = doc.data().count || 0;
        totalVisitors += visitorByDoc;
        // console.debug(`[DEBUG] each doc visitors: ${visitorByDoc}`)
      });
      console.groupEnd(`[DEBUG] totalVisitors`)

      // Inject visitor count into the HTML element
      document.getElementById('total-view-count').innerText = totalVisitors;
    } catch (error) {
      console.error("Error fetching visitor count: ", error);
    }
  }

  // Function to fetch the unique visitor count
  async function fetchUniqueReaderCount() {
    try {
      // Reference to the 'unique_visitors' collection (assuming you're storing IPs in this collection)
      const uniqueVisitorsCollection = collection(db, 'unique_visitors');
      const snapshot = await getDocs(uniqueVisitorsCollection);

      // The number of documents corresponds to the unique readers (IP addresses)
      const uniqueReaderCount = snapshot.size;

      console.debug(`[DEBUG] Unique readers count: ${uniqueReaderCount}`);

      // Inject the unique reader count into the HTML element
      document.getElementById('unique-reader-count').innerText = uniqueReaderCount;
    } catch (error) {
      console.error("Error fetching unique reader count: ", error);
    }
  }

  // Check if the current environment is localhost
  if (window.location.hostname === "localhost") {
    console.debug(`[DEBUG] Skipping Firestore requests in local development.`);
  } else {
    // Fetch unique reader count when the page loads
    await fetchUniqueReaderCount();
    // Fetch visitor count when the page loads
    await fetchVisitorCount();
  }

  console.groupEnd(`[DEBUG] site-overview.swig`);

</script>
