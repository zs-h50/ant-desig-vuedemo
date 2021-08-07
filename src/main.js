import Vue from "vue"
import App from './App.vue'
import router from './router'
import store from './store'
import Antd from 'ant-design-vue';
import axios from 'axios'
import 'ant-design-vue/dist/antd.css';
// import Vues from 'vue/dist/vue.esm.js'
 import infiniteScroll from "vue-infinite-scroll";
Vue.use(infiniteScroll);
Vue.prototype.$http = axios
Vue.use(Antd);

Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
