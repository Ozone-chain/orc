// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {TestableORC20} from "../test/ORC20Compliance.t.sol";

interface Vm {
    function prank(address) external;
}

/**
 * @title ORC20BenchmarkTest
 * @notice Forge gas benchmarking test suite for ORC-20 operations.
 * @dev Measures deployment, transfer (cold vs warm), approve, and transferFrom execution gas.
 */
contract ORC20BenchmarkTest {
    Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    TestableORC20 internal token;

    address internal alice = address(0x1111111111111111111111111111111111111111);
    address internal bob = address(0x2222222222222222222222222222222222222222);
    address internal charlie = address(0x3333333333333333333333333333333333333333);

    function setUp() public {
        token = new TestableORC20("Benchmark Token", "BENCH");
        token.mint(alice, 10000 ether);
    }

    function test_Benchmark_Deployment() public {
        new TestableORC20("Fresh Benchmark Token", "FRESH");
    }

    function test_Benchmark_Transfer_Cold() public {
        vm.prank(alice);
        token.transfer(bob, 10 ether);
    }

    function test_Benchmark_Transfer_Warm() public {
        // Pre-warm recipient balance slot
        token.mint(bob, 1 ether);

        vm.prank(alice);
        token.transfer(bob, 10 ether);
    }

    function test_Benchmark_Approve() public {
        vm.prank(alice);
        token.approve(bob, 500 ether);
    }

    function test_Benchmark_TransferFrom() public {
        vm.prank(alice);
        token.approve(bob, 500 ether);

        vm.prank(bob);
        token.transferFrom(alice, charlie, 100 ether);
    }

    function test_Benchmark_Mint() public {
        token.mint(charlie, 1000 ether);
    }

    function test_Benchmark_Burn() public {
        token.burn(alice, 500 ether);
    }
}
