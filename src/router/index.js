import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../views/Login.vue'
import Indexs from '../views/student/indexs.vue'
import UserList from '../components/student/UserList.vue'
import Welcome from '../components/Welcome.vue'
import ScoreList from '../components/student/ScoreList.vue'
import TeamList from '../components/student/TeamList.vue'
import TeacherList from '../components/student/TeacherList.vue'
import Index from '../views/teacher/index.vue'
import Retrieve from '../views/Retrieve.vue'
import Myself from '../components/teacher/Myself.vue'
import Score from '../components/teacher/Score.vue'
import Course from '../components/teacher/Course.vue'
import Admin from '../views/admin/admin.vue'
import Operate from '../components/admin/Operate.vue'
import StudentInformation from '../components/admin/StudentInformation.vue'
import House from '../components/admin/House.vue'
import Teacher from '../components/admin/Teacher.vue'
import Courses from '../components/admin/Course.vue'
import Exam from '../components/admin/Exam.vue'
import Fclass from '../components/admin/Fclass.vue'
import Updataps from '../components/teacher/Updataps.vue'
Vue.use(VueRouter)

//解决重复重定向问题
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}

const routes = [
  {
    path: '/',
    name: '登录页',
    component: Login
  },
  {
    path: '/retrieve',
    name: '找回密码页',
    component: Retrieve
  },
  {
    path: '/indexs',
    name: '学生首页',
    component: Indexs,
	children:[	//子路由,嵌套路由
		{path:'welcome',name: '欢迎页面',component: Welcome},
		{path:'userlist',name: '操作1',component: UserList},
		{path:'scorelist',name: '操作2',component: ScoreList},
		{path:'teamlist',name: '操作3',component: TeamList},
		{path:'teacherlist',name: '操作4',component: TeacherList},
	]
  },
  {
	path:'/index',
	name:'老师首页',
	component:Index,
	children:[
		{path:'welcome',name: '老师端欢迎页面',component: Welcome},
		{path:'myself',name:'老师个人信息',component:Myself},
		{path:'score',name:'成绩',component:Score},
		{path:'course',name:'课程',component:Course},
		{path:'upteacher',nane:'修改密码',component:Updataps}
		
	]
  },
  {
	  path:'/admin',
	  name:'管理员首页',
	  component:Admin,
	  children:[
		  {path:'welcome',name: '管理员欢迎页面',component: Welcome},
		  {path:'operate' ,name:'操作',component:Operate},
		  {path:'studentinfo',name:'学生个人信息',component:StudentInformation},
		  {path:'house',name:'学生家庭信息',component:House},
		  {path:'teacher',name:'老师个人信息',component:Teacher},
		  {path:'courses',name:'课程信息',component:Courses},
		  {path:'exam',name:'成绩信息',component:Exam},
		  {path:'fclass',name:'班级信息',component:Fclass}		  
	  ]
  }
]

const router = new VueRouter({
  routes
})

export default router
