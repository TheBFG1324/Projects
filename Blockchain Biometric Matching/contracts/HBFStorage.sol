pragma solidity ^0.8.0;

contract HBFStorage{

    struct bitStream{
        uint256 first;
        uint256 middle;
        uint256 last;
    }

    address public owner;
    bool public HBFInitialized = false;
    uint public constant sections = 16;
    mapping(uint=>bitStream) public HBF;
    uint public threshold;

    constructor(uint _threshold){
        owner = msg.sender;
        threshold = _threshold;
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    modifier HBFIsInitialized{
        require(HBFInitialized, "HBF has not been initialized yet");
        _;
    }


    function initializeHBF()public onlyOwner returns(bool){
        require(!HBFInitialized, "HBF is already initialized");
        for(uint i = 0; i < sections; i++){
            bitStream memory newBitStream;
            HBF[i] = newBitStream;
        }
        HBFInitialized = true;
        return true;
    }

    function enrollPerson(uint256[3*sections] memory indexes) public onlyOwner HBFIsInitialized returns(bool){
        require(indexes.length == 3*sections, "Invalid indexes length");

        for(uint i = 0; i < sections; i++){
            // Extract the three indexes for the current section
            uint256 index1 = indexes[3*i];
            uint256 index2 = indexes[3*i + 1];
            uint256 index3 = indexes[3*i + 2];

            // Ensure each index is within the valid range of 0 to 767
            require(index1 < 768 && index2 < 768 && index3 < 768, "Index out of bounds");

            // Update the bits in the bitStream for each index
            updateBitInBitStream(i, index1);
            updateBitInBitStream(i, index2);
            updateBitInBitStream(i, index3);
        }

        return true;
}

    function updateBitInBitStream(uint section, uint256 index) internal {
    // Determine which part of the bitStream to update
        uint256 part = index / 256; // Will be 0 for first, 1 for middle, 2 for last
        uint256 bitPosition = index % 256; // Position of the bit within the 256-bit segment

    // Update the correct part of the bitStream
        if(part == 0){
            HBF[section].first |= (1 << bitPosition);
        } else if(part == 1){
            HBF[section].middle |= (1 << bitPosition);
        } else if(part == 2){
            HBF[section].last |= (1 << bitPosition);
        }
    }

    function queryBitInBitStream(uint256 section, uint256 index) internal view returns(uint256){
        uint256 part = index / 256; // Will be 0 for first, 1 for middle, 2 for last
        uint256 bitPosition = index % 256; // Position of the bit within the 256-bit segment

        // Check the correct part of the bitStream
        if(part == 0){
            if((HBF[section].first & (1 << bitPosition)) != 0){
                return 1;
            }
        } else if(part == 1){
            if((HBF[section].middle & (1 << bitPosition)) != 0){
                return 1;
            }
        } else if(part == 2){
            if((HBF[section].last & (1 << bitPosition)) != 0){
                return 1;
            }
        }
        return 0;
    }


    function queryPerson(uint256[3*sections] memory indexes) public view HBFIsInitialized returns(bool){
        require(indexes.length == 3*sections, "Invalid indexes length");
        uint256 counter = 0;

        for(uint i = 0; i < sections; i++){
            // Extract the three indexes for the current section
            uint256 index1 = indexes[3*i];
            uint256 index2 = indexes[3*i + 1];
            uint256 index3 = indexes[3*i + 2];

            // Ensure each index is within the valid range of 0 to 767
            require(index1 < 768 && index2 < 768 && index3 < 768, "Index out of bounds");

            // Update the bits in the bitStream for each index
            counter += queryBitInBitStream(i, index1) + queryBitInBitStream(i, index2) + queryBitInBitStream(i, index3);
        }
        if(counter >= threshold){
          return true;  
        }
        return false;
    }

}