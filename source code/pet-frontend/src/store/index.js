import Vue from 'vue'
import Vuex from 'vuex'
import router, {resetRouter} from "@/router";

Vue.use(Vuex)

const store = new Vuex.Store({
    state: {
        currentPathName: '',
        baseApi: 'https://pet-rescue-adoption-platform-c8bf9235895b.herokuapp.com/'
    },
    mutations: {
        setPath (state) {
            state.currentPathName = localStorage.getItem("currentPathName")
        },
        logout() {
            localStorage.removeItem("user")
            localStorage.removeItem("menus")
            router.push("/login")
            resetRouter()
        }
    }
})

export default store
