// Dependency file: contracts/interfaces/IRuntimeUpgradeEvmHook.sol

// SPDX-License-Identifier: GPL-3.0-only
// pragma solidity ^0.8.0;

interface IRuntimeUpgradeEvmHook {

    function upgradeTo(address contractAddress, bytes calldata byteCode) external;

    function deployTo(address contractAddress, bytes calldata byteCode) external;
}

// Root file: contracts/tests/FakeRuntimeUpgradeEvmHook.sol

pragma solidity ^0.8.0;

// import "contracts/interfaces/IRuntimeUpgradeEvmHook.sol";

contract FakeRuntimeUpgradeEvmHook is IRuntimeUpgradeEvmHook {

    event Upgraded(address contractAddress, bytes byteCode);
    event Deployed(address contractAddress, bytes byteCode);

    function upgradeTo(address contractAddress, bytes calldata byteCode) external override {
        emit Upgraded(contractAddress, byteCode);
    }

    function deployTo(address contractAddress, bytes calldata byteCode) external override {
        emit Deployed(contractAddress, byteCode);
    }
}