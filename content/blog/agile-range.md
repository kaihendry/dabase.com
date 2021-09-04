---
title: Agile maturity
date: 2021-09-04
description: Articulating the agile journey
---

<script src="https://unpkg.com/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>

<div id="app">
<input min=0 max=100 v-model="agility" type="range">
<p>
Trust: {{agility}}
</p>
</div>
<script>
var app = new Vue({
  el: '#app',
  data: {
    agility: 100,
  },
  computed: {
    initialCost() {
      return Number(this.disksize * this.cost)
    },
    subtotalSize() {
      return this.items.map((item) => {
        return Number(item.qty * item.ratio / 100 * this.disksize)
      });
    },
    subtotalCost() {
      return this.items.map((item) => {
        return Number(item.qty * item.ratio / 100 * this.disksize * this.cost)
      });
    },
    subTotals() {
      return this.items.reduce((subTotals, item) => {
        return Number(subTotals + item.qty * item.ratio / 100 * this.disksize * this.cost)
      }, 0);
    },
     total() {
      return Number(this.initialCost + this.subTotals)
    }
  }
});
</script>
