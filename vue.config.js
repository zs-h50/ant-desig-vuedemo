module.exports = {
	runtimeCompiler: true,
	devServer: {
		port: 9091, //设置本地默认端口
		proxy: { //设置代理
			'/api': { //设置拦截器
				target: 'http://localhost:9090', //代理的目标地址
				changeOrigin: true, //是否设置同源，输入是的
				pathRewrite: { //路径重写
					'/api': '' //选择忽略拦截器里面的单词
				}
			}
		}
	}
}
