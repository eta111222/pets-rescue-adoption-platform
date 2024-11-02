<template>
  <div>
    <div style="margin: 10px 0">
      <el-input style="width: 200px" size="large"  placeholder="Enter Name" suffix-icon="iconfont icon-r-find" v-model="name"></el-input>
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
    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'"  @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="ID" width="80"></el-table-column>
      <el-table-column prop="name" label="name"></el-table-column>
      <el-table-column prop="flag" label="flag"></el-table-column>
      <el-table-column prop="description" label="description"></el-table-column>
      <el-table-column label="operation"  fixed="right"   width="400" align="center">
        <template slot-scope="scope">
          <el-button type="info" @click="selectMenu(scope.row)"> menu </el-button>
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

    <el-dialog title="role info" :visible.sync="dialogFormVisible" width="30%" >
      <el-form label-width="80px" >
        <el-form-item label="name">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="flag">
          <el-input v-model="form.flag" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="description">
          <el-input v-model="form.description" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false"> cancel</el-button>
        <el-button type="primary" @click="save"> confirm</el-button>
      </div>
    </el-dialog>

    <el-dialog title="menu" :visible.sync="menuDialogVis" width="30%">
      <el-tree
          :props="props"
          :data="menuData"
          show-checkbox
          node-key="id"
          ref="tree"
          :default-expanded-keys="expends"
          :default-checked-keys="checks">
         <span class="custom-tree-node" slot-scope="{ node, data }">
            <span><i :class="data.icon"></i> {{ data.name }}</span>
         </span>
      </el-tree>
      <div slot="footer" class="dialog-footer">
        <el-button @click="menuDialogVis = false"> cancel</el-button>
        <el-button type="primary" @click="saveRoleMenu"> confirm</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "Role",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      name: "",
      form: {},
      dialogFormVisible: false,
      menuDialogVis: false,
      multipleSelection: [],
      menuData: [],
      props: {
        label: 'name',
      },
      expends: [],
      checks: [],
      roleId: 0,
      roleFlag: '',
      ids: []
    }
  },
  created() {
    this.load()
  },
  methods: {
    load() {
      this.request.get("/role/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          name: this.name,
        }
      }).then(res => {
        this.tableData = res.data.records
        this.total = res.data.total
      })

      this.request.get("/menu/ids").then(r => {
        this.ids = r.data
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
    saveRoleMenu() {
      this.request.post("/role/roleMenu/" + this.roleId, this.$refs.tree.getCheckedKeys()).then(res => {
        if (res.code === '200') {
          this.$message.success("binded successfully")
          this.menuDialogVis = false

          if (this.roleFlag === 'ROLE_ADMIN') {
            this.$store.commit("logout")
          }

        } else {
          this.$message.error(res.msg)
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
    async selectMenu(role) {
      this.roleId = role.id
      this.roleFlag = role.flag

      this.request.get("/menu").then(res => {
        this.menuData = res.data
        this.expends = this.menuData.map(v => v.id)
      })

      this.menuDialogVis = true
      this.request.get("/role/roleMenu/" + this.roleId).then(res => {
        this.checks = res.data
        this.$refs.tree.setCheckedKeys(res.data)
        this.ids.forEach(id => {
          if (!this.checks.includes(id)) {
            this.$refs.tree.setChecked(id, false)
          }
        })
      })
    },
  }
}
</script>


<style>
.headerBg {
  background: #eee!important;
}
</style>
