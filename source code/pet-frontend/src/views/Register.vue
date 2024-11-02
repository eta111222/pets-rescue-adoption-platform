<template>
  <div class="wrapper">
    <div
      style="margin: 150px auto; background-color: #fff; width: 400px; height: 340px; padding: 20px;opacity: 0.95; border-radius: 10px;  border-radius: 10px;border: 1px solid grey">
      <div style="margin: 20px 0; text-align: center; font-size: 24px"><b>注册新账号</b></div>
      <el-form :model="user" :rules="rules" ref="userForm">
        <el-form-item prop="username">
  <el-input placeholder="Please enter your username" size="large" prefix-icon="iconfont icon-r-user2"
    v-model="user.username"></el-input>
</el-form-item>
<el-form-item prop="password">
  <el-input placeholder="Please enter your password" size="large" prefix-icon="iconfont icon-r-lock" show-password
    v-model="user.password"></el-input>
</el-form-item>
<el-form-item prop="confirmPassword">
  <el-input placeholder="Please confirm your password" size="large" prefix-icon="iconfont icon-r-lock" show-password
    v-model="user.confirmPassword"></el-input>
</el-form-item>

       
        <el-form-item style="margin: 5px 0; text-align: right">
          <el-button type="primary" autocomplete="off" @click="login">sign up</el-button>
          <el-button type="warning" autocomplete="off" @click="$router.push('/login')">return to log in</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  name: "Login",
  data() {
    return {
      user: {},
      rules: {
        username: [
  { required: true, message: 'Please enter your username', trigger: 'blur' },
  { min: 3, max: 10, message: 'Length must be between 3 and 10 characters', trigger: 'blur' }
],
password: [
  { required: true, message: 'Please enter your password', trigger: 'blur' },
  { min: 1, max: 20, message: 'Length must be between 1 and 20 characters', trigger: 'blur' }
],
confirmPassword: [
  { required: true, message: 'Please confirm your password', trigger: 'blur' },
  { min: 1, max: 20, message: 'Length must be between 1 and 20 characters', trigger: 'blur' }
],

      }
    }
  },
  methods: {
    login() {
      this.$refs['userForm'].validate((valid) => {
        if (valid) {  
          if (this.user.password !== this.user.confirmPassword) {
  this.$message.error("The two passwords entered do not match");
  return false;
}
this.request.post("/user/register", this.user).then(res => {
  if (res.code === '200') {
    this.$message.success("Registration successful");
  } else {
    this.$message.error(res.msg);
  }
});

        }
      });
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
}</style>
