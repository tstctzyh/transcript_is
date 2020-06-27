const routes = require('next-routes')()

routes
    .add('/student/create','/student/create')
    .add('/student/:address','/student/show')
    .add('/student/:address/add_course','/student/add_course')

module.exports=routes