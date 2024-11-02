import Vue from 'vue'
import VueRouter from 'vue-router'
import store from "@/store";

Vue.use(VueRouter)

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/Login.vue')
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('../views/Register.vue')
  },
  {
    path: '/404',
    name: '404',
    component: () => import('../views/404.vue')
  },
  {
    path: '/front',
    name: 'Front',
    component: () => import('../views/front/Front'),
    children: [
      { path: 'person', name: 'personal info', component: () => import('../views/front/Person.vue')},
      { path: 'password', name: 'change password', component: () => import('../views/front/Password.vue')},
      {
        path: 'home',
        name: 'FrontHome',
        component: () => import('../views/front/Home.vue')
      },
      {
        path: 'homeDetail',
        name: 'HomeDetail',
        component: () => import('../views/front/HomeDetail')
      },
      {
        path: 'adopt',
        name: 'Adopt',
        component: () => import('../views/front/Adopt.vue')
      },
      {
        path: 'myAdopt',
        name: 'MyAdopt',
        component: () => import('../views/front/MyAdopt.vue')
      },
      {
        path: 'salvation',
        name: 'Salvation',
        component: () => import('../views/front/Salvation.vue')
      },
      {
        path: 'lost',
        name: 'Lost',
        component: () => import('../views/front/Lost.vue')
      },
      {
        path: 'article',
        name: 'Article',
        component: () => import('../views/front/Article.vue')
      },
      {
        path: 'articleKp',
        name: 'ArticleKp',
        component: () => import('../views/ArticleKp.vue')
      },
    ]
  }
]

const router = new VueRouter({
  mode: 'history',
  routes
})

export const resetRouter = () => {
  router.matcher = new VueRouter({
    mode: 'history',
    routes
  })
}

export const setRoutes = () => {
  const storeMenus = localStorage.getItem("menus");
  if (storeMenus) {
    const manageRoute = { path: '/', name: 'Manage', component: () => import('../views/Manage.vue'), redirect: "/login", children: [
        { path: 'person', name: 'personal info', component: () => import('../views/Person.vue')},
        { path: 'password', name: 'change password', component: () => import('../views/Password.vue')},
      ] }
    const menus = JSON.parse(storeMenus)
    menus.forEach(item => {
      if (item.path) {  
        let itemMenu = { path: item.path.replace("/", ""), name: item.name, component: () => import('../views/' + item.pagePath + '.vue')}
        manageRoute.children.push(itemMenu)
      } else if(item.children.length) {
        item.children.forEach(item => {
          if (item.path) {
            let itemMenu = { path: item.path.replace("/", ""), name: item.name, component: () => import('../views/' + item.pagePath + '.vue')}
            manageRoute.children.push(itemMenu)
          }
        })
      }
    })

    const currentRouteNames = router.getRoutes().map(v => v.name)
    if (!currentRouteNames.includes('Manage')) {
      router.addRoute(manageRoute)
    }
  }
}
setRoutes()

router.beforeEach((to, from, next) => {
  localStorage.setItem("currentPathName", to.name) 
  store.commit("setPath")
  if (!to.matched.length) {
    const menus = localStorage.getItem("menus")
    if (!menus) {
      next("/login")
    } else {
      next("/404")
    }
  } else {
    next()
  }
})

export default router
