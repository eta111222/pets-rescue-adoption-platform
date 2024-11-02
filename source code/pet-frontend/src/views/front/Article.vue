<template>
  <div style="min-height: calc(100vh - 60px); margin: 10px 0">
    <div style="margin: 10px 0">
      <el-input size="large"  style="width: 400px" placeholder="please type a name" suffix-icon="iconfont icon-r-find" v-model="name"></el-input>
    </div>

    <div style="margin: 10px 0">

      <el-button class="ml-5" type="success" @click="load" >search</el-button>
      <el-button type="primary" class="ml-5"  @click="handleAdd">post</el-button>
    </div>

    <div style="margin: 10px 0;">
      <div v-for="item in tableData" style="padding: 20px; border-radius: 10px; background-color: #fff; margin: 10px 0" :key="item.id">
        <div style="font-size: 20px; font-weight: bold; color: #1E90FF; cursor: pointer" @click="view(item.id, item.content)">{{ item.name }}</div>
        <div style="margin: 15px 0 5px 0; font-size: 14px">
          <span><i class="el-icon-user-solid" style="margin-right: 5px"></i>{{ item.user }}</span>
          <span><i class="el-icon-time" style="margin-right: 5px; margin-left: 20px"></i>{{ item.time }}</span>
          <span >
            <el-button v-if="item.userId === user.id" type="danger" style="float: right; font-size: 16px;  margin-left: 10px" @click="del(item.id)">delete</el-button>
          <el-button v-if="item.userId === user.id" type="success" style="float: right; font-size: 16px" @click="handleEdit(item)">edit</el-button>
          <el-button type="primary" style="float: right; font-size: 16px" @click="handleComment(item.id)">comment</el-button>
          </span>
        </div>
      </div>
    </div>
    <div  style="padding: 10px; margin: 10px 0 30px 0; background-color: #fff; border-radius: 10px">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[2, 5, 10, 20]"
          :page-size="pageSize"
          layout="total, prev, pager, next"
          :total="total">
          <template #total>
            Total {{ total }} items
          </template>
      </el-pagination>
    </div>
    <br>
    <el-dialog title="info" :visible.sync="dialogFormVisible" width="60%" :close-on-click-modal="false">
      <el-form label-width="60px"  style="width: 100%">
        <el-form-item label="name">
          <el-input v-model="form.name" autocomplete="off" style="width: 500px"></el-input>
        </el-form-item>
        <el-form-item label="content">
          <mavon-editor ref="md" v-model="form.content" :ishljs="true" @imgAdd="imgAdd"/>
        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">cancel</el-button>
        <el-button type="primary" @click="save">confirm</el-button>
      </div>
    </el-dialog>

    <el-dialog title="info" :visible.sync="vis" width="60%" :close-on-click-modal="false">
      <mavon-editor
          class="md"
          :value="content"
          :subfield="false"
          :defaultOpen="'preview'"
          :toolbarsFlag="false"
          :editable="false"
          :scrollStyle="true"
          :ishljs="true"
      />

      <div style="margin: 30px 0">
        <div style="margin-bottom: 20px; font-size: 20px; border-bottom: 1px solid #ddd; padding-bottom: 10px">comment list</div>
        <div  v-for="item in comments" style="background-color: #fff; padding: 10px; border-radius: 10px; border-bottom: 1px solid #ddd" :key="item.id">
          <div style="padding: 10px 0; display: flex; color: #666;  font-size: 14px">
            <div style="width: 100px; text-align: center" >
              <el-image :src="$store.state.baseApi+item.avatar" style="width: 50px; height: 50px; border-radius: 50%"></el-image>
            </div>
            <div style="flex: 1; line-height: 25px;">
              <div>
                <span style="color: #3F5EFB">{{item.user }}：</span>
                <span>{{ item.content }}</span>
              </div>
              <div style="font-size: 12px; margin-top: 5px; display: flex">
                <div style="flex: 1"><i class="el-icon-time"></i> <span>{{ item.time }}</span></div>
                <div style="width: 100px; text-align: right">
                  <el-button type="text" @click="delComment(item.id)" style="color: red" v-if="user.nickname === item.user">delete</el-button>
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>
    </el-dialog>


    <el-dialog title="comment" :visible.sync="commentVis" width="50%" :close-on-click-modal="false">
      <el-form label-width="30px"  style="width: 100%">
        <el-form-item label="">
          <el-input type="textarea" :rows="5" v-model="comment.content" autocomplete="off" style="width: 500px"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="commentVis = false">cancel</el-button>
        <el-button type="primary" @click="saveComment">confirm</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "Article",
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
      vis: false,
      content: '',
      comment: {},
      commentVis: false,
      comments: []
    }
  },
  created() {
    if (!this.user.id) {
      this.$message.warning("please login")
      this.$router.push("/login")
      return
    }
    this.load()
  },
  methods: {
    saveComment() {
      if (!this.user.username) {
        this.$message.warning("login to comment")
        return
      }
      if (this.comment.contentr) {
        this.comment.content = this.form.contentr
      }
      if (!this.comment.content) {
        this.$message.warning("please type your comment")
        return
      }
      this.comment.type = 2
      this.request.post("/comment", this.comment).then(res => {
        if (res.code === '200') {
          this.$message.success("comment successful")
          this.commentVis = false
          this.comment = {}  
          this.loadComment()
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    delComment(id) {
      this.request.delete("/comment/" + id).then(res => {
        if (res.code === '200') {
          this.$message.success("delete successful")
          this.loadComment()
        } else {
          this.$message.error("delete failed")
        }
      })
    },
    loadComment(id) {
      this.request.get("/comment/article/2/" + id).then(res => {
        this.comments = res.data
      })
    },
    handleComment(id) {
      this.comment.articleId = id
      this.commentVis = true
    },
    view(id, content) {
      this.content = content
      this.vis = true
      this.loadComment(id)
    },
    imgAdd(pos, $file) {
      let $vm = this.$refs.md
      const formData = new FormData();
      formData.append('file', $file);
      axios({
        url: this.$store.state.baseApi+'/file/upload',
        method: 'post',
        data: formData,
        headers: {'Content-Type': 'multipart/form-data'},
      }).then((res) => {
        $vm.$img2Url(pos, this.$store.state.baseApi + res.data);
      })
    },
    load() {
      this.request.get("/article/page", {
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
      if (!this.form.name) {
        this.$message.error("title can't be empty！")
        return
      }
      if (!this.form.content) {
        this.$message.error("content can't be empty！")
        return
      }
      this.request.post("/article", this.form).then(res => {
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
      this.request.delete("/article/" + id).then(res => {
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
      this.request.post("/article/del/batch", ids).then(res => {
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
      window.open(this.$store.state.baseApi+"/article/export")
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
