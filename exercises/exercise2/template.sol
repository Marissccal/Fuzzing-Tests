   // SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
   
   import "./token.sol";

   contract TestToken is Token {
      address echidna_caller = msg.sender;
      constructor() public {
         paused(); // pause the contract
         owner = 0x000000000000000000000000000000000000dEaD; // lose ownership
       }
      // add the property
      function echidna_no_transfer() public view returns (bool) {
        return is_paused == true;
      }
   }