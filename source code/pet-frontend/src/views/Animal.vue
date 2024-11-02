<template>
  <div>
    <div style="margin: 10px 0">
      <el-input style="width: 200px" size="large" placeholder="Enter Name" suffix-icon="iconfont icon-r-find" v-model="name"></el-input>
      <el-select clearable v-model="adopt" size="large" placeholder="Select" class="ml-5">
        <el-option v-for="item in ['Not Available for Adoption', 'Available for Adoption']" :key="item" :label="item" :value="item"></el-option>
      </el-select>
    </div>

    <div style="margin: 10px 0">
      <el-button class="ml-5" type="primary" @click="load"> Search </el-button>
      <el-button type="warning" @click="reset"> Reset </el-button>
      <el-button type="primary" @click="handleAdd"> Add </el-button>
      <el-popconfirm
          class="ml-5"
          confirm-button-text='Confirm'
          cancel-button-text='Cancel'
          icon="el-icon-info"
          icon-color="red"
          title="Are you sure you want to batch delete these data?"
          @confirm="delBatch"
      >
        <el-button type="danger" slot="reference"> Batch Delete </el-button>
      </el-popconfirm>
  
    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'"  @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="ID" width="80" sortable></el-table-column>
      <el-table-column prop="nickname" label="Animal Name"></el-table-column>
      <el-table-column prop="sex" label="Animal Gender"></el-table-column>
      <el-table-column prop="type" label="Species"></el-table-column>
      <el-table-column prop="age" label="Age"></el-table-column>
      <el-table-column label="Image" width="140">
        <template slot-scope="scope">
          <el-image style="width: 100px; height: 100px" :src="$store.state.baseApi+scope.row.img" :preview-src-list="[$store.state.baseApi + scope.row.img]"></el-image>
        </template>
      </el-table-column>
      <el-table-column prop="address" label="Activity Range"></el-table-column>
      <el-table-column prop="status" label="Physical Condition"></el-table-column>
      <el-table-column prop="sterilization" label="Sterilized"></el-table-column>
      <el-table-column prop="vaccine" label="Vaccinated"></el-table-column>
      <el-table-column prop="adopt" label="Adoption Status"></el-table-column>
      <el-table-column prop="isAdopt" label="Adopted"></el-table-column>
      <el-table-column prop="information" label="Additional Information"></el-table-column>

      <el-table-column label="Actions" fixed="right" width="280" align="center">
        <template slot-scope="scope">
          <el-button type="success" @click="handleEdit(scope.row)"> Edit </el-button>
          <el-popconfirm
              class="ml-5"
              confirm-button-text='Confirm'
              cancel-button-text='Cancel'
              icon="el-icon-info"
              icon-color="red"
              title="Are you sure you want to delete?"
              @confirm="del(scope.row.id)"
          >
            <el-button type="danger" slot="reference"> Delete </el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <div style="padding: 10px 0">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[2, 5, 10, 20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
          <template #total>
            Total {{ total }} items
          </template>
      </el-pagination>
    </div>

    <el-dialog title="Information" :visible.sync="dialogFormVisible" width="30%" :close-on-click-modal="false">
      <el-form label-width="100px" style="width: 90%">
        <el-form-item label="Animal Name">
          <el-input v-model="form.nickname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="Animal Gender">
          <el-radio v-model="form.sex" label="Male">Male</el-radio>
          <el-radio v-model="form.sex" label="Female">Female</el-radio>
        </el-form-item>
        <el-form-item label="Species">
          <el-input v-model="form.type" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="Age">
          <el-input v-model="form.age" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="Animal Photo">
          <el-upload :action="$store.state.baseApi+'/file/upload'" ref="img" :on-success="handleImgUploadSuccess">
            <el-button type="primary"> Upload </el-button>
          </el-upload>
        </el-form-item>
        <el-form-item label="Activity Range">
          <el-input v-model="form.address" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="Physical Condition">
          <el-input v-model="form.status" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="Sterilized">
          <el-radio v-model="form.sterilization" label="Yes">Yes</el-radio>
          <el-radio v-model="form.sterilization" label="No">No</el-radio>
        </el-form-item>
        <el-form-item label="Vaccinated">
          <el-radio v-model="form.vaccine" label="Not Vaccinated">Not Vaccinated</el-radio>
          <el-radio v-model="form.vaccine" label="Vaccinated">Vaccinated</el-radio>
        </el-form-item>
        <el-form-item label="Adoption Status">
          <el-radio v-model="form.adopt" label="Not Available for Adoption">Not Available for Adoption</el-radio>
          <el-radio v-model="form.adopt" label="Available for Adoption">Available for Adoption</el-radio>
        </el-form-item>
        <el-form-item label="Adopted">
          <el-radio v-model="form.isAdopt" label="Yes">Yes</el-radio>
          <el-radio v-model="form.isAdopt" label="No">No</el-radio>
        </el-form-item>
        <el-form-item label="Additional Information">
          <el-input type="textarea" v-model="form.information" autocomplete="off"></el-input>
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
  name: "Animal",
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
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      adopt: ''
    }
  },
  created() {
    this.load()
  },
  methods: {
    load() {
      this.request.get("/animal/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
          adopt: this.adopt,
        }
      }).then(res => {
        this.tableData = res.data.records
        this.total = res.data.total
      })
    },
    save() {
      this.request.post("/animal", this.form).then(res => {
        if (res.code === '200') {
          this.$message.success("Saved successfully")
          this.dialogFormVisible = false
          this.load()
        } else {
          this.$message.error("Save failed")
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
      this.request.delete("/animal/" + id).then(res => {
        if (res.code === '200') {
          this.$message.success("Deleted successfully")
          this.load()
        } else {
          this.$message.error("Delete failed")
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
      this.request.post("/animal/del/batch", ids).then(res => {
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
      this.adopt = ""
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
      window.open(this.$store.state.baseApi+"/animal/export")
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
