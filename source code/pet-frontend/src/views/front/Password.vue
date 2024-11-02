<template>
  <div  style="min-height: calc(100vh - 60px); padding: 10px 0">
    <el-card style="width: 500px;">
      <el-form label-width="100px" :model="form" :rules="rules" ref="pass">

<el-form-item label="Current Password" prop="password">
  <el-input v-model="form.password" autocomplete="off" show-password></el-input>
</el-form-item>

<el-form-item label="New Password" prop="newPassword">
  <el-input v-model="form.newPassword" autocomplete="off" show-password></el-input>
</el-form-item>

<el-form-item label="Confirm New Password" prop="confirmPassword">
  <el-input v-model="form.confirmPassword" autocomplete="off" show-password></el-input>
</el-form-item>

<el-form-item>
  <el-button type="primary" @click="save"> Confirm </el-button>
</el-form-item>

</el-form>

    </el-card>
  </div>

</template>

<script>
export default {
  name: "Password",
  data() {
    return {
      form: {},
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      rules: {
        password: [
  { required: true, message: 'Please enter the current password', trigger: 'blur' },
  { min: 3, message: 'Length should be at least 3 characters', trigger: 'blur' }
],
newPassword: [
  { required: true, message: 'Please enter the new password', trigger: 'blur' },
  { min: 3, message: 'Length should be at least 3 characters', trigger: 'blur' }
],
confirmPassword: [
  { required: true, message: 'Please confirm the password', trigger: 'blur' },
  { min: 3, message: 'Length should be at least 3 characters', trigger: 'blur' }
],
      }
    }
  },
  created() {
    this.form.username = this.user.username
  },
  methods: {
    save() {
      this.$refs.pass.validate((valid) => {
        if (valid) {
          if (this.form.newPassword !== this.form.confirmPassword) {
            this.$message.error("The two entries for the new password do not match")
            return false
          }
          this.request.post("/user/password", this.form).then(res => {
            if (res.code === '200') {
              this.$message.success("change successful")
              this.$store.commit("logout")
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      })
    },
  }
}
</script>

<style>
.avatar-uploader {
  text-align: center;
  padding-bottom: 10px;
}
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 138px;
  height: 138px;
  line-height: 138px;
  text-align: center;
}
.avatar {
  width: 138px;
  height: 138px;
  display: block;
}
</style>
