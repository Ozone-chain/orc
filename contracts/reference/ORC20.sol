// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IORC20} from "../interfaces/IORC20.sol";
import {IORC20Metadata} from "../interfaces/IORC20Metadata.sol";
import {IORC20Errors} from "../interfaces/IORC20Errors.sol";

/**
 * @title ORC20
 * @notice Production-grade reference implementation of the Ozone Fungible Token Standard (ORC-20).
 * @dev Fully ABI and selector-compatible with ERC-20, utilizing modern Solidity 0.8+ checked arithmetic
 * and typed custom errors for gas efficiency.
 */
contract ORC20 is IORC20, IORC20Metadata, IORC20Errors {
    mapping(address account => uint256) private _balances;
    mapping(address account => mapping(address spender => uint256)) private _allowances;

    uint256 private _totalSupply;
    string private _name;
    string private _symbol;

    /**
     * @notice Initializes the token with a human-readable name and symbol.
     * @param name_ The token name (e.g. "Ozone Reference Token").
     * @param symbol_ The token symbol (e.g. "ORC").
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @inheritdoc IORC20Metadata
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @inheritdoc IORC20Metadata
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @inheritdoc IORC20Metadata
     * @dev Defaults to 18 decimal places, conforming to EVM conventions.
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * @inheritdoc IORC20
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @inheritdoc IORC20
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @inheritdoc IORC20
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = msg.sender;
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @inheritdoc IORC20
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @inheritdoc IORC20
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, amount);
        return true;
    }

    /**
     * @inheritdoc IORC20
     */
    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
        address spender = msg.sender;
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    /**
     * @dev Internal transfer logic.
     */
    function _transfer(address from, address to, uint256 amount) internal virtual {
        if (from == address(0)) {
            revert ORC20InvalidSender(address(0));
        }
        if (to == address(0)) {
            revert ORC20InvalidReceiver(address(0));
        }
        _update(from, to, amount);
    }

    /**
     * @dev Transfers `value` tokens from `from` to `to`, or mints if `from` is address(0),
     * or burns if `to` is address(0).
     */
    function _update(address from, address to, uint256 value) internal virtual {
        if (from == address(0)) {
            // Minting
            _totalSupply += value;
        } else {
            uint256 fromBalance = _balances[from];
            if (fromBalance < value) {
                revert ORC20InsufficientBalance(from, fromBalance, value);
            }
            unchecked {
                // Overflow not possible: value <= fromBalance
                _balances[from] = fromBalance - value;
            }
        }

        if (to == address(0)) {
            // Burning
            unchecked {
                // Overflow not possible: value <= totalSupply or value <= fromBalance <= totalSupply
                _totalSupply -= value;
            }
        } else {
            unchecked {
                // Overflow not possible: balance + value is at most totalSupply
                _balances[to] += value;
            }
        }

        emit Transfer(from, to, value);
    }

    /**
     * @dev Creates `value` tokens and assigns them to `account`.
     */
    function _mint(address account, uint256 value) internal virtual {
        if (account == address(0)) {
            revert ORC20InvalidReceiver(address(0));
        }
        _update(address(0), account, value);
    }

    /**
     * @dev Destroys `value` tokens from `account`.
     */
    function _burn(address account, uint256 value) internal virtual {
        if (account == address(0)) {
            revert ORC20InvalidSender(address(0));
        }
        _update(account, address(0), value);
    }

    /**
     * @dev Internal approval logic.
     */
    function _approve(address owner, address spender, uint256 value) internal virtual {
        _approve(owner, spender, value, true);
    }

    /**
     * @dev Internal approval logic with optional event emission.
     */
    function _approve(address owner, address spender, uint256 value, bool emitEvent) internal virtual {
        if (owner == address(0)) {
            revert ORC20InvalidApprover(address(0));
        }
        if (spender == address(0)) {
            revert ORC20InvalidSpender(address(0));
        }
        _allowances[owner][spender] = value;
        if (emitEvent) {
            emit Approval(owner, spender, value);
        }
    }

    /**
     * @dev Updates `owner`'s allowance for `spender` based on spent `value`.
     * Does not update if current allowance is `type(uint256).max` (infinite allowance).
     */
    function _spendAllowance(address owner, address spender, uint256 value) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            if (currentAllowance < value) {
                revert ORC20InsufficientAllowance(spender, currentAllowance, value);
            }
            unchecked {
                _approve(owner, spender, currentAllowance - value, false);
            }
        }
    }
}
