<template>
  <div>
    <el-row :gutter="10" style="margin-bottom: 60px">
      <el-col :span="6">
        <el-card style="color: #409EFF">
          <div><i class="el-icon-user-solid" /> total user</div>
          <div style="padding: 10px 0; text-align: center; font-weight: bold">
            100
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card style="color: #F56C6C">
          <div><i class="el-icon-money" />total sale</div>
          <div style="padding: 10px 0; text-align: center; font-weight: bold">
            ￥ 1000000
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card style="color: #67C23A">
          <div><i class="el-icon-bank-card" /> total revenue</div>
          <div style="padding: 10px 0; text-align: center; font-weight: bold">
            ￥ 300000
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card style="color: #E6A23C">
          <div><i class="el-icon-s-shop" /> stores</div>
          <div style="padding: 10px 0; text-align: center; font-weight: bold">
            20
          </div>
        </el-card>
      </el-col>
    </el-row>
    <el-row>
      <el-col :span="12">
        <div id="main" style="width: 500px; height: 450px"></div>
      </el-col>

      <el-col :span="12">
        <div id="pie" style="width: 500px; height: 400px"></div>
      </el-col>
    </el-row>

    <el-row style="margin-top: 20px">
      <el-col :span="12">
        <div id="candlestick" style="width: 500px; height: 450px"></div>
      </el-col>
    </el-row>

  </div>
</template>

<script>
import * as echarts from 'echarts'

export default {
  name: "Home",
  data() {
    return {

    }
  },
  mounted() {  
    const option = {
      title: {
        text: 'System Registration Count by Quarter',
        subtext: 'tendency chart',
        left: 'center'
      },
      tooltip: {
        trigger: 'item'
      },
      legend: {
        orient: 'vertical',
        left: 'left'
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
          name: "starbucks",
          data: [],
          type: 'bar'
        },
        {
          name: "starbucks",
          data: [],
          type: 'line'
        },
        {
          name: "espresso house",
          data: [],
          type: 'bar'
        },
        {
          name: "espresso house",
          data: [],
          type: 'line'
        }
      ]
    };


    const pieOption = {
      title: {
        text: 'Membership Count by Quarter',
        subtext: 'Proportion Chart',
        left: 'center'
      },
      tooltip: {
        trigger: 'item',
        formatter: '{a} <br/>{b} : {c} ({d}%)'
      },
      legend: {
        orient: 'vertical',
        left: 'left'
      },
      series: [
        {
          name: "starbucks",
          type: 'pie',
          radius: '55%',
          center: ['25%', '70%'],
          label:{            
            normal:{
              show:true,
              position:'inner', 
              textStyle : {
                fontWeight : 300 ,
                fontSize : 14,    
                color: "#fff"
              },
              formatter:'{c}({d}%)'
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
        },
        {
          name: "espresso house",
          type: 'pie',
          radius: '50%',
          center: ['75%', '50%'],
          label:{            
            normal:{
              show:true,
              position:'inner', 
              textStyle : {
                fontWeight : 300 ,
                fontSize : 14,    
                color: "#fff"
              },
              formatter:'{d}%'
            }
          },
          data: [
            {name: "quarter 1", value: 5},
            {name: "quarter 2", value: 6},
            {name: "quarter 3", value: 7},
            {name: "quarter 4", value: 8}
            ],  
          emphasis: {
            itemStyle: {
              shadowBlur: 10,
              shadowOffsetX: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)'
            }
          }
        }
      ],

    };

    const candlestickOption = {
      title: {text: 'XX stock'},
      xAxis: {
        data: ['2022-1', '2022-2', '2022-3', '2022-4'],
      },
      yAxis: {
        scale: true,
        splitArea: {
          show: true
        }
      },
      legend: {
        bottom: 10,
        left: 'center',
        data: ['Dow-Jones index', 'MA5', 'MA10', 'MA20', 'MA30']
      },
      tooltip: {
        trigger: 'axis',
        axisPointer: {
          type: 'cross'
        }
      },
      dataZoom: {
        show: true,
        type: 'slider',
        startValue: 0,
        endValue: 100
      },
      series: [
        {
          type: 'candlestick',
          data: [
              [22, 23, 21, 19],
              [19, 21, 29, 31],
              [28, 18, 31, 20],
              [30, 27, 38, 18],
          ]
        }
      ]
    }


    var chartDom = document.getElementById('main');
    var myChart = echarts.init(chartDom);

    var pieDom = document.getElementById('pie');
    var pieChart = echarts.init(pieDom);

    var candlestickDom = document.getElementById('candlestick');
    var candlestickChart = echarts.init(candlestickDom);
    candlestickChart.setOption(candlestickOption)

    this.request.get("/echarts/members").then(res => {
      option.series[0].data = res.data
      option.series[1].data = res.data

      option.series[2].data = [5,6,7,8]
      option.series[3].data = [5,6,7,8]
      myChart.setOption(option);


      pieOption.series[0].data = [
        {name: "quarter 1", value: res.data[0]},
        {name: "quarter 2", value: res.data[1]},
        {name: "quarter 3", value: res.data[2]},
        {name: "quarter 4", value: res.data[3]},
      ]
      pieChart.setOption(pieOption)
    })
  }
}
</script>

<style scoped>

</style>
