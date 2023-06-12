// SPDX-License-Identifier: GLP-3.0
pragma solidity 0.8.16;

contract Memory {
    struct Point {
        uint256 x;
        uint256 y;
    }
    event MemoryPointer(bytes32);
    event MemoryPointer(bytes32, bytes32);

    function highAccess() external pure {
        assembly {
            pop(mload(0xffffffffffffffff))
        }
    }
}