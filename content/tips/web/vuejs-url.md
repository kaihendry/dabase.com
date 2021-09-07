---
title: Minimal VueJS route bind
date: 2021-09-04
description: Two way binding wanted
---

<script src="https://unpkg.com/vue/dist/vue.js"></script>

<div id="app">
<input min=0 max=100 v-model="agility" type="range">
<p>
Trust: {{agility}}%
</p>
</div>

<script>
new Vue({
  el: '#app',
  data: { agility: 50 }, // Default value
  created: function() {
    var hash = window.location.hash.substr(1)
	if (hash) {
		this.agility = hash
		}
  },
   watch: {
    agility: function (newValue) {
      window.location.hash = newValue
    }
  },
})
</script>
