// Root file: contracts/interfaces/ISlashingIndicator.sol

// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

interface ISlashingIndicator {

    function slash(address validator) external;
}