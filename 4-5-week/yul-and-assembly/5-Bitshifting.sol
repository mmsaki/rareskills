// SPDX-License-Identifier: GLP-3.0
pragma solidity 0.8.16;

contract StorageBasics {
    uint128 public C = 4;
    uint96 public D = 6;
    uint16 public E = 8;
    uint8 public F = 1;

    function readBySlot(uint256 slot) external view returns (bytes32 value) {
        assembly {
            value := sload(slot)
        }
    }

    function getOffset() external pure returns (uint256 slot, uint256 offset) {
        assembly {
            slot := E.slot // 0  sload(0) = 0x0001000800000000000000000000000600000000000000000000000000000004
            offset := E.offset // 28 we must shift 28 bytes to the left
        }  
    }

    function readE() external view returns (uint256 e) {
        assembly {
            let value := sload(E.slot)
            // E.slot is 28 bytes
            // shr takes bits, not bytes, so we need to multiply by 8
            let shifted := shr(mul(E.offset, 8), value) 
            // 0x00010008 = 0x0000000000000000000000000000000000000000000000000000000000010008
            // 0xffffffff = 0x000000000000000000000000000000000000000000000000000000000000ffff
            e := and(0xffff, shifted)
        }
    }

    // you can also use division or multiplication to shift
    function readEalt() external view returns (uint256 e) {
        assembly {
            let slot := sload(E.slot)
            let offset := sload(E.offset)
            let value := sload(E.slot)

            // e.g division 0x5500 / 0x10 => 0x550
            // shift right by 224 = divide by 2 **224, below is 2**224 in hex
            let shifted := div(value, 0x100000000000000000000000000000000000000000000000000000000)
            e := and(0xffff, shifted)
        }
    }

    // masks can be =hardcoded because variable storage slot and offsets are fixed
    // V and 00 = 00
    // V or 00 = V
    // function arguments are always 32 bytes long under the hood
    function writeToE(uint16 newE) external {
        // 1. delete the value at offset
        // 2. creating a new value at offset
        // 3. or the value at two offsets
        // 4. setting slot to new value

        assembly {
            let c := sload(E.slot)
            let clearedE := and(c, 0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
            // mask       = 0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff
            // c          = 0x0001000800000000000000000000000600000000000000000000000000000004
            // cleardE    = 0x0001000000000000000000000000000600000000000000000000000000000004
            let shiftedNewE := shl(mul(E.offset, 8), newE)
            // newE       = 0x000000000000000000000000000000000000000000000000000000000000000a
            // shifedNewE = 0x0000000a00000000000000000000000000000000000000000000000000000000
            let newVal := or(shiftedNewE, clearedE)
            // newVal    = 0x0001000a00000000000000000000000600000000000000000000000000000004
            sstore(C.slot, newVal)
        }
    }
 }
