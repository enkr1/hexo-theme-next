/* global hexo */

'use strict';

hexo.extend.filter.register('after_post_render', data => {
  const { config } = hexo;
  const theme = hexo.theme.config;
  if (!theme.exturl && !theme.lazyload) return;
  if (theme.lazyload) {
    data.content = data.content.replace(/(<img[^>]*) src=/img, '$1 data-src=');
  }
  // NOTE: I want to always show!
  // /*
  if (theme.exturl) {
    const url = require('url');
    const siteHost = url.parse(config.url).hostname || config.url;
    data.content = data.content.replace(/<a[^>]* href="([^"]+)"[^>]*>([^<]+)<\/a>/img, (match, href, html) => {

      // Exit if the href attribute doesn't exists.
      if (!href) return match;

      // Exit if the url has same host with `config.url`, which means it's an internal link.
      let link = url.parse(href);
      if (!link.protocol || link.hostname === siteHost) return match;

      return `<span class="exturl" data-url="${Buffer.from(href).toString('base64')}">${html}<i class="fa fa-external-link-alt"></i></span>`;
    });
  }
  // */
  //
  //   const url = require('url');
  //   const siteHost = url.parse(config.url).hostname || config.url;
  //   data.content = data.content.replace(/<a[^>]* href="([^"]+)"[^>]*>([^<]+)<\/a>/img, (match, href, html) => {
  //     console.log("1. href", href)
  //     // Exit if the href attribute doesn't exists.
  //     if (!href) return "a";
  //
  //     // Exit if the url has same host with `config.url`, which means it's an internal link.
  //     let link = url.parse(href);
  //     console.log("2. link", link)
  //     if (!link.protocol || link.hostname === siteHost) return "b";
  //     console.log("3. pass")
  //     return `<span class="exturl" data-url="${Buffer.from(href).toString('base64')}">~~~~ ${html}<i class="fa fa-external-link-alt"></i></span>`;
  //   });

}, 0);
