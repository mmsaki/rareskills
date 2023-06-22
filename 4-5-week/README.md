# Week 4-5

Read [solc-docs](https://leather-bulb-be5.notion.site/Solc-Docs-Notes-a51237131c6f4311975aca1bac08a501)

## Assignments:

> Read the following chapters in solidity documentation

- [x] [Types](https://docs.soliditylang.org/en/latest/Types.html)
- [x] [Units and Globally Available Variables](https://docs.soliditylang.org/en/latest/units-and-global-variables.html)
- [ ] [Expressions and Control Structures](https://docs.soliditylang.org/en/latest/control-structures.html)
- [ ] [Contracts](https://docs.soliditylang.org/en/latest/contracts.html#)

> For each non-trivial or tricky thing, think if you can imagine a bug caused by that behavior. (The link paths are for v0.8.20, if it doesn’t work, replace latest by v0.8.20, or find the the location of the latest chapter.)

## week 4, week 5, week 6

- [Advanced Solidity: Yul and Assembly](https://www.udemy.com/course/advanced-solidity-yul-and-assembly/?referralCode=C46DE4EE2C4BE54D4D33)

  - [x] 2. Types
  - [x] 3. Basic Operations
  - [x] 4. Storage Slots
  - [x] 5. Storage Offsets and Bitshifting
  - [x] 6. Storage of Arrays and Mappings
  - [ ] 7. Memory Operations
  - [x] 8. How Solidity Uses Memory
  - [ ] 9. Dangers of Memory Misuse
  - [ ] 10. Returns, Require, Tuples, Keccak256
  - [ ] 11. Logs and Events
  - [ ] 12. Calldata
  - [ ] 13. Calling Other Contracts
  - [ ] 14. Dynamic Length Arguments
  - [ ] 15. Transfer of Value
  - [ ] 16. Receiving Contract Calls
  - [ ] 18. Etherscan Issues
  - [ ] 19. Storing Data in Contract Bytecode
  - [ ] 20. ERC20 Example Part 1
  - [ ] 21. ERC20 Example Part 2
  - [ ] 22. ERC20 Example Part 3
  - [ ] 23. ERC20 Example Part 4
  - [ ] 24. ERC20 Example Part 5
  - [ ] 25. ERC20 Example Part 6
  - [ ] 26. What We Didn't Cover

- [ ] [Develope ERC1155 in Yul](./ERC1155yul/)
  > This is the hardest assignement of the course

To develop yul contracts, we strongly recommend using foundry. We've seen it save a week of work compared to hardhat. Here is a starting example:

- [x] [Foundry Yul](./ERC1155yul/)

**Important**

See this starkoverflow question for a issue you may run into: https://stackoverflowteams.com/c/rareskills/questions/45

You can copy the tests for ERC1155 from this repo: https://github.com/transmissions11/solmate/blob/main/src/test/ERC1155.t.sol

You may find this useful: https://twitter.com/zachobront/status/1649514017122144258

## Specifications

you should emit the appropriate events and support the functions of the spec

- [ ] event `TransferSingle(address indexed _operator, address indexed _from, address indexed _to, uint256 _id, uint256 _value);`
- [ ] event `TransferBatch(address indexed _operator, address indexed _from, address indexed _to, uint256[] _ids, uint256[] _values);`
- [ ] event `ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);`
- [ ] event `URI(atring _value, uint256 indexed _id);`

- [ ] `ffunction safeTransferFrom(address _from, address _to, uint256 _id, uint256 _value, bytes calldata _data) external`
- [ ] `function balanceOf(address _owner, uint256 _id) external view returns (uint256)`
- [ ] `function balanceOfBatch(address[] calldata _owners, uint256[] calldata _ids) external view returns (uint256[] memory);`
- [ ] `function setApprovalForAll(address _operator, bool _approved) external;`
- [ ] `function isApprovalForAll(address _owner, address _operator) external view returns (bool);`

**Don't** implement the transfer hooks

## Timeline

**first week**

- [x] Write the test first. It's far easier to make sure things work as expected in Yul by writing the tests first.

**second week**

- [ ] Parsing memory arrays from the ABI will be difficult. Do that first.

**third week**

- [ ] The string URI will be challenging. Set aside one week for this. The way Ethereum encodes strings is non-intuitive, Bring it all together. Write the easy functions and pat yourself on the back!

## Complete

- [x] Push your code to github
- [ ] Set up a 1-1 with your instructor
