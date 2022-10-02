// SPDX-License-Identifier: MIT
pragma solidity ^0.5.11;

interface Target{
  function totalSupply() external returns(uint);
  function balanceOf(address) external returns(uint);
  function transfer(address, uint) external;
}

contract TestBytecodeOnly{
    Target t;

    constructor() public{
        address target_addr;
        // init bytecode
        bytes memory target_bytecode = hex"608060405234801561001057600080fd5b506103e86000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055506103e86001819055506101fa8061006e6000396000f3fe608060405234801561001057600080fd5b50600436106100415760003560e01c806318160ddd1461004657806370a0823114610064578063a9059cbb146100bc575b600080fd5b61004e61010a565b6040518082815260200191505060405180910390f35b6100a66004803603602081101561007a57600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190505050610110565b6040518082815260200191505060405180910390f35b610108600480360360408110156100d257600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff16906020019092919080359060200190929190505050610128565b005b60015481565b60006020528060005260406000206000915090505481565b806000803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008282540392505081905550806000808473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008282540192505081905550505056fe";

        uint size = target_bytecode.length;

        assembly{
            target_addr := create(0, 0xa0, size) // 0xa0 was manually computed. It might require different value according to the compiler version
        }
        t = Target(target_addr);
    }

    function transfer(address to, uint amount) public {
        t.transfer(to, amount);
    }

    function echidna_test_balance() public returns(bool){
        return t.balanceOf(address(this)) <= t.totalSupply();
    }
}