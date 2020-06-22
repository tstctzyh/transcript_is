pragma solidity >=0.4.22 <0.6.0;
pragma experimental ABIEncoderV2;

contract StudentFactory{
    // address[] public registerStudent;
    Student[] public registerStudent;
    
    function createStudent(string memory firstname, string memory lastname) public {
       Student newStudent = new Student(msg.sender,firstname,lastname);
       registerStudent.push(newStudent);
    }
    
    function getStudent() public view returns(Student[] memory) {
        return registerStudent;
    }
}

contract Student {
//   StudentData[] Students;

    struct StudentData {
        address student_address; 
        string  name;
        string  lastname;
    }
    
    struct RegisterData{
        uint    year;
        uint    semester;
        address student_address;
        string  name;
        string  lastname;
        string  course_id;
        uint    score;
        string  grade;
    }
    
    StudentData[] public studentdatas;
    
    RegisterData[] public registerdatas;
    
    address private _creator;
    string private _name;
    string private _lastname;

    constructor (address creator,string memory name,string memory lastname) public{
        _creator=creator;
        _name=name;
        _lastname=lastname;
        addStudent(_creator,_name,_lastname);
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
    
    function getStudent() public view returns(StudentData[] memory ){
        return studentdatas;
    }
    

    function addStudent (address creator,string memory _name,string memory _lastame ) public {
    //   if(studentdatas.length>0){
    //       require(false);
    //   }
        
        StudentData memory newStudentData = StudentData({
            student_address : creator,
            name: _name,
            lastname:_lastname
        });
        
        studentdatas.push(newStudentData);
    }
    
    
    function registerScore (uint _year,uint _semester,string memory _course_id,uint _score,string memory _grade) public {
        

        RegisterData memory newRegisterData = RegisterData({
            year : _year,
            semester: _semester,
            student_address:_creator,
            name: _name,
            lastname:_lastname,
            course_id:_course_id,
            score: _score,
            grade: _grade
        });
        
        registerdatas.push(newRegisterData);
    }
    
    function getMyScore() public view returns(RegisterData[] memory ){
        return registerdatas;
    }
    

}
