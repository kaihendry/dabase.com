---
title: Minimal VueJS route bind
date: 2021-09-04
description: Two way binding wanted
---

Since I'm stuck, I've asked [Stack Overflow](https://stackoverflow.com/questions/69056242/model-url-parameter-in-vuejs) 😬

<script src="https://unpkg.com/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>

<div id="app"></div>

<script>
// https://github.com/vuejs/vue-router/blob/dev/examples/route-props/Hello.vue
var Hello = Vue.component('Hello', {
  template: `
  <div>
  <h2 class="hello">Hello {{agility}} {{ $attrs }}</h2>
  <input min=0 max=100 v-model="agility" type="range">
  </div>
  `,
  props: {
    agility: {
      type: Number,
      default: 25
    }
  }
});

const router = new VueRouter({
  // https://stackoverflow.com/a/62859896/4534
  routes: [
    { path: '*', component: Hello, props: true },
    { path: '/:agility', component: Hello, props: true },
  ]
})

new Vue({
  router,
  template: `
    <div id="app">
      <router-view></router-view>
    </div>
  `
}).$mount('#app')
</script>
