<template>
  <div style="padding-bottom: 20px; min-height: calc(100vh - 60px)">
    <div v-if="!tableData.length" style=" margin: 10px 0">
      <el-card>
        <div style="text-align: center; color: #999;">No adoption application records yet</div>
      </el-card>
    </div>
    <div v-else style="margin: 10px 0">
      <el-card  v-for="item in tableData" :key="item.id" style="margin: 10px 0">
        <div style="display: flex">
          <div style="width: 140px"> <img :src="$store.state.baseApi+item.animal.img" alt="" style="width: 100%; height: 160px; border-radius: 10px"></div>
          <div style="padding-left: 50px; flex: 1">
            <div style="border-bottom: 1px solid #ddd; width: 100%; padding-bottom: 10px">
              <span style="font-size: 24px">{{ item.animal.nickname }}</span>
              <span style="margin-left: 20px">{{ item.animal.sex }}</span>
              <span style="margin-left: 20px">{{ item.animal.age }}</span>
              <b style="margin-left: 30px">
                <span v-if="item.state === 'review passed'" style="color: green">review passed</span>
                <span v-if="item.state === 'review not passed'" style="color: red">review not passed</span>
              </b>
            </div>
            <div style="line-height: 30px">
              <div><b style="margin-right: 10px">sterilization：</b>{{ item.animal.sterilization }}</div>
              <div><b style="margin-right: 10px">vaccine：</b>{{ item.animal.vaccine }}</div>
              <div><b style="margin-right: 10px">physical conditions：</b>{{ item.animal.status }}</div>
              <div><b style="margin-right: 10px">others：</b>{{ item.animal.information }}</div>
            </div>
          </div>
        </div>
        <div style="padding: 10px 0">
          <el-descriptions title="details">
            <el-descriptions-item label="name">{{ item.name }}</el-descriptions-item>
            <el-descriptions-item label="sex">{{ item.sex }}</el-descriptions-item>
            <el-descriptions-item label="age">{{ item.age }}</el-descriptions-item>
            <el-descriptions-item label="experience">{{ item.experience }}</el-descriptions-item>
            <el-descriptions-item label="contact">{{ item.phone }}</el-descriptions-item>
            <el-descriptions-item label="married">{{ item.married }}</el-descriptions-item>
            <el-descriptions-item label="income">{{ item.income }}</el-descriptions-item>
            <el-descriptions-item label="profession">{{ item.profession }}</el-descriptions-item>
            <el-descriptions-item label="address">{{ item.address }}</el-descriptions-item>
            <el-descriptions-item label="reason">{{ item.reason }}</el-descriptions-item>
          </el-descriptions>
        </div>
      </el-card>
    </div>


    <el-dialog title="info" :visible.sync="dialogFormVisible" width="30%" :close-on-click-modal="false">
      <el-form label-width="100px"  style="width: 90%">
        <el-form-item label="name">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="sex">
          <el-radio v-model="form.sex" label="male">male</el-radio>
          <el-radio v-model="form.sex" label="female">female</el-radio>
        </el-form-item>
        <el-form-item label="age">
          <el-input v-model="form.age" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="pet experience">
          <el-radio v-model="form.experience" label="no experince">no experince</el-radio>
          <el-radio v-model="form.experience" label="experince">experince</el-radio>
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
      form: {}
    }
  },
  created() {
    this.load()
  },
  methods: {
    save() {
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
      this.request.get("/applcation/my").then(res => {
        this.tableData = res.data
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
