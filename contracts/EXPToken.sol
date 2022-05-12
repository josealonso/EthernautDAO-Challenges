// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./SoulboundERC20.sol";

contract EXPToken is SoulboundERC20("EXPToken", "EXP", 18) {
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}
