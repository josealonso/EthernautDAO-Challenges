// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./SoulboundERC20.sol";

contract EXPToken is SoulboundERC20("EXPToken", "EXP", 18) {
    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}

/*
Test Suite
After minting, transfer(), transferFrom() and approve() are not allowed
After minting, a TransferDisabled event is emitted
*/
