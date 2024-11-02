<template>
  <div style="background-color:rgba(231,92,9,0.27);">
    <div style="display: flex; background-color: #fff; height: 60px; line-height: 60px; border-bottom: 1px solid #eee">
      <div style="width: 240px; display: flex; padding-left: 30px">
        <div style="width: 60px">
          <img src="../../assets/front-logo.jpg" alt="" style="width: 40px; position: relative; top: 10px; right: 0">
        </div>
        <div style="flex: 1; font-size: 20px; color: #e75c09; font-weight: bold">pet adoption platform</div>
      </div>
      <div style="flex: 1">

        <el-menu :default-active="'1'" class="el-menu-demo" mode="horizontal" router>
          <el-menu-item index="/front/home"></el-menu-item>
          <el-menu-item index="/front/adopt">pet adoption</el-menu-item>
          <el-menu-item index="/front/salvation">pet rescue</el-menu-item>
          <el-menu-item index="/front/lost">check lost pets</el-menu-item>
          <el-menu-item index="/front/article">pet forum</el-menu-item>
        </el-menu>
      </div>
      <div style="width: 160px">
        <div v-if="!user.username" style="text-align: right; padding-right: 30px">
          <el-button @click="$router.push('/login')">log in</el-button>
          <el-button @click="$router.push('/register')">sign up</el-button>
        </div>
        <div v-else>
          <el-dropdown style="width: 150px; cursor: pointer; text-align: right">

            <div style="display: inline-block;margin-top: -20px;font-size: 18px;">
        <img :src="$store.state.baseApi+user.avatarUrl" alt=""
             style="width: 57px; border-radius: 10%; position: relative; top: 21px; right: 5px">
        <span>{{ user.nickname }}</span>
        <i class="el-icon-arrow-down" style="margin-left: 5px;"></i>
      </div>
            <el-dropdown-menu slot="dropdown" style="width: 100px; text-align: center">
              <el-dropdown-item style="font-size: 14px; padding: 5px 0" v-if="user.role === 'ROLE_ADMIN'">
                <router-link to="/home">backend management</router-link>
              </el-dropdown-item>
              <el-dropdown-item style="font-size: 14px; padding: 5px 0">
                <router-link to="/front/password">change password</router-link>
              </el-dropdown-item>
              <el-dropdown-item style="font-size: 14px; padding: 5px 0">
                <router-link to="/front/person">personal info</router-link>
              </el-dropdown-item>
              <el-dropdown-item style="font-size: 14px; padding: 5px 0">
                <span style="text-decoration: none" @click="logout">log out</span>
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </div>
    </div>

    <div style="width: 800px; margin: 0 auto">
      <router-view />
    </div>
  </div>
</template>

<script>
export default {
  name: "Front",
  data() {
    return {
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
    }
  },
  created() {

  },
  methods: {
    logout() {
      this.$store.commit("logout")
      this.$message.success("logout successful")
    }
  }
}
</script>

<style>
.item{
  display: inline-block;
  width: 100px;

  text-align: center;
  cursor: pointer
}
.item a {
  color: 	#1E90FF;
}
.item:hover{
  background-color: 	LightPink;
}
</style>
