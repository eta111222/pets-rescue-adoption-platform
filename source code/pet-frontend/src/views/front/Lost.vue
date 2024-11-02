<template>
  <div style="min-height: calc(100vh - 60px); margin: 10px 0">

    <div class="lost">check lost pets</div><br>
    <el-table :data="tableData" stripe  style="border-radius: 10px"   @selection-change="handleSelectionChange">
      <el-table-column prop="nickname" label="name"></el-table-column>
      <el-table-column prop="type" label="species"></el-table-column>
      <el-table-column prop="sex" label="sex"></el-table-column>
      <el-table-column prop="person" label="contact person"></el-table-column>
      <el-table-column prop="phone" label="contact"></el-table-column>
      <el-table-column prop="status1" label="lost/waiting for adoption"></el-table-column>
      <el-table-column prop="status2" label="status"></el-table-column>

    </el-table>
    <div  style="padding: 10px; margin: 10px 0; background-color: #fff; border-radius: 10px">
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
      <el-form label-width="110px"  style="width: 90%">
        <el-form-item label="name">
          <el-input v-model="form.nickname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="species">
          <el-input v-model="form.type" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="sex">
          <el-radio v-model="form.sex" label="male">male</el-radio>
          <el-radio v-model="form.sex" label="female">female</el-radio>
        </el-form-item>
        <el-form-item label="contack person">
          <el-input v-model="form.person" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="contact">
          <el-input v-model="form.phone" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="lost/waiting for adoption">
          <el-radio v-model="form.status1" label="lost">lost</el-radio>
          <el-radio v-model="form.status1" label="waiting">waiting for owner</el-radio>
        </el-form-item>
        <el-form-item label="status">
          <el-radio v-model="form.status2" label="lost">lost</el-radio>
          <el-radio v-model="form.status2" label="found">found</el-radio>
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
  name: "Lost",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      name: "",
      form: {},
      dialogFormVisible: false,
      multipleSelection: [],
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
    }
  },
  created() {
    this.load()
  },
  methods: {
    load() {
      this.request.get("/lost/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
        }
      }).then(res => {
        this.tableData = res.data.records
        this.total = res.data.total
      })
    },
    save() {
      this.request.post("/lost", this.form).then(res => {
        if (res.code === '200') {
          this.$message.success("save successful")
          this.dialogFormVisible = false
          this.load()
        } else {
          this.$message.error("save failed")
        }
      })
    },
    handleAdd() {
      this.dialogFormVisible = true
      this.form = {}
      this.$nextTick(() => {
        if(this.$refs.img) {
           this.$refs.img.clearFiles();
         }
         if(this.$refs.file) {
          this.$refs.file.clearFiles();
         }
      })
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogFormVisible = true
       this.$nextTick(() => {
         if(this.$refs.img) {
           this.$refs.img.clearFiles();
         }
         if(this.$refs.file) {
          this.$refs.file.clearFiles();
         }
       })
    },
    del(id) {
      this.request.delete("/lost/" + id).then(res => {
        if (res.code === '200') {
          this.$message.success("delete successful")
          this.load()
        } else {
          this.$message.error("delete failed")
        }
      })
    },
    handleSelectionChange(val) {
      console.log(val)
      this.multipleSelection = val
    },
    delBatch() {
      if (!this.multipleSelection.length) {
        this.$message.error("Please select the data to delete")
        return
      }
      let ids = this.multipleSelection.map(v => v.id)  // [{}, {}, {}] => [1,2,3]
      this.request.post("/lost/del/batch", ids).then(res => {
        if (res.code === '200') {
          this.$message.success("Batch deletion successful")
          this.load()
        } else {
          this.$message.error("Batch deletion failed")
        }
      })
    },
    reset() {
      this.name = ""
      this.load()
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
    handleFileUploadSuccess(res) {
      this.form.file = res
    },
    handleImgUploadSuccess(res) {
      this.form.img = res
    },
    download(url) {
      window.open(url)
    },
    exp() {
      window.open(this.$store.state.baseApi+"/lost/export")
    },
    handleExcelImportSuccess() {
      this.$message.success("import successful")
      this.load()
    }
  }
}
</script>


<style>
.headerBg {
  background: #eee!important;
}

.lost {
  padding: 20px 10px;
  font-size: 28px;
  background-color: #fff;
  border-radius: 10px;
  color: red;
}
</style>
