<template>
  <div class="wrapper">
    <div
      style="margin: 150px auto; background-color: #fff; width: 450px; height: 300px; padding: 20px; opacity: 0.8; border-radius: 10px;border: 0px solid grey">
      <div style="margin: 20px 0; text-align: center; font-size: 28px; color: rgb(64, 64, 64);">
        <img src="@/assets/front-logo.jpg"
          style="width: 30px;height: 30px;margin: 0 5px -5px 0;-webkit-user-drag: none;-khtml-user-drag: none;-moz-user-drag: none;user-drag: none;" />
        <b><span style="color: #e75c09">pet adoption&rescue platform</span></b>
      </div>
      <el-form :model="user" :rules="rules" ref="userForm">
        <el-form-item prop="username">
          <el-input size="large" prefix-icon="iconfont icon-r-user1" v-model="user.username" style="font-size: 22px;"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input size="large" prefix-icon="iconfont icon-r-lock" show-password v-model="user.password"  style="font-size: 22px;"></el-input>
        </el-form-item>
        <el-form-item style="margin: 10px 0; text-align: right">
          <el-button type="warning" autocomplete="off" @click="$router.push('/register')">sign up</el-button>
          <el-button type="primary" autocomplete="off" @click="login">log in</el-button>

        </el-form-item>

      </el-form>
    </div>



  </div>
</template>

<script>
import { resetRouter, setRoutes } from "@/router";

export default {
  name: "Login",
  data() {
    return {
      user: {},
      pass: {},
      dialogFormVisible: false,
      rules: {
        username: [
  { required: true, message: 'Please enter the username', trigger: 'blur' },
  { min: 3, max: 10, message: 'Length must be between 3 and 10 characters', trigger: 'blur' }
],
password: [
  { required: true, message: 'Please enter the password', trigger: 'blur' },
  { min: 1, max: 20, message: 'Length must be between 1 and 20 characters', trigger: 'blur' }
],

      }
    }
  },
  created() {
    resetRouter()
  },
  methods: {
    login() {
      this.$refs['userForm'].validate((valid) => {
        if (valid) {  
          this.request.post("/user/login", this.user).then(res => {
            if (res.code === '200') {
              localStorage.setItem("user", JSON.stringify(res.data))  
              localStorage.setItem("menus", JSON.stringify(res.data.menus))  

              setRoutes()
              this.$router.push("/front/home")
              this.$message.success("log in successfully")
            } else {
              this.$message.error(res.msg)
            }
          }).catch(e => {
            console.log(e);

            if (
              e.response == undefined ||
              e.response.data == undefined
            ) {
              this.$message({
                showClose: true,
                message: e,
                type: "error",
                duration: 5000,
              });
            } else {
              this.$message({
                showClose: true,
                message: e.response.data,
                type: "error",
                duration: 5000,
              });
            }

          })
        }
      });
    },
    handlePass() {
      this.dialogFormVisible = true
      this.pass = {}
    },
    passwordBack() {
      this.request.put("/user/reset", this.pass).then(res => {
        if (res.code === '200') {
          this.$message.success("reset password successfully，new password：123，please change password")
          this.dialogFormVisible = false
        } else {
          this.$message.error(res.msg)
        }
      })
    }
  }
}
</script>

<style>
.wrapper {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  overflow-y: auto;
  height: 100%;
  background: url("../assets/background.jpg") center top / cover no-repeat;
  overflow: hidden;
}
</style>
