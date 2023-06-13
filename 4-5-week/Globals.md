# Units and global variables

1. Ether units: `1 wei == 1`, `1 gwei == 1e9`, `1 ether == 1e18`, finney and szabo have been removed since `0.7.0`
1. Time units: `1 == 1 seconds`, `1 minutes == 60 seconds`, `1 hour ==  60 minutes`, `1 days == 24 hours`, `1 weeks == 7days`

   > `years` was removed in 0.5.0

   > **Note**: Due to the fact that leap seconds cannot be predicted, an exact calendar library has to be updated by an oracle

1. Special variables and functions. Block and Transaction properties

   1. `blockhash(uint blocknumner) returns (bytes32)` - hash of the given block when blocknumber is one of 256 most recent blocks, otherwise returns zero
   1. `block.basefee` - uint
   1. `block.chainid` - uint
   1. `block.coinbase` - address payable current block miner's address
   1. `block.difficulty` - uint (EVM < Paris)
   1. `block.gaslimit` - uint
   1. `block.number` - uint
   1. `block.prevrandao` - uint (EVM >= Paris)
   1. `block.timestamp` - uint
   1. `gasleft()` - returns (uint256)
   1. `msg.data` - (bytes calldata)
   1. `msg.sender` - address
   1. `msg.sig` - bytes4, first four bytes of calldata i.e function identifier
   1. `msg.value` - uint wei sent with message
   1. `tx.gasprice` - uint gas price of the transaction
   1. `tx.origin` - address

      > **Note**: don't rely on `block.*` and `tx.*` for contracts evaluated off-chain, the valuse depend on the EVM executing te contracts

      > **Note**: All members of `mgs.*`, can change for every external functioncall, this includes calls to library functions

      > **Note**: Don't rely on `block.timestamp` or `blockhash` for randomness, both can be influenced by miner's to some degree. Current block timestamp must be strickly larger than of the last block, but the only guarantee is that it will be somewhere between the timestamps of two xonsecutive bocks in the cannonical chain

      > **Note**: blockhashes are not available for all blocks for scalability reasons, only have access to the most recent 256 blocks, all other values will be zero

      > **Note**: The function `blockhash` was previously `block.blockhash` which deprecated in 0.4.22 and removed in 0.5.0

      > **Note**: Function `gasleft()` was previously `msg.gas`, which was depricated in 0.4.21 and removed in 0.5.0

      > **Note**: In version 0.7.0, the alias `now` for `block.timestamp` was removed

1. ABI Encoding and Decoding functions

   1. `abi.decode(bytes memory encodedData, (...)) returns (..)`

      > decodes given data, while the types are give in parentheses as second argument Example: (uint a, uint[2] memory b, bytes memory c) = abi.decode(data, (uint, uint[2], bytes))

   1. `abi.encode(...) returns (bytes memory)`

      > abi encodes the give arguments

   1. `abi.encodePacked(...) returns (bytes memory)`

      > performs packed encoding of given arguments, note packed encoding can be ambiguous

   1. `abi.encodeWithSelector(bytes4 selector, ...) returns (bytes memory)`

      > Encodes the given arguments starting from the second and prepends the given four-byte selector

   1. `abi.encodeWithSignature(string memory signature, ...) returns (bytes memory)`

      > equivalent to `abi.encodeWithSelector(bytes4(keccak256(bytes(signature))))`

   1. - `abi.encodeCall(function functionPointer, (..)) returns (bytes memory)`

        > abi encodes a call to `functionPointer` with the arguments found in the tuple. Performs a full type-check, ensuring the types match the function signature. Result equals `abi.encodeWithSelector(functionPointer.selector, (...))`

      > **Note**: These encodings can be used to craft data for external functions calls, without actually calling an external function. Furthermore, `keccak256(abi.encodePacked(a,b))` is a way to compute the hash of a structured data (although be aware that it is possible to craft a "Hashing collision" using different function parameter types).

      > See documentation about [abi](https://docs.soliditylang.org/en/latest/abi-spec.html#abi) and [tightly packed encoding](https://docs.soliditylang.org/en/latest/abi-spec.html#abi-packed-mode)

1. Members of bytes
   1. `bytes.concat(...) returns (bytes memory)`
      > concatenates variable number of bytes and bytes1, ..., bytes32 arguments to one byte array
1. Members is strings
   1. `string.concat(...) returns (string memory)`
      > concatenates variabe number of string arguments to on string array
1. Error Handling

   > See the dedicated section on [assert and require](https://docs.soliditylang.org/en/latest/control-structures.html#assert-and-require)

   1. `assert(bool condition)`

      > Causes a panic error and thus state change reversion if the condition is not met - to be used for internal errors

   1. `require(bool condition, string memory message)` or `require(bool condition)`

      > reverts if the condition is not met - used for inputs or external components

   1. `revert()` or `revert(string memory message)`

      > abort execution and revert state changes

1. Mathematical and Cryptographic functions

   1. `addmod(uint x, uint y, uint k) returns (uint)`
      > compute `(x + y) % k`, condition is performed with arbitrary precision and does not wrap around at $2^{256}$. Assert that `k != 0` starting version 0.5.0
   1. `mulmod(uint x, uinty, uint k) returns (uint)`
      > compute `(x * y) % k`
   1. `keccak256(bytes memory) returns (bytes32)`

      > compute the keccak256 hash of the input

      > **Note**: There used to be an alias `keccak256` called `sha3`, which was removed in version 0.5.0

   1. `sha256(bytes memory) returns (bytes32)`
   1. `ripemd160(bytes memory) returns (bytes20)`

      > compute thr RIPEMD-160 hash of the input

   1. `ecrecover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) returns (address)`

      > recover the address associated with the public key from elliptic curve signature or return on error. Teh function parameters correspind to ECDSA values of the signature

      - `r` - first 32 bytes of signature
      - `s` - second 32 bytes of signature
      - `v` - final 1 byte of signature

        > `ecrecover` returns an `address`, and not an `address payable`. See [`address payable`](https://docs.soliditylang.org/en/latest/types.html#address) for conversion, incase you need to transfer funds to the recovered address. Further, read [example usage](https://ethereum.stackexchange.com/questions/1777/workflow-on-signing-a-string-with-private-key-followed-by-signature-verificatio)

      > **Warning**: if you use `ecrecover`, be aware that a valid signature can be turned into a different valid signature without requiring knowledge of the corresponding private key. In the Homestead hard fork, this issue was fixed for _transaction_ signatures see [EIP-2](https://eips.ethereum.org/EIPS/eip-2#specification)

      > Not usually a problem unless you require signatures to be unique or use them to identify items. OpenZeppelin has an [ECDSA helper library](https://docs.openzeppelin.com/contracts/4.x/api/utils#ECDSA) that you can use as a wrapper for ecrecover, without this issue

      > **Note**: When running `sha256`, `ripemd160` or `ecrecover` on a private blockchain, you might encoutre Out-of-Gas. This is because these function are implemented as "precompiled contracts" and only really exist after they receive the first message (although their contract code is hardcoded). Messages to non-existing contracts are more expensive and this the execution might run into an out-of-gas error. A workaround for this problem is to first send Wei (1 for example) to each of the contracts before you use them in your actual contracts. This is not an issue on the main or test net.

1. Members of Address types

   1. `address.balance` - uint26,
   1. `address.code` - bytes memory, code at the Address can be empty
   1. `address.codehash` - bytes32
   1. `address-payable.transfer(uint26 amount)`

      > reverts on failure, forwards 2300 gas stipend - not adjustable

   1. `address-payable.send(uint256 amount) returns (bool)`

      > returns `false` on failure, forwards 2300 gas - not adjustable

   1. `address.call(bytes memory) returns (bool, bytes memory)`

      > issue low-level `CALL` with the given payload, returns success condition and return data, forwards all available gas, adjustable

   1. `address.delegatecall(bytes memory) returns (bool, bytes memory)`

      > issue lol-level `DELEGATECALL` with the given payload, returns success condition and return data, forwards all available gas, adjustable

   1. `address.staticcall(bytes memory) returns (bool, bytes memory)`

      > issue low-level `STATICCALL` with the given payload, returns success condition, and return data, forwards all available gas, adjustable

   > **Warning**: You should avoid using `.call()` whenever possible when executing another contract function as it bypasses type checking, function existense check, and argument packing

   > **Warning**: the are some dangers with `send`. The transfer fails if the call stack depth is 1024 (this can always be forced byt the caller) and it also fails if the recipient runs out of gas. So in order to make safe Ether transfers, always check the return value of `send`, use `transfer` of even better: use a pattern where the recipent withdraws the ether.

   > **Warning**: Due to the fact that the EVM considers a call to a non-existing contract to always succeed, Solidity includes an extra check using the `extcodesize` opcode when performing external calls. This ensures that the contract exists of an exception is raised. The low level calls `.call()`, `.delegatecall()`, `.staticcall()`, `.send()` and `.transfer()` do not include this check, ehich makes them cheaper in terms of gas but also less safe

   > **Note**: prior to 0.5.0 this.balance now forbidden use address(this).balance

   > **Note**: if state variables are accessed via a low level delegatecall, the storage layout of the two contracts must align in order for the called contract to correctly access the storage variables of the calling contract by name. This is of course not the case if storage pointer are passed as function arguments as in the case for the high-level libraries

   > **Note**: prior to 0.5.0 `.call`, `.delegatecall` and `.staticcall` on returned the success condition and not the return data

1. Contract related

   1. `this`

      > the current contract, explicitly convertible to Address

   1. `super`

      > A contract one level higher in the inheritance hierarchy

   1. `selfdestruct(address payable receipient)`

      > Destroy the current contract, sending its funds to the given addrss, and end execution. `selfdestruct` has many peculiarities inherited from the EVM: a.) the receiving contract's receive function is not executed b.) the contract is only really destroyed at the end of the transaction and `reverts` might undo the destruction

   > **Note**: All functions of the current contract are callable directly including the current function.

   > **Warning**: From 0.8.18 and up, the use of `selfdestruct` in both solidity and Yul will trigger a deprecation warning, since `SELFDESTRUCT` opcode will eventually undergo breaking changes in behavior as stated in [EIP-6049](https://eips.ethereum.org/EIPS/eip-6049)

1. Type Information

   > The expression `type(x)` can be used to retrieve information about the type of `x`. Currently, there is limited support for this feature (`X` can be either a contract or an integert type) but it might be expanded in the future

   1. `type(Contract).name`

      > the name of contract

   1. `type(Contract).creationCode`

      > memory bytes array that contains the creation bytecode of the contract. This can be used in inline assembly to build custom creation routines, especially by using `create2` opcode. This property CANNOT be accesed in the contract itself or any derived contract. It causes the bytecode to be included in the bytecode of the call site and thus circular references like that are not possible.

   1. `type(Contract).runtimeCode`

      > memory bytes array that contains the runtime bytecode of the contract. This is the code that is usually deployed by the constructor of contract `C`. if `C` has a constructor that uses inline assumbly, this might be different from the actually deployed bytecode. Also note that libraries modify their runtime bytecode at time of deployment to guard against regular call. The same restrictions as with `.creationCode` also apply for this property

   1. `type(Interface).interfaceId`

      > A `bytes4` value containing the `EIP-165` interface identifier of the given interface `I`. The identifier is defined as the `XOR` of all function selectors defined within the interface itself - excluding all the inherited funcitions

   1. `type(T).min`

      > smallest value represented but type `T`

   1. `type(T).max`

      > largest value represented but type `T`

1. Reserved Keywords

   1. `after`, `alias`, `apply`, `auto`, `byte`, `case`, `copyof`, `default`, `define`, `final`, `implements`, `in`, `inline`, `let`, `macro`, `match`, `mutable`, `null`, `of`, `partial`, `promise`, `reference`, `relocatable`, `sealed`, `sizeof`, `static`, `supports`, `switch`, `typedef`, `typeof`, `var`
