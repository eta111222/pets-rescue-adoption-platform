<template>
  <div style="min-height: calc(100vh - 60px); margin: 10px 0">

    <div class="activity"> popular activity</div>

    <div style="margin: 10px 0;">
      <div v-for="item in tableData" style="padding: 20px; border-radius: 10px; background-color: #fff; margin: 10px 0"
        :key="item.id">
        <div style="display: flex">
          <div style="width: 200px;">
            <el-image :src="$store.state.baseApi + item.img" style="width: 100px; border-radius: 10px; height: 100px"
              :preview-src-list="[$store.state.baseApi + item.img]"></el-image>
          </div>
          <div style="flex: 1">
            <div style="font-size: 20px; font-weight: bold; color: #E6A23C; cursor: pointer" @click="view(item.content)">
              {{ item.time.substr(0, 16) }}
            </div>
            <div style="margin-top: 20px; color: #333; cursor: pointer">
              {{ item.name }}
            </div>

            <div style="margin-top: 20px; font-size: 14px">
              <span><i class="el-icon-location" style="margin-right: 5px"></i>{{ item.address }}</span>
              <span v-if="item.userId === user.id">
                <el-button type="text" style="float: right; font-size: 16px; color: red; margin-left: 10px"
                  @click="del(item.id)"> delete</el-button>
                <el-button type="text" style="float: right; font-size: 16px" @click="handleEdit(item)"> edit</el-button>
              </span>
            </div>
          </div>



        </div>
      </div>
    </div>
    <div style="padding: 10px; margin: 10px 0; background-color: #fff; border-radius: 10px">
      <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="pageNum"
        :page-sizes="[2, 5, 10, 20]" :page-size="pageSize" layout="total, prev, pager, next" :total="total">
      </el-pagination>
    </div>


    <el-dialog title="info" :visible.sync="dialogFormVisible" width="60%" :close-on-click-modal="false">
      <el-form label-width="100px" style="width: 90%">
        <el-form-item label="name">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="cover">
          <el-upload class="avatar-uploader" :action="$store.state.baseApi + '/file/upload'" :show-file-list="false"
            :on-success="handleImgUploadSuccess">
            <img v-if="form.img" :src="$store.state.baseApi + form.img" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>
        <el-form-item label="time">
          <el-date-picker v-model="form.time" type="datetime" value-format="yyyy-MM-dd HH:mm:ss"
            placeholder="select a date"></el-date-picker>
        </el-form-item>
        <el-form-item label="sign up number">
          <el-input v-model="form.num" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="address">
          <el-input v-model="form.address" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="content">
          <mavon-editor ref="md" v-model="form.content" :ishljs="true" @imgAdd="imgAdd" />
        </el-form-item>



      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false"> cancel</el-button>
        <el-button type="primary" @click="save"> confirm</el-button>
      </div>
    </el-dialog>


    <el-dialog title="info" :visible.sync="vis" width="60%" :close-on-click-modal="false">
      <mavon-editor class="md" :value="content" :subfield="false" :defaultOpen="'preview'" :toolbarsFlag="false"
        :editable="false" :scrollStyle="true" :ishljs="true" />
    </el-dialog>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "Activity",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 5,
      name: "",
      form: {},
      dialogFormVisible: false,
      multipleSelection: [],
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      vis: false,
      content: ''
    }
  },
  created() {
    this.load()
  },
  methods: {
    view(content) {
      this.content = content
      this.vis = true
    },
    imgAdd(pos, $file) {
      let $vm = this.$refs.md
      const formData = new FormData();
      formData.append('file', $file);
      axios({
        url: this.$store.state.baseApi + '/file/upload',
        method: 'post',
        data: formData,
        headers: { 'Content-Type': 'multipart/form-data' },
      }).then((res) => {
        $vm.$img2Url(pos, this.$store.state.baseApi + res.data);
      })
    },
    load() {
      this.request.get("/activity/page", {
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
      this.request.post("/activity", this.form).then(res => {
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
        if (this.$refs.img) {
          this.$refs.img.clearFiles();
        }
        if (this.$refs.file) {
          this.$refs.file.clearFiles();
        }
      })
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogFormVisible = true
      this.$nextTick(() => {
        if (this.$refs.img) {
          this.$refs.img.clearFiles();
        }
        if (this.$refs.file) {
          this.$refs.file.clearFiles();
        }
      })
    },
    del(id) {
      this.request.delete("/activity/" + id).then(res => {
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
      this.request.post("/activity/del/batch", ids).then(res => {
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
      window.open(this.$store.state.baseApi + "/activity/export")
    },
    handleExcelImportSuccess() {
      this.$message.success("mport successful")
      this.load()
    }
  }
}
</script>


<style>
.activity {
  padding: 20px 10px;
  font-size: 28px;
  background-color: #fff;
  border-radius: 10px;
  color: orange;
}
.headerBg {
  background: #eee !important;
}

.avatar-uploader {
  padding-left: 20px;
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
