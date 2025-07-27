hexo.extend.helper.register('get_journal_posts', function() {
  return this.site.posts.filter(post => post.tags && post.tags.find(tag => tag.name === 'journal'));
});
