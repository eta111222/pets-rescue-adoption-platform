<template>
  <div style="padding-bottom: 20px; min-height: calc(100vh - 60px)">
    <div style="padding: 20px; background-color: #fff; border-radius: 10px; margin: 10px 0">
      <el-input size="large" v-model="nickname" style="width: 400px" ></el-input>
      <br>
      <br>
      <el-button type="primary" @click="load()">search</el-button>
      <el-button type="success" style="margin-left: 30px"  @click="$router.push('/front/myAdopt')">check my adoption</el-button>
    </div>
    <div style="margin: 10px 0">
      <el-card  v-for="item in tableData" :key="item.id" style="margin: 10px 0">
        <div style="display: flex">
          <div style="width: 140px" @click="$router.push('/front/homeDetail?id=' + item.id)"> <img :src="$store.state.baseApi+item.img" alt="" style="width: 100%; height: 160px; border-radius: 10px"></div>
          <div style="padding-left: 50px; flex: 1">
            <div style="border-bottom: 1px solid #ddd; width: 100%; padding-bottom: 10px">
              <span style="font-size: 24px">{{ item.nickname }}</span>
              <span style="margin-left: 20px">{{ item.sex }}</span>
              <span style="margin-left: 20px">{{ item.age }}</span>
            </div>
            <div style="line-height: 30px">
              <div><b style="margin-right: 10px">sterilization status：</b>{{ item.sterilization }}</div>
              <div><b style="margin-right: 10px">vaccine status：</b>{{ item.vaccine }}</div>
              <div><b style="margin-right: 10px">physical conditons：</b>{{ item.status }}</div>
              <div><b style="margin-right: 10px">other info：</b>{{ item.information }}</div>
              <div style="text-align: right;" ><el-button type="primary" @click="handleApply(item.id)">apply to adopt</el-button></div>
            </div>
          </div>
        </div>
      </el-card>
    </div>

    <div style="padding: 10px; background-color: #fff; border-radius: 10px">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[2, 5, 10, 20]"
          :page-size="pageSize"
          layout="total, prev, pager, next"
          :total="total">
      </el-pagination>
    </div>

    <el-dialog title="info" :visible.sync="dialogFormVisible" width="30%" :close-on-click-modal="false">
      <el-form label-width="100px"  style="width: 90%">
        <el-form-item label="name">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="sex">
          <el-radio v-model="form.sex" label="男">male</el-radio>
          <el-radio v-model="form.sex" label="女">female</el-radio>
        </el-form-item>
        <el-form-item label="age">
          <el-input v-model="form.age" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="pet experience">
          <el-radio v-model="form.experience" label="yes">have experience</el-radio>
          <el-radio v-model="form.experience" label="no">no experience</el-radio>
        </el-form-item>
        <el-form-item label="contact">
          <el-input v-model="form.phone" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="married">
          <el-radio v-model="form.married" label="single">single</el-radio>
          <el-radio v-model="form.married" label="married">married</el-radio>
        </el-form-item>
        <el-form-item label="income">
          <el-input v-model="form.income" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="possesion">
          <el-input v-model="form.profession" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="address">
          <el-input v-model="form.address" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="reason">
          <el-input v-model="form.reason" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">cancel</el-button>
        <el-button type="primary" @click="save">confirm</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
export default {
  name: "FrontHome",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      nickname: "",
      dialogFormVisible: false,
      form: {},
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
    }
  },
  created() {
    this.load()
  },
  methods: {
    save() {
      this.form.userId = this.user.id
      this.request.post("/applcation", this.form).then(res => {
        if (res.code === '200') {
          this.$message.success("save successful")
          this.dialogFormVisible = false
        } else {
          this.$message.error("save failed")
        }
      })
    },
    handleApply(animalId) {
      this.form = {animalId: animalId}
      this.dialogFormVisible = true
    },
    load() {
      this.request.get("/animal/page/user", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.nickname,
        }
      }).then(res => {
        this.tableData = res.data.records
        this.total = res.data.total
      })
    },
    handleSizeChange(pageSize) {
      console.log(pageSize)
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum) {
      console.log(pageNum)
      this.pageNum = pageNum
      this.load()
    },
  }
}
</script>

<style>

</style>
