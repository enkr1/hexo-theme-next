{%- if theme.firestore.enable %}
  <script src="https://www.gstatic.com/firebasejs/6.3.3/firebase-app.js"></script>
  <script src="https://www.gstatic.com/firebasejs/6.3.3/firebase-firestore.js"></script>

  <script type="module">
    import { initializeApp, getApps, getApp } from "https://www.gstatic.com/firebasejs/10.11.1/firebase-app.js";
    import { getFirestore, doc, collection, getDoc, setDoc, FieldValue } from "https://www.gstatic.com/firebasejs/10.11.1/firebase-firestore.js";

    console.group(`[DEBUG] firestore.swig`);

    // Firebase configuration
    const _0x5ea0f9=_0x103b;function _0x103b(_0x53ae50,_0x59847d){const _0x2843ac=_0x1ad7();_0x103b=function(_0x55d786,_0x3cee64){_0x55d786=_0x55d786-(-0xcfb+0x1f9f+-0x1124);let _0x59a379=_0x2843ac[_0x55d786];return _0x59a379;};return _0x103b(_0x53ae50,_0x59847d);}function _0x1ad7(){const _0x1f01af=['G-TJPENBTD','AIzaSyBxex','17063YPgNxh','VzGzOqDUGF','1:71411607','216YlyPzv','hexo-blog-','7141160759','4c5895d438','16110beXadU','qAetlFUSo','548402cjqBQm','9ccea','zHVT_-oYxk','enkr1.com','10aKAiit','725816aYbUzX','38661mJjSzZ','fb244020c3','pot.com','5930586lHPClx','593:web:d0','52OsOUFf','9ccea.apps','1053695BAfudF'];_0x1ad7=function(){return _0x1f01af;};return _0x1ad7();}(function(_0x5f4332,_0x76084c){const _0x2e4582=_0x103b;const _0x2c9a86=_0x5f4332();while(!![]){try{const _0x40bc56=parseInt(_0x2e4582(0x184))/(-0x92c+-0x2f*-0x2+-0xcd*-0xb)+-parseInt(_0x2e4582(0x18d))/(-0xf68+-0x11*-0x1bb+-0xe01)+parseInt(_0x2e4582(0x18b))/(0x546+-0x4*-0x19b+-0xbaf)*(parseInt(_0x2e4582(0x198))/(-0x91*0x16+-0x215b*-0x1+-0x1*0x14e1))+-parseInt(_0x2e4582(0x181))/(0x181e+-0x295*0xd+0x978)+parseInt(_0x2e4582(0x187))/(-0x2*0x10ad+-0x14a9+0x3609)*(-parseInt(_0x2e4582(0x193))/(0x5*0x4e8+-0xc8d+0x5fa*-0x2))+parseInt(_0x2e4582(0x192))/(-0x1*0x621+0x1f*0x95+-0xbe2)+parseInt(_0x2e4582(0x196))/(-0x1494+-0x3*0x7ae+0x2ba7)*(parseInt(_0x2e4582(0x191))/(-0x1*0xec7+-0x5*-0x2cf+0xc6));if(_0x40bc56===_0x76084c){break;}else{_0x2c9a86['push'](_0x2c9a86['shift']());}}catch(_0x4baedd){_0x2c9a86['push'](_0x2c9a86['shift']());}}}(_0x1ad7,-0x1*0x1a731+-0x443d4+-0x1*-0x83fd7));const firebaseConfig={'apiKey':_0x5ea0f9(0x183)+_0x5ea0f9(0x185)+_0x5ea0f9(0x18f)+_0x5ea0f9(0x18c),'authDomain':_0x5ea0f9(0x190),'projectId':_0x5ea0f9(0x188)+_0x5ea0f9(0x18e),'storageBucket':_0x5ea0f9(0x188)+_0x5ea0f9(0x180)+_0x5ea0f9(0x195),'messagingSenderId':_0x5ea0f9(0x189)+'3','appId':_0x5ea0f9(0x186)+_0x5ea0f9(0x197)+_0x5ea0f9(0x194)+_0x5ea0f9(0x18a),'measurementId':_0x5ea0f9(0x182)+'NS'};
    const app = !getApps().length ? initializeApp(firebaseConfig) : getApp();
    const db = getFirestore(app);

    let isRequestInProgress = false;

    async function getCount(docRef, increaseCount, title) {
      try {
        isRequestInProgress = true;
        const d = await getDoc(docRef);

        let count = 0;
        if (!d.exists()) {
          if (increaseCount) {
            await setDoc(docRef, { count: 1 });
            count = 1;
            localStorage.setItem(title, true); // Mark as visited
          }
        } else {
          count = d.data().count;
          if (increaseCount) {
            await setDoc(docRef, { count: count + 1 });
            count++;
            localStorage.setItem(title, true); // Mark as visited
          }
        }

        isRequestInProgress = false;
        return count;
      } catch (err) {
        console.error('Error getting document:', err);
        isRequestInProgress = false;
      }
    }

    async function trackUniqueVisitor() {
      const visitorData = await getVisitorIP();
      if (!visitorData) return;

      const hashedIp = await hashIP(visitorData.ip);
      const ipCollection = collection(db, 'unique_visitors');
      const ipDoc = doc(ipCollection, hashedIp);
      const docSnapshot = await getDoc(ipDoc);

      if (!docSnapshot.exists()) {
        await setDoc(ipDoc, {
          ip: visitorData.ip,
          timestamp: new Date(),
          geolocation: `${visitorData.city}, ${visitorData.country}`,
          userAgent: navigator.userAgent
        });

        const totalIpDoc = doc(db, 'visitor_stats', 'total_ip_visitors');
        await setDoc(totalIpDoc, {
          count: FieldValue.increment(1)
        }, { merge: true });

        console.debug(`[DEBUG] New visitor: IP ${visitorData.ip} recorded.`);
      } else {
        console.debug(`[DEBUG] Returning visitor: IP ${visitorData.ip} already recorded.`);
      }
    }

    const appendCountTo = (el) => {
      return count => {
        el.innerText = count;
      }
    }

    if (window.location.hostname === "localhost") {
      console.debug(`[DEBUG] Skipping Firestore requests in local development.`);

    } else {
      if (CONFIG.page.isPost) {
        console.debug(`[DEBUG] isPost.`);
        const title = document.querySelector('.post-title').innerText.trim();
        const docRef = doc(db, '{{ theme.firestore.collection }}', title);
        let increaseCount = CONFIG.hostname === location.hostname;

        // Check if the user has already visited the post (localStorage)
        if (localStorage.getItem(title)) {
          console.debug(`[DEBUG] visited -> ${title}`);
          increaseCount = false;
        }

        // Fetch count and increase only if needed, then update localStorage
        getCount(docRef, increaseCount, title).then(
          appendCountTo(document.querySelector('.firestore-visitors-count'))
        );
      } else if (CONFIG.page.isHome) {
        // On the homepage, get counts for all articles
        const promises = [...document.querySelectorAll('.post-title')].map(element => {
          const title = element.innerText.trim();
          const docRef = doc(db, '{{ theme.firestore.collection }}', title);
          return getCount(docRef, false, title);  // No need to increase count on home page
        });

        // Update visitor counts on homepage
        Promise.all(promises).then(counts => {
          const metas = document.querySelectorAll('.firestore-visitors-count');
          counts.forEach((val, idx) => appendCountTo(metas[idx])(val));
        });
      }

    }
    console.groupEnd(`[DEBUG] firestore.swig`);
  </script>
{%- endif %}
