// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./SoulboundERC20.sol";

contract EXPToken is SoulboundERC20 {
    // mapping(address => bool) minters;

    constructor() SoulboundERC20("EXPToken", "EXP", 18) {}

    // @dev No limit on total supply
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

    function setApprovedMinter(address potentialMinter, bool canMint) external {
        _setApprovedMinter(potentialMinter, canMint);
    }
}
