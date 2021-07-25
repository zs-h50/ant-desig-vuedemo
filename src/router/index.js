import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../views/Login.vue'
import Indexs from '../views/student/indexs.vue'
Vue.use(VueRouter)

//解决重复重定向问题
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}

const routes = [
  {
    path: '/',
    name: '登录页',
    component: Login
  },
  {
    path: '/indexs',
    name: '学生首页',
    component: Indexs
  },
  
]

const router = new VueRouter({
  routes
})

export default router
