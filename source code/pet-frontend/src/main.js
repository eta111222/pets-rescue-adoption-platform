import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementUI from 'element-ui';
import locale from 'element-ui/lib/locale/lang/en';
import 'element-ui/lib/theme-chalk/index.css';
import './assets/gloable.css'
import request from "@/utils/request";
import mavonEditor from 'mavon-editor'
import '../initialize'
import 'mavon-editor/dist/css/index.css'
import './assets/font/iconfont.css'
// use
Vue.use(mavonEditor)

Vue.config.productionTip = false

Vue.use(ElementUI, { size: "mini", locale });

Vue.prototype.request=request

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
