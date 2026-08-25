// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {TestableORC20} from "./ORC20Compliance.t.sol";
import {IORC20Errors} from "../contracts/interfaces/IORC20Errors.sol";

interface Vm {
    function prank(address) external;
    function expectRevert(bytes calldata) external;
}

/**
 * @title ORC20EdgeCasesTest
 * @notice Edge-case, invariance, and boundary condition tests for ORC-20 implementations.
 */
contract ORC20EdgeCasesTest is IORC20Errors {
    Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    TestableORC20 internal token;

    address internal alice = address(0x1111111111111111111111111111111111111111);
    address internal bob = address(0x2222222222222222222222222222222222222222);

    function setUp() public {
        token = new TestableORC20("Ozone Test Token", "OZTEST");
        token.mint(alice, 1000 ether);
    }

    // --- 1. Self Transfer ---

    function test_SelfTransfer_PreservesBalance() public {
        vm.prank(alice);
        bool success = token.transfer(alice, 100 ether);

        require(success, "Self-transfer should succeed");
        require(token.balanceOf(alice) == 1000 ether, "Alice balance should remain unchanged");
        require(token.totalSupply() == 1000 ether, "Total supply must be invariant");
    }

    // --- 2. Zero-value transferFrom ---

    function test_TransferFrom_ZeroValue_WithZeroAllowance() public {
        // TransferFrom with value 0 should succeed even with zero allowance
        vm.prank(bob);
        bool success = token.transferFrom(alice, bob, 0);

        require(success, "Zero-value transferFrom must succeed");
        require(token.balanceOf(alice) == 1000 ether, "Alice balance must remain unchanged");
        require(token.balanceOf(bob) == 0, "Bob balance must remain 0");
    }

    // --- 3. Total Supply Invariance with Mint & Burn ---

    function test_MintAndBurn_UpdatesSupplyAccurately() public {
        token.mint(bob, 500 ether);
        require(token.totalSupply() == 1500 ether, "Supply should increase by 500");
        require(token.balanceOf(bob) == 500 ether, "Bob balance should be 500");

        token.burn(bob, 200 ether);
        require(token.totalSupply() == 1300 ether, "Supply should decrease by 200");
        require(token.balanceOf(bob) == 300 ether, "Bob balance should be 300");
    }

    // --- 4. Burn Revert on Insufficient Balance ---

    function test_Burn_Revert_InsufficientBalance() public {
        vm.expectRevert(
            abi.encodeWithSelector(ORC20InsufficientBalance.selector, bob, 0, 10 ether)
        );
        token.burn(bob, 10 ether);
    }
}
