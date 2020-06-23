const routes = require('next-routes')()

routes
    .add('/student/create','/student/create')
    .add('/student/:address','/student/show')

module.exports=routes