// SPDX-License-Identifier: Unlicensed 
pragma solidity ^0.8.0;

/*
Author: Cameron Denton
Date Created: 2/20/23
Last Modified: 2/21/23
Inputs: Personal Mapping ID, Hash of Biometric Template, Address to attach to template.
Outputs: Addresses that matches "rounded" templates hash.
Purpose: Serve as a Template Matching Contract that takes the Personal Mapping ID that is attached to a Company's/Coporation
/Goverment Agency template database, recieves the hash of the "rounded" template and searches the personal database
to find all addresses that match that hash. If queried with two "rounded" templates you can get the intersection of the two
arrays to find optimally one identity. 
*/

contract BiometricMatching{

    //Shishir, This information Can contain any information that the template match wants to hold
    struct person{
        string name;
        uint id;

        
    }
    //Input Organization template database ID->Input templates hash->Output the address array of all matches to the template
    mapping(uint256=>mapping(bytes32=>address[])) private BiometricMapping;

    //Input Organization template database ID-> the Owner address of the database that is allowed to update database
    mapping(uint256=>address) private Owners;

    //Shishir, this will be the mapping that when the Account from the templates is handed back, this will give us whatever personal
    //data we want
    mapping(address=>person)private PersonalData;

    //Creates a modifier that confirms if the caller of the function is the Owner of the Organization Template database
    //This insures that the authority editing the database is valid
    modifier isOwnerOfBiometricMap(uint256 _id){
        address owner= Owners[_id];
        require(msg.sender==owner);
        _;
    }

    //Helper function that returns tuple. If the value is in the array it returns the index and true, Otherwise it 
    //returns 0 and false
    function indexOf(address[] memory A, address a) internal pure returns (uint256, bool) {
        for (uint256 i = 0; i < A.length; i++) {
        if (A[i] == a) {
            return (i, true);
        }
    }
    return (0, false);
    }

    //Helper function that uses the function indexOf and returns the bool value of if the value is in the array
    function contains(address[] memory A, address a) internal pure returns (bool) {
        (, bool isIn) = indexOf(A, a);
        return isIn;
    }

    //This Creates a Biometric ID for an Organization
    function createBiometricMappingID(uint256 _id) public returns(bool){
        require(Owners[_id]==address(0), "This ID is Already Taken");
        Owners[_id]=msg.sender;
        return(true);
    }
    //Inserts a template hash with attached persons identity into its respective database 
    function insert(uint256 _id, bytes32 _hash, address _person) public isOwnerOfBiometricMap(_id) returns(bool){
        address[] storage mappingArray= BiometricMapping[_id][_hash];
        uint256 arrayLength=mappingArray.length;
        mappingArray.push(_person);
        uint256 arrayLength_end=mappingArray.length;
        require(arrayLength<arrayLength_end, "The person was not added");
        return true;
    }
    //Deletes identity from template identity hash
    function deletePerson(uint256 _id, bytes32 _hash, address _person) public isOwnerOfBiometricMap(_id) returns(bool){
        require(BiometricMapping[_id][_hash].length!=0, "Template does not Exsist");
        address[] memory array=BiometricMapping[_id][_hash];
        require(contains(array, _person), "Item being deleted does not exist");
        uint256 index=0;
        for(uint256 i=0; i<array.length;i++){
            if(array[i]==_person){
                index=i;
            }
        }
        uint j=0;
        address[] memory updatedArray= new address[](array.length-1);
        for(uint x=0;x<array.length;x++){
            if(array[x]!=array[index]){
                updatedArray[j]=array[x];
                j++;
            }
        }
        BiometricMapping[_id][_hash]=updatedArray;

        return true;

    }
    //Returns the array of identities associated with hashed template
    function query(uint256 _id, bytes32 _hash)public view returns(address[] memory){
        address[] storage mappingArray=BiometricMapping[_id][_hash];
        return mappingArray;

    }
    //returns intersection of two hashed template arrays
    function queryTwoTemplates(uint256 _id, bytes32 _hash1, bytes32 _hash2) public view returns (address[] memory) {
        address[] memory mappingArray1=BiometricMapping[_id][_hash1];
        address[] memory mappingArray2=BiometricMapping[_id][_hash2];
        uint256 length = mappingArray1.length;
        uint256 length2=mappingArray2.length;
        
        if(length==0 || length2==0){
            address[] memory _null= new address[](0);
            return _null;
        }
        
    
        if(length<length2){
            bool[] memory includeMap = new bool[](length);
            uint256 newLength=0;
            for (uint256 i=0; i < length; i++) {
                if (contains(mappingArray2, mappingArray1[i])) {
                    includeMap[i] = true;
                    newLength++;
                }
            }
            address[] memory intersection = new address[](newLength);
            uint256 j=0;
            for (uint256 i=0; i < length; i++) {
                if (includeMap[i]) {
                    intersection[j] = mappingArray1[i];
                    j++;
                }
            }
            return intersection;


        } else{
            bool[] memory includeMap=new bool[](length2);
            uint256 newLength=0;
            for(uint256 i=0; i<length2;i++){
                if(contains(mappingArray1, mappingArray2[i])){
                    includeMap[i]=true;
                    newLength++;
                }
            }
            address[] memory intersection=new address[](newLength);
            uint256 j=0;
            for(uint256 i=0; i<length2; i++){
                if(includeMap[i]){
                    intersection[j]=mappingArray2[i];
                    j++;
                }
            }
            return intersection;
        }
        
    }
    //Sets identity to account that is tied to hashed template
    function createPerson(uint256 _id, bytes32 _hash, address _person, string memory name, uint personalID)public isOwnerOfBiometricMap(_id) returns(bool){

    }
}