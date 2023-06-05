# week 4, week 5, week 6

- [Advanced Solidity: Yul and Assembly](https://www.udemy.com/course/advanced-solidity-yul-and-assembly/?referralCode=C46DE4EE2C4BE54D4D33)

  - [ ] Introduction
  - [ ] Memory
  - [ ] Inter-contract Calls
  - [ ] Contract Without Solidity

- [ ] Develop ERC1155 in Yul
  > This is the hardest assignement of the course

To develop yul contracts, we strongly recommend using founcrt. We've seen it save a week of work compared to hardhat. He is a starting example:

- [Foundry Yul](https://github.com/CodeForcer/foundry-yul.git)

**Important**

See this starkoverflow question for a issue you may run into: https://stackoverflowteams.com/c/rareskills/questions/45

You can copy the tests for ERC1155 from this repo: https://github.com/transmissions11/solmate/blob/main/src/test/ERC1155.t.sol

You may find this useful: https://twitter.com/zachobront/status/1649514017122144258

## Specifications

you shoukd emit the appropriate events and support the functions of the spec

- [ ] event `TransferSingle(address indexed _operator, address indexed _from, address indexed _to, uint256 _id, uint256 _value);`
- [ ] event `TransferBatch(address indexed _operator, address indexed _from, address indexed _to, uint256[] _ids, uint256[] _values);`
- [ ] event `ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);`
- [ ] event `URI(atring _value, uint256 indexed _id);`

- [ ] `function safeTransferFrom(address _from, address _to, uint256 _id, uint256 _value, bytes calldata _data,) external`
- [ ] `function safeBatchTransferFrom(address _from, address _to, uint256[] calldata _ids, uint256[] calldata _values, bytes calldata _data) external;`

- [ ] `function balanceOf(address _owner, uint256 _id) external view returns (uint256)`
- [ ] `function balanceOfBatch(address[] calldata _owners, uint256[] calldata _ids) external view returns (uint256[] memory);`
- [ ] `function setApprovalForAll(address _operator, bool _approved) external;`
- [ ] `function isApprovalForAll(address _owner, address _operator) external view returns (bool);`

**Don't** implement the transfer hooks

## Timeline

**first week**

- Write the test first. It's far easier to make sure things work as expected in Yul by writing the tests first.

**second week**

- Parsing memory arrays from the ABI will be difficult. Do that first.

**third week**

- The string URI will be challenging. Set aside one week for this. The way Ethereum encodes strings is non-intuitive, Bring it all together. Write the easy functions and pat yourself on the back!

## Complete

- [ ] Push your code to github
- [ ] Set up a 1-1 with your instructor
