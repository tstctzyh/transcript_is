pragma solidity >=0.4.22 <0.6.0;
pragma experimental ABIEncoderV2;

contract Student {
//   StudentData[] Students;

  struct StudentData {
      address student_address;
      string  student_id;
      string  name;
      string  lastname;
    //   bytes32  birth_date;
    //   bytes32  email;
    //   bytes32  home_address;
    //   bytes32  level;
    //   bytes32  school;
    //   bytes32  major;
    //   bytes32  admid_date;
    //   bytes32  status;
  }



  mapping (address=>StudentData) private Students;
  address[] private addressStudents;

  constructor () public{

  }

  function testSlice() public view returns (address){
    //   address cur_address = msg.sender;
      address a = address(msg.sender);

      return a;

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
            }
        }

        return student_search;

    }


    function setStudent (string memory _name,string memory _lastame ) public checkDuplicate{
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

}
