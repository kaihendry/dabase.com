---
title: Minimal VueJS route bind
date: 2021-09-04
description: Two way binding wanted
---

<script src="https://unpkg.com/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>

<div id="app">
<p>Trying to create a version of <a href="https://jsfiddle.net/kaihendry/0u86herL/5/">Simple range</a>, but with a parameter.</p>
<input min=0 max=100 v-model="q" type="range">
<p>
Currently: {{q}}
</p>
<div>Parameter {{ $route.params.q }}</div>
</div>


<script>
var router = new VueRouter({
    mode: 'history',
    routes: []
});

new Vue({
    router,
  data() {
    return {
      q: 50
    }
  },
    el: '#app',
    mounted: function() {
        q = this.$route.query.q
        console.log("q", q)
    },
});
</script>
