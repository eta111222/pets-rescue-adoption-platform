<template>
  <div style="margin: 10px 0">
    <el-table :data="tableData" stripe  style="border-radius: 10px">
      <el-table-column label="pic"><template slot-scope="scope"><el-image style="width: 100px; height: 100px" :src="$store.state.baseApi+scope.row.img" :preview-src-list="[$store.state.baseApi + scope.row.img]"></el-image></template></el-table-column>
      <el-table-column prop="name" label="name"></el-table-column>
      <el-table-column prop="addres" label="address"></el-table-column>
      <el-table-column prop="person" label="contact person"></el-table-column>
      <el-table-column prop="phone" label="contact"></el-table-column>
      <el-table-column prop="information" label="info"></el-table-column>

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
      <el-form label-width="100px"  style="width: 90%">
        <el-form-item label="name">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="address">
          <el-input v-model="form.addres" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="pic">
          <el-upload :action="$store.state.baseApi+'/file/upload'" ref="img" :on-success="handleImgUploadSuccess">
            <el-button  type="primary">click to upload</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item label="contact person">
          <el-input v-model="form.person" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="contact">
          <el-input v-model="form.phone" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="info">
          <el-input v-model="form.information" autocomplete="off"></el-input>
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
  name: "Rescue",
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
      this.request.get("/rescue/page", {
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
      this.request.post("/rescue", this.form).then(res => {
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
      this.request.delete("/rescue/" + id).then(res => {
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
        this.$message.error("Please select the data to delete.")
        return
      }
      let ids = this.multipleSelection.map(v => v.id)  // [{}, {}, {}] => [1,2,3]
      this.request.post("/rescue/del/batch", ids).then(res => {
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
      window.open(this.$store.state.baseApi+"/rescue/export")
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
</style>
