// SPDX-License-Identifier: GLP-3.0
pragma solidity 0.8.16;

// 1. yul has only one type, bytes32

contract YulTypes {
    function getNumber() external pure returns (uint256) {
        uint256 x;
        assembly {
            x := 42
        }
        return x;
    }

    function getX() external pure returns (uint256) {
        uint256 x;
        assembly {
            x := 0xa
        }
        return x;
    }   

    // 1. Strings are not naturaly bytes32
    // 2. You can'n do this
    //    string memory mySrting = "";
    //    assembly { myString = "Hello World" } 
    // 3. You cant assign a string to a memory pointer
    // 4. To it correctly you need to use bytes32, memory is accessed with bytes32
    function getString() external pure returns (string memory) {
        bytes32 myString = '';
        assembly {
            myString := "Hello World" // this assumes values has only fit 32 bytes
        }
        // return myString; // uncomment to use `returns (bytes32)`
        return string(abi.encode(myString)); // this `returns (string memory)`
    }
}