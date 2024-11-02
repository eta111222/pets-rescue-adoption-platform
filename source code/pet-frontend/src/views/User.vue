<template>
  <div>
    <div style="margin: 10px 0">
      <el-input style="width: 200px" size="large"  placeholder="请输入名称" suffix-icon="iconfont icon-r-find" v-model="username"></el-input>
      <el-input style="width: 200px" size="large"  placeholder="请输入邮箱" suffix-icon="el-icon-message" class="ml-5" v-model="email"></el-input>
      <el-input style="width: 200px" size="large"  placeholder="请输入地址" suffix-icon="el-icon-position" class="ml-5" v-model="address"></el-input>
    </div>

    <div style="margin: 10px 0">
      <el-button class="ml-5" type="primary" @click="load">search</el-button>
      <el-button type="warning" @click="reset">reset</el-button>
      <el-button type="primary" @click="handleAdd(null)"> add </el-button>
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
      <el-upload :action="$store.state.baseApi+'/user/import'" :show-file-list="false" accept="xlsx" :on-success="handleExcelImportSuccess" style="display: inline-block">
        <el-button type="primary" class="ml-5"> import <i class="el-icon-bottom"></i></el-button>
      </el-upload>
      <el-button type="primary" @click="exp" class="ml-5"> export <i class="el-icon-top"></i></el-button>
    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'"  @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="ID" width="80"></el-table-column>
      <el-table-column prop="username" label="username" width="140"></el-table-column>
      <el-table-column prop="role" label="role"></el-table-column>
      <el-table-column prop="nickname" label="nickname" width="120"></el-table-column>
      <el-table-column prop="sex" label="sex" width="120"></el-table-column>
      <el-table-column prop="birth" label="birth" width="120"></el-table-column>
      <el-table-column prop="email" label="email"></el-table-column>
      <el-table-column prop="phone" label="phone"></el-table-column>
      <el-table-column prop="address" label="address"></el-table-column>
      <el-table-column label="operation"  fixed="right"   width="280" align="center">
        <template slot-scope="scope">
          <el-button type="success" @click="handleEdit(scope.row)"> edit </el-button>
          <el-popconfirm
              class="ml-5"
              confirm-button-text='Confirm'
          cancel-button-text='Cancel'
          icon="el-icon-info"
          icon-color="red"
          title="Are you sure you want to delete these data?"
              @confirm="del(scope.row.id)"
          >
            <el-button type="danger" slot="reference"> delete </el-button>
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
      </el-pagination>
    </div>

    <el-dialog title="user info" :visible.sync="dialogFormVisible" width="30%" >
      <el-form label-width="80px" >
        <el-form-item label="username">
          <el-input v-model="form.username" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="role">
          <el-select clearable v-model="form.role" placeholder="please select a role" style="width: 100%">
            <el-option v-for="item in roles" :key="item.name" :label="item.name" :value="item.flag"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="nickname">
          <el-input v-model="form.nickname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="sex">
          <el-radio v-model="form.sex" label="male">male</el-radio>
          <el-radio v-model="form.sex" label="female">female</el-radio>
        </el-form-item>
        <el-form-item label="birth">
          <el-date-picker clearable style="width: 80%" v-model="form.birth" type="date" value-format="yyyy-MM-dd" placeholder="select a date"></el-date-picker>
        </el-form-item>

        <el-form-item label="email">
          <el-input v-model="form.email" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="phone">
          <el-input v-model="form.phone" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="address">
          <el-input v-model="form.address" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">  cancel</el-button>
        <el-button type="primary" @click="save"> confirm</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "User",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      username: "",
      email: "",
      address: "",
      form: {},
      dialogFormVisible: false,
      multipleSelection: [],
      roles: []
    }
  },
  created() {
    this.load()
  },
  methods: {
    load() {
      this.request.get("/user/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          username: this.username,
          email: this.email,
          address: this.address,
        }
      }).then(res => {

        this.tableData = res.data.records
        this.total = res.data.total

      })

      this.request.get("/role").then(res => {
        this.roles = res.data
      })
    },
    save() {
      this.request.post("/feed", this.form).then(res => {
        if (res.code === '200') {
          this.$message.success("saved successfully")
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
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogFormVisible = true
    },
    del(id) {
      this.request.delete("/feed/" + id).then(res => {
        if (res.code === '200') {
          this.$message.success("deleted successsfully")
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
        this.$message.error("pleae select data to delete")
        return
      }
      let ids = this.multipleSelection.map(v => v.id)  // [{}, {}, {}] => [1,2,3]
      this.request.post("/feed/del/batch", ids).then(res => {
        if (res.code === '200') {
          this.$message.success("batch deletion successful")
          this.load()
        } else {
          this.$message.error("batch deletion failed")
        }
      })
    },
    reset() {
      this.username = ""
      this.email = ""
      this.address = ""
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
    exp() {
      window.open(this.$store.state.baseApi+"/user/export")
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
