pragma solidity >=0.4.22 <0.6.0;
pragma experimental ABIEncoderV2;

contract Student {

    struct StudentData {
        address student_address;
        string  student_id;
        string  name;
        string  lastname;
        uint    num_register;
    }

    struct CourseData {
        string  course_id;
        string  course_name;
        uint    credit;
    }

    struct CourseRegister{
        uint    year;
        uint    semester;
        address student_address;
        string  course_id;
    }

    struct RegisterData{
        uint    year;
        uint    semester;
        address student_address;
        string  student_id;
        string  name;
        string  lastname;
        string  course_id;
        string  course_name;
        uint    course_credit;
        uint    score;
        string  grade;
        uint    block_number;
        uint    block_time;
    }

    mapping (address=>StudentData) public Students;
    mapping (address=>bool) private StudentsCheck;

    address[] private addressStudents;

    mapping (string=>CourseData) private Courses;
    mapping (string=>bool) private CoursesCheck;
    string[] private courseIdAll;

    mapping (string=>CourseRegister) private CourseRegisters;
    string[] private RegisterKey;

    mapping (uint=>RegisterData) private Registers;

    uint[] private registerIdAll;

    // constructor () public{

    // }

    function random() private view returns (uint8) {
        return uint8(uint256(keccak256(abi.encodePacked((block.timestamp)))))%251;
    }

    function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }

    function getMyProfile() public view returns (StudentData memory){
        StudentData memory student_data;
        student_data=Students[msg.sender];

        return student_data;

    }

    modifier checkDuplicate() {
        if(StudentsCheck[msg.sender]==true){
               require(false);
        }

        //move all code thai call this function to _
        _;


    }

    function addStudent (string memory _name,string memory _lastame ) public checkDuplicate{
        addressStudents.push(msg.sender);

        StudentsCheck[msg.sender]=true;

        StudentData storage o = Students[msg.sender];
        o.student_address = msg.sender;
        uint id =addressStudents.length;
        string memory id_str = "";

        id_str=uint2str(id);

        o.student_id = string(abi.encodePacked("STD_",id_str));
        o.name = _name;
        o.lastname = _lastame;
        o.num_register=0;
    }

    function checkDuplicateCourse(string memory _course_id) internal returns (bool){
       return CoursesCheck[_course_id];
    }

    function addCourse (string memory _course_id,string memory _course_name,uint _credit ) public {
        bool check_dup = checkDuplicateCourse(_course_id);
        require(!check_dup);

        CoursesCheck[_course_id]=true;

        courseIdAll.push(_course_id);
        CourseData storage o = Courses[_course_id];
        o.course_id = _course_id;
        o.course_name = _course_name;
        o.credit = _credit;

    }

     function getCourses() public view returns (CourseData[] memory){

        CourseData[] memory total_course = new CourseData[](courseIdAll.length);
        for (uint i=0; i<courseIdAll.length; i++) {
            total_course[i] = Courses[courseIdAll[i]];
        }

        return total_course;
    }


    function getCourseByCourseID(string memory coures_id) public view returns (CourseData memory){
        CourseData memory course_search;
        course_search=Courses[coures_id];

        return course_search;

    }

    function checkCourseRegister(uint _year,uint _semester,string memory _course_id)  internal returns (bool){
        //address student
        address student_address = msg.sender;
        bytes memory course_where = bytes(_course_id);

        RegisterData[] memory total_register = new RegisterData[](registerIdAll.length);
        for (uint i=0; i<registerIdAll.length; i++) {
            total_register[i] = Registers[registerIdAll[i]];
            bytes memory course_check = bytes(total_register[i].course_id);
            if(
                keccak256(abi.encodePacked((course_check))) == keccak256(abi.encodePacked((course_where))) &&
                total_register[i].student_address == student_address &&
                total_register[i].year == _year &&
                total_register[i].semester == _semester
            ){
                return true;
            }
        }

        return false;

    }

    function courseRegister(uint _year,uint _semester,string memory _course_id) public {
        StudentData memory myprofile = getMyProfile();
        CourseData memory course_select= getCourseByCourseID(_course_id);

        bool stat_register = checkCourseRegister(_year,_semester,_course_id);
        if(stat_register==true){
            require(false);
        }

        registerIdAll.push(block.number);
        RegisterData storage o = Registers[block.number];
        o.year=_year;
        o.semester=_semester;
        o.student_address=msg.sender;
        o.student_id=myprofile.student_id;
        o.name=myprofile.name;
        o.lastname=myprofile.lastname;
        o.course_id = course_select.course_id;
        o.course_name = course_select.course_name;
        o.course_credit = course_select.credit;
        o.score=0;
        o.grade="-";
        o.block_number=block.number;
        o.block_time=block.timestamp;

        StudentData storage p = Students[msg.sender];
        p.num_register=p.num_register+1;
    }

    function getCourseRegister() public view returns (RegisterData[] memory) {

        // RegisterData memory regis;
        // regis = Registers[msg.sender];
        StudentData memory myprofile = getMyProfile();

        RegisterData[] memory total_register = new RegisterData[](myprofile.num_register);
        uint num_regis = myprofile.num_register;
        uint k=0;
        for (uint i=0; i<registerIdAll.length; i++) {
            RegisterData memory regis_chk = Registers[registerIdAll[i]];
            if(regis_chk.student_address==msg.sender && k<num_regis){
                total_register[k]=regis_chk;
                k++;
            }
        }

        return total_register;
    }

    function deleteCourseRegister(uint _year,uint _semester,string memory _course_id) public {
        bytes memory course_id_where = bytes(_course_id);
        // delete myRegister;
        for (uint i=0; i<registerIdAll.length; i++) {
            bytes memory course_check = bytes(Registers[i].course_id);
            if(_year==Registers[i].year
            && Registers[i].semester==_semester
            && keccak256(abi.encodePacked((course_check))) == keccak256(abi.encodePacked((course_id_where)))
            && Registers[i].student_address==msg.sender){
              delete Registers[i];
            }
        }

    }
}
