<template>
  <div style="color: #666;font-size: 14px;">
    <div style="padding-bottom: 20px">
      <b>Hello！{{ user.nickname }}</b>
    </div>

    <div style="margin-bottom: 60px">
      <el-card>
        <div class="welcome"> <b> welcome to our pet rescue platform</b></div>
        <el-divider />
        <img src="@/assets/back-background.jpg"
          style="height: 350px;margin: 5px 5px 0 0;-webkit-user-drag: none;-khtml-user-drag: none;-moz-user-drag: none;user-drag: none;" />
        <el-divider />
        <el-row>
          <el-col :span="12">
            <div id="main" style="width: 500px; height: 400px"></div>
          </el-col>

          <el-col :span="12">
            <div id="pie" style="width: 500px; height: 400px"></div>
          </el-col>
        </el-row>
      </el-card>
    </div>

  </div>
</template>

<script>

import * as echarts from 'echarts';

export default {
  name: "Home",
  data() {
    return {
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
    }
  },
  mounted() {  

    var option = {
      title: {
        text: 'System Registration Count by Quarter',
        subtext: 'tendency chart',
        left: 'center'
      },

      xAxis: {
        type: 'category',
        data: ["quarter 1", "quarter 2", "quarter 3", "quarter 4"]
      },
      yAxis: {
        type: 'value'
      },
      series: [
        {
          data: [],
          type: 'line'
        },
        {
          data: [],
          type: 'bar'
        }
      ]
    };
    var chartDom = document.getElementById('main');
    var myChart = echarts.init(chartDom);
    this.request.get("/echarts/members").then(res => {
      option.series[0].data = res.data
      option.series[1].data = res.data
      myChart.setOption(option);
    })


    var pieOption = {
      title: {
        text: 'Membership Count by Quarter',
        subtext: 'Proportion Chart',
        left: 'center'
      },
      tooltip: {
        trigger: 'item'
      },
      legend: {
        orient: 'vertical',
        left: 'left'
      },
      series: [
        {
          type: 'pie',
          radius: '60%',
          label: {            
            normal: {
              show: true,
              position: 'inner', 
              textStyle: {
                fontWeight: 300,
                fontSize: 14,    
                color: "#fff"
              },
              formatter: '{d}%'
            }
          },
          data: [],  
          emphasis: {
            itemStyle: {
              shadowBlur: 10,
              shadowOffsetX: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)'
            }
          }
        }
      ]
    };

    var pieDom = document.getElementById('pie');
    var pieChart = echarts.init(pieDom);

    this.request.get("/echarts/members").then(res => {

      pieOption.series[0].data = [
        { name: "quarter 1", value: res.data[0] },
        { name: "quarter 2", value: res.data[1] },
        { name: "quarter 3", value: res.data[2] },
        { name: "quarter 4", value: res.data[3] },
      ]
      pieChart.setOption(pieOption)
    })
  }
}
</script>

<style scoped>
.welcome {
  font-size: 32px;
  color: #1E90FF;
}
</style>
