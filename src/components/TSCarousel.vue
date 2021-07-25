/**
 * 登录页轮播
 * 走马灯
 **/
<template>
	<!-- autoplay 会自动播发-->
  <a-carousel autoplay class="a-body">
    <img src="../assets/img/1.png" alt />
    <img src="../assets/img/2.png" alt />
    <img src="../assets/img/3.png" alt />
    <img src="../assets/img/4.png" alt />
  </a-carousel>
</template>
<script>
export default {}
</script>
<style scoped>
.a-body {
  width: 100%;
  height: 100%;
  padding: 0px;
  margin: 0px;
}
.a-body img {
  width: 100%;
  height: 100%;
}
.ant-carousel .slick-slider {
  width: 100% !important;
  height: 100% !important;
}
.ant-carousel >>> .slick-slide {
  height: 100%;
  line-height: 100%;
  overflow: hidden;
}
</style>