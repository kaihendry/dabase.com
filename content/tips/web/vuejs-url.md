---
title: Minimal VueJS route bind
date: 2021-09-04
description: Adventures with window.location.hash
---

<script src="https://unpkg.com/vue/dist/vue.js"></script>

<div id="app">
<input min=0 max=100 v-model="trust" type="range">
<p>
Trust: {{trust}}%
</p>
</div>

<script>
new Vue({
  el: '#app',
  data: { trust: 50 }, // Default value
  created: function() {
    var hash = parseInt(window.location.hash.substr(1))
	if (hash >= 0) {
		this.trust = hash
		}
  },
   watch: {
    trust: function (newValue) {
      window.location.hash = newValue
    }
  },
})
</script>
