// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

/// @notice Modern and gas efficient ERC20 implementation.
/// @author Solmate (https://github.com/Rari-Capital/solmate/blob/main/src/tokens/ERC20.sol)
/// @author Modified from Uniswap (https://github.com/Uniswap/uniswap-v2-core/blob/master/contracts/UniswapV2ERC20.sol)
/// @author JR_Madrid (https://github.com/josealonso/) Modified to make it a soulbound token
/// @dev Do not manually set balances without updating totalSupply, as the sum of all user balances must not exceed it.

abstract contract SoulboundERC20 {
    /*//////////////////////////////////////////////////////////////
                            METADATA STORAGE
    //////////////////////////////////////////////////////////////*/

    address private _owner;

    string public name;
    string public symbol;
    uint8 public immutable decimals;

    /*//////////////////////////////////////////////////////////////
                              ERC20 STORAGE
    //////////////////////////////////////////////////////////////*/

    mapping(address => uint256) public balanceOf;

    mapping(address => mapping(address => uint256)) public allowance;

    // @dev For the soulbound feature
    mapping(address => bool) public isTransferDisabled;
    mapping(address => bool) public minters;

    /*//////////////////////////////////////////////////////////////
                               CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        _owner = msg.sender;
    }

    /*//////////////////////////////////////////////////////////////
                               ERC20 LOGIC
    //////////////////////////////////////////////////////////////*/

    // Transfer capabilities must be disabled after minting (soulbound)
    function approve(address spender, uint256 amount)
        public
        virtual
        nonTransferrable(spender)
        returns (bool)
    {
        allowance[msg.sender][spender] = amount;

        emit Approval(msg.sender, spender, amount);

        return true;
    }

    // Transfer capabilities must be disabled after minting (soulbound)
    function transfer(address to, uint256 amount)
        public
        virtual
        nonTransferrable(to)
        returns (bool)
    {
        balanceOf[msg.sender] -= amount;
        // Cannot overflow because the sum of all user
        // balances can't exceed the max uint256 value.
        unchecked {
            balanceOf[to] += amount;
        }

        emit Transfer(msg.sender, to, amount);

        return true;
    }

    // Transfer capabilities must be disabled after minting (soulbound)
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual nonTransferrable(to) returns (bool) {
        uint256 allowed = allowance[from][msg.sender]; // Saves gas for limited approvals.
        if (allowed != type(uint256).max)
            allowance[from][msg.sender] = allowed - amount;
        balanceOf[from] -= amount;
        // Cannot overflow because the sum of all user
        // balances can't exceed the max uint256 value.
        unchecked {
            balanceOf[to] += amount;
        }

        emit Transfer(from, to, amount);

        return true;
    }

    function _setApprovedMinter(address potentialMinter, bool canMint)
        internal
        virtual
        onlyOwner
    // returns (bool)
    {
        minters[potentialMinter] = canMint;
        if (canMint) {
            emit ApprovedMinter(potentialMinter);
        }
        // return true;
    }

    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    modifier nonTransferrable(address _sender) {
        require(
            isTransferDisabled[_sender] == false,
            "Non-transferrable token"
        );
        _;
    }

    /*//////////////////////////////////////////////////////////////
                        INTERNAL MINT/BURN LOGIC
    //////////////////////////////////////////////////////////////*/

    function _mint(address to, uint256 amount) internal virtual {
        require(minters[to], "No minting permissions");

        // Cannot overflow because the sum of all user
        // balances can't exceed the max uint256 value.
        unchecked {
            balanceOf[to] += amount;
        }
        // @dev For the soulbound feature
        isTransferDisabled[to] = true;

        emit Transfer(address(0), to, amount);
        emit TransferDisabled(to);
    }

    function _burn(address from, uint256 amount) internal virtual {
        balanceOf[from] -= amount;

        // Cannot underflow because a user's balance
        // will never be larger than the total supply.

        emit Transfer(from, address(0), amount);
    }

    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/

    event Transfer(address indexed from, address indexed to, uint256 amount);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 amount
    );

    // @dev For the soulbound feature
    event ApprovedMinter(address indexed potentialMinter);
    event TransferDisabled(address indexed to);
}
