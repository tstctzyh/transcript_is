pragma solidity >=0.4.22 <0.6.0;
pragma experimental ABIEncoderV2;

contract CourseFactory{
    // address[] public registerStudent;
    Course[] public courses;
    
    function createCourse(string memory courseid, string memory coursename,int credit) public {
       Course newCourse = new Course(msg.sender,courseid,coursename,credit);
       courses.push(newCourse);
    }
    
    function getCourses() public view returns(Course[] memory) {
        return courses;
    }
}

contract Course {

    struct CourseData {
        address create_by; 
        string  courseid;
        string  coursename;
        int  credit;
    }
    
    CourseData[] public coursedatas;
    
    address private _creator;
    string private _courseid;
    string private _coursename;
    int private _credit;

    constructor (address creator,string memory courseid, string memory coursename,int credit) public{
        _creator=creator;
        _courseid=courseid;
        _coursename=coursename;
        _credit=credit;
        addCourse(_creator,_courseid,_coursename,_credit);
    }
    
    function getCourse() public view returns(CourseData[] memory ){
        return coursedatas;
    }
    
    function addCourse (address creator,string memory _course_id,string memory _coursename,int _credit ) public {

        CourseData memory newCourseData = CourseData({
            create_by : creator,
            courseid: _course_id,
            coursename:_coursename,
            credit:_credit
        });
        
        coursedatas.push(newCourseData);
    }

}
