{{ open_graph() }}

{{ canonical() }}



{# Exports some front-matter variables to Front-End #}
<script id="page-configurations">
  // https://hexo.io/docs/variables.html
  CONFIG.page = {
    sidebar: {{ page.sidebar | json }},
    isHome : {{ is_home() }},
    isPost : {{ is_post() }},
    lang   : '{{ page.lang }}'
  };
</script>



<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-4N4L18VB12"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-4N4L18VB12');
</script>



<!-- Firebase -->
<!-- enkr1.github.io -->
<script type="module">
  // Import the functions you need from the SDKs you need
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.11.1/firebase-app.js";
  import { getAnalytics } from "https://www.gstatic.com/firebasejs/10.11.1/firebase-analytics.js";
  // TODO: Add SDKs for Firebase products that you want to use
  // https://firebase.google.com/docs/web/setup#available-libraries

  // Your web app's Firebase configuration
  // For Firebase JS SDK v7.20.0 and later, measurementId is optional
  const _0x5ea0f9=_0x103b;function _0x103b(_0x53ae50,_0x59847d){const _0x2843ac=_0x1ad7();_0x103b=function(_0x55d786,_0x3cee64){_0x55d786=_0x55d786-(-0xcfb+0x1f9f+-0x1124);let _0x59a379=_0x2843ac[_0x55d786];return _0x59a379;};return _0x103b(_0x53ae50,_0x59847d);}function _0x1ad7(){const _0x1f01af=['G-TJPENBTD','AIzaSyBxex','17063YPgNxh','VzGzOqDUGF','1:71411607','216YlyPzv','hexo-blog-','7141160759','4c5895d438','16110beXadU','qAetlFUSo','548402cjqBQm','9ccea','zHVT_-oYxk','enkr1.com','10aKAiit','725816aYbUzX','38661mJjSzZ','fb244020c3','pot.com','5930586lHPClx','593:web:d0','52OsOUFf','9ccea.apps','1053695BAfudF'];_0x1ad7=function(){return _0x1f01af;};return _0x1ad7();}(function(_0x5f4332,_0x76084c){const _0x2e4582=_0x103b;const _0x2c9a86=_0x5f4332();while(!![]){try{const _0x40bc56=parseInt(_0x2e4582(0x184))/(-0x92c+-0x2f*-0x2+-0xcd*-0xb)+-parseInt(_0x2e4582(0x18d))/(-0xf68+-0x11*-0x1bb+-0xe01)+parseInt(_0x2e4582(0x18b))/(0x546+-0x4*-0x19b+-0xbaf)*(parseInt(_0x2e4582(0x198))/(-0x91*0x16+-0x215b*-0x1+-0x1*0x14e1))+-parseInt(_0x2e4582(0x181))/(0x181e+-0x295*0xd+0x978)+parseInt(_0x2e4582(0x187))/(-0x2*0x10ad+-0x14a9+0x3609)*(-parseInt(_0x2e4582(0x193))/(0x5*0x4e8+-0xc8d+0x5fa*-0x2))+parseInt(_0x2e4582(0x192))/(-0x1*0x621+0x1f*0x95+-0xbe2)+parseInt(_0x2e4582(0x196))/(-0x1494+-0x3*0x7ae+0x2ba7)*(parseInt(_0x2e4582(0x191))/(-0x1*0xec7+-0x5*-0x2cf+0xc6));if(_0x40bc56===_0x76084c){break;}else{_0x2c9a86['push'](_0x2c9a86['shift']());}}catch(_0x4baedd){_0x2c9a86['push'](_0x2c9a86['shift']());}}}(_0x1ad7,-0x1*0x1a731+-0x443d4+-0x1*-0x83fd7));const firebaseConfig={'apiKey':_0x5ea0f9(0x183)+_0x5ea0f9(0x185)+_0x5ea0f9(0x18f)+_0x5ea0f9(0x18c),'authDomain':_0x5ea0f9(0x190),'projectId':_0x5ea0f9(0x188)+_0x5ea0f9(0x18e),'storageBucket':_0x5ea0f9(0x188)+_0x5ea0f9(0x180)+_0x5ea0f9(0x195),'messagingSenderId':_0x5ea0f9(0x189)+'3','appId':_0x5ea0f9(0x186)+_0x5ea0f9(0x197)+_0x5ea0f9(0x194)+_0x5ea0f9(0x18a),'measurementId':_0x5ea0f9(0x182)+'NS'};

  // Initialize Firebase
  const app = initializeApp(firebaseConfig);
  const analytics = getAnalytics(app);
</script>
