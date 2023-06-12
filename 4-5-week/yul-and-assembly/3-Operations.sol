// SPDX-License-Identifier: GLP-3.0
pragma solidity 0.8.16;


// Yul has for loops and if statements
contract IsPrime {
    function isPrime(uint256 x) public pure returns (bool p) {
        p = true;
        assembly {
            let halfX := add(div(x,2), 1)
            for { let i := 2} lt(i, halfX) {i := add(i, 1)}
            {
                if iszero(mod(x,i)) {
                    p := 0
                    break 
                }
            }
        }
    }
    function testPrime() external pure {
        require(isPrime(2));
        require(isPrime(3));
        require(!isPrime(4));
        require(!isPrime(15));
        require(isPrime(23));
        require(isPrime(101));
    }
}

contract IfComparison {
    function isTruthy() external pure returns (uint256 result) {
        result = 2;
        assembly {
            if 2 {
                result := 1
            }
        }
        return result;
    }

    function isFalsy() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if 0 {
                result := 2
            }
        }
        return result;
    }

    function negation() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if iszero(0) {
                result := 2
            }
        }
        return  result;
    }

    function bitFlip() external pure returns (bytes32 result) {
        assembly {
            result := not(2) // 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd
        }
    }
    function unsafeNegation() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if not(0) {
                result := 2
            }
        }
        return result; // returns 2
    }
    function safeNegation() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if iszero(2) {
                result := 2
            }
        }
        return result;
    }
    // there is no else statement, you. have to check for each senario
    function max(uint256 x, uint256 y) external pure returns (uint256 maximum) {
        assembly {
            if lt(x,y) {
                maximum := y
            }
            if iszero(lt(x,y)) {
                maximum := x
            }
        }
    }
    
    // The rest:
    /* 
    |solidity | yul      |
    +---------+----------+
    | a && b  | and(a,b) | 
    | a || b  | or(a,b)  | 
    | a ^ b   | xor(a,b) | 
    | a + b   | add(a,b) | 
    | a - b   | sub(a,b) | 
    | a / b   | div(a,b) | 
    | a % b   | mod(a,b) | 
    | a << b  | shl(a,b) | 
    | a >> b  | shr(a,b) | 
    +---------+----------+
    */
}