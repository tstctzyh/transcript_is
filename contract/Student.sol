pragma solidity >=0.4.22 <0.6.0;
pragma experimental ABIEncoderV2;

contract Student {
//   StudentData[] Students;

    struct StudentData {
        address student_address;
        string  student_id;
        string  name;
        string  lastname;
    }

    struct CourseData {
        string  course_id;
        string  course_name;
        uint    credit;
    }

    struct RegisterData{
        uint8   register_id;
        uint    year;
        uint    semester;
        address student_address;
        string  student_id;
        string  name;
        string  lastname;
        string  course_id;
        string  course_name;
        uint     course_credit;
        uint     score;
        string  grade;
        uint    block_number;
        uint    block_time;
    }

    mapping (address=>StudentData) private Students;
    address[] private addressStudents;

    mapping (string=>CourseData) private Courses;
    string[] private courseIdAll;

    mapping (uint8=>RegisterData) private Registers;
    uint8[] private registerIdAll;

    constructor () public{

    }

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

    function getStudents() public view returns (StudentData[] memory){

        StudentData[] memory total_student = new StudentData[](addressStudents.length);
        for (uint i=0; i<addressStudents.length; i++) {
            total_student[i] = Students[addressStudents[i]];
        }

        return total_student;
    }

    function getMyProfile() public view returns (StudentData memory){
        return Students[msg.sender];
    }

    function getStudentsDataByID(string memory std_id) public view returns (StudentData memory){
        bytes memory std_where = bytes(std_id);
        StudentData[] memory total_student = new StudentData[](addressStudents.length);
        StudentData memory student_search;
        for (uint i=0; i<addressStudents.length; i++) {
            total_student[i] = Students[addressStudents[i]];
            bytes memory std_check = bytes(total_student[i].student_id);
            if(keccak256(abi.encodePacked((std_check))) == keccak256(abi.encodePacked((std_where)))){
                student_search = total_student[i];
                return student_search;
            }
        }

        return student_search;

    }


    function addStudent (string memory _name,string memory _lastame ) public checkDuplicate{
        addressStudents.push(msg.sender);
        StudentData storage o = Students[msg.sender];
        o.student_address = msg.sender;
        uint id =addressStudents.length;
        string memory id_str = "";

        id_str=uint2str(id);

        o.student_id = string(abi.encodePacked("STD_",id_str));
        o.name = _name;
        o.lastname = _lastame;
    }

    modifier checkDuplicate() {
        StudentData[] memory total_student = new StudentData[](addressStudents.length);
        for (uint i=0; i<addressStudents.length; i++) {
            total_student[i] = Students[addressStudents[i]];

            if(msg.sender==total_student[i].student_address){
               require(false);
            }
        }

        //move all code thai call this function to _
        _;


    }

    function checkDuplicateCourse(string memory _course_id) internal returns (bool){
        bytes memory course_where = bytes(_course_id);
        CourseData[] memory total_course = new CourseData[](courseIdAll.length);
        for (uint i=0; i<courseIdAll.length; i++) {
            bytes memory course_check = bytes(total_course[i].course_id);
            if(keccak256(abi.encodePacked((course_check))) == keccak256(abi.encodePacked((course_where)))){
                return false;
            }
        }

        return true;
    }

    function addCourse (string memory _course_id,string memory _course_name,uint _credit ) public {
        bool check_dup = checkDuplicateCourse(_course_id);
        require(check_dup);

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
        bytes memory course_where = bytes(coures_id);
        CourseData[] memory total_course = new CourseData[](courseIdAll.length);
        CourseData memory course_search;
        for (uint i=0; i<courseIdAll.length; i++) {
            total_course[i] = Courses[courseIdAll[i]];
            bytes memory course_check = bytes(total_course[i].course_id);
            if(keccak256(abi.encodePacked((course_check))) == keccak256(abi.encodePacked((course_where)))){
                course_search = total_course[i];
                return course_search;
            }
        }

        return course_search;
    }

    function checkCourseRegister(uint _year,uint _semester,string memory _course_id)  internal returns (bool){
        //address student
        address student_address = msg.sender;
        bytes memory course_where = bytes(_course_id);

        RegisterData[] memory total_register = new RegisterData[](registerIdAll.length);
        for (uint i=0; i<registerIdAll.length; i++) {
            total_register[i] = Registers[registerIdAll[i]];
            bytes memory course_check = bytes(_course_id);
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

        uint8 register_id = random();
        registerIdAll.push(register_id);
        RegisterData storage o = Registers[register_id];
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
    }


}
