// Dependency file: contracts/interfaces/IChainConfig.sol

// SPDX-License-Identifier: GPL-3.0-only
// pragma solidity ^0.8.0;

interface IChainConfig {

    function getActiveValidatorsLength() external view returns (uint32);

    function setActiveValidatorsLength(uint32 newValue) external;

    function getEpochBlockInterval() external view returns (uint32);

    function setEpochBlockInterval(uint32 newValue) external;

    function getMisdemeanorThreshold() external view returns (uint32);

    function setMisdemeanorThreshold(uint32 newValue) external;

    function getFelonyThreshold() external view returns (uint32);

    function setFelonyThreshold(uint32 newValue) external;

    function getValidatorJailEpochLength() external view returns (uint32);

    function setValidatorJailEpochLength(uint32 newValue) external;

    function getUndelegatePeriod() external view returns (uint32);

    function setUndelegatePeriod(uint32 newValue) external;

    function getMinValidatorStakeAmount() external view returns (uint256);

    function setMinValidatorStakeAmount(uint256 newValue) external;

    function getMinStakingAmount() external view returns (uint256);

    function setMinStakingAmount(uint256 newValue) external;
}

// Dependency file: contracts/interfaces/IGovernance.sol

// pragma solidity ^0.8.0;

interface IGovernance {

    function getVotingSupply() external view returns (uint256);

    function getVotingPower(address validator) external view returns (uint256);
}


// Dependency file: contracts/interfaces/ISlashingIndicator.sol

// pragma solidity ^0.8.0;

interface ISlashingIndicator {

    function slash(address validator) external;
}

// Dependency file: contracts/interfaces/ISystemReward.sol

// pragma solidity ^0.8.0;

interface ISystemReward {

    function updateDistributionShare(address[] calldata accounts, uint16[] calldata shares) external;

    function getSystemFee() external view returns (uint256);

    function claimSystemFee() external;
}

// Dependency file: contracts/interfaces/IRuntimeUpgradeEvmHook.sol

// pragma solidity ^0.8.0;

interface IRuntimeUpgradeEvmHook {

    function upgradeTo(address contractAddress, bytes calldata byteCode) external;

    function deployTo(address contractAddress, bytes calldata byteCode) external;
}

// Dependency file: contracts/interfaces/IValidatorSet.sol

// pragma solidity ^0.8.0;

interface IValidatorSet {

    function getValidators() external view returns (address[] memory);

    function deposit(address validator) external payable;
}

// Dependency file: contracts/interfaces/IStaking.sol

// pragma solidity ^0.8.0;

// import "contracts/interfaces/IValidatorSet.sol";

interface IStaking is IValidatorSet {

    function currentEpoch() external view returns (uint64);

    function nextEpoch() external view returns (uint64);

    function isValidatorActive(address validator) external view returns (bool);

    function isValidator(address validator) external view returns (bool);

    function getValidatorStatus(address validator) external view returns (
        address ownerAddress,
        uint8 status,
        uint256 totalDelegated,
        uint32 slashesCount,
        uint64 changedAt,
        uint64 jailedBefore,
        uint64 claimedAt,
        uint16 commissionRate,
        uint96 totalRewards
    );

    function getValidatorStatusAtEpoch(address validator, uint64 epoch) external view returns (
        address ownerAddress,
        uint8 status,
        uint256 totalDelegated,
        uint32 slashesCount,
        uint64 changedAt,
        uint64 jailedBefore,
        uint64 claimedAt,
        uint16 commissionRate,
        uint96 totalRewards
    );

    function getValidatorByOwner(address owner) external view returns (address);

    function registerValidator(address validator, uint16 commissionRate) payable external;

    function addValidator(address validator) external;

    function removeValidator(address validator) external;

    function activateValidator(address validator) external;

    function disableValidator(address validator) external;

    function releaseValidatorFromJail(address validator) external;

    function changeValidatorCommissionRate(address validator, uint16 commissionRate) external;

    function changeValidatorOwner(address validator, address newOwner) external;

    function getValidatorDelegation(address validator, address delegator) external view returns (
        uint256 delegatedAmount,
        uint64 atEpoch
    );

    function delegate(address validator) payable external;

    function undelegate(address validator, uint256 amount) external;

    function getValidatorFee(address validator) external view returns (uint256);

    function getPendingValidatorFee(address validator) external view returns (uint256);

    function claimValidatorFee(address validator) external;

    function claimValidatorFeeAtEpoch(address validator, uint64 beforeEpoch) external;

    function getDelegatorFee(address validator, address delegator) external view returns (uint256);

    function getPendingDelegatorFee(address validator, address delegator) external view returns (uint256);

    function claimDelegatorFee(address validator) external;

    function calcAvailableForRedelegateAmount(address validator, address delegator) external view returns (uint256 amountToStake, uint256 rewardsDust);

    function redelegateDelegatorFee(address validator) external;

    function claimDelegatorFeeAtEpoch(address validator, uint64 beforeEpoch) external;

    function slash(address validator) external;
}

// Dependency file: contracts/interfaces/IRuntimeUpgrade.sol

// pragma solidity ^0.8.0;

interface IRuntimeUpgrade {

    function getEvmHookAddress() external view returns (address);

    function upgradeSystemSmartContract(address systemContractAddress, bytes calldata newByteCode, bytes calldata applyFunction) external;

    function deploySystemSmartContract(address systemContractAddress, bytes calldata newByteCode, bytes calldata applyFunction) external;

    function getSystemContracts() external view returns (address[] memory);
}

// Dependency file: contracts/interfaces/IStakingPool.sol

// pragma solidity ^0.8.0;

interface IStakingPool {

    function getStakedAmount(address validator, address staker) external view returns (uint256);

    function stake(address validator) external payable;

    function unstake(address validator, uint256 amount) external;

    function claimableRewards(address validator, address staker) external view returns (uint256);

    function claim(address validator) external;
}

// Dependency file: contracts/interfaces/IDeployerProxy.sol

// pragma solidity ^0.8.0;

interface IDeployerProxy {

    function registerDeployedContract(address account, address impl) external;

    function checkContractActive(address impl) external;

    function isDeployer(address account) external view returns (bool);

    function getContractState(address contractAddress) external view returns (uint8 state, address impl, address deployer);

    function isBanned(address account) external view returns (bool);

    function addDeployer(address account) external;

    function banDeployer(address account) external;

    function unbanDeployer(address account) external;

    function removeDeployer(address account) external;

    function disableContract(address contractAddress) external;

    function enableContract(address contractAddress) external;
}

// Dependency file: contracts/interfaces/IInjector.sol

// pragma solidity ^0.8.0;

// import "contracts/interfaces/ISlashingIndicator.sol";
// import "contracts/interfaces/ISystemReward.sol";
// import "contracts/interfaces/IGovernance.sol";
// import "contracts/interfaces/IStaking.sol";
// import "contracts/interfaces/IDeployerProxy.sol";
// import "contracts/interfaces/IStakingPool.sol";
// import "contracts/interfaces/IChainConfig.sol";

interface IInjector {

    function init() external;

    function isInitialized() external view returns (bool);

    function getStaking() external view returns (IStaking);

    function getSlashingIndicator() external view returns (ISlashingIndicator);

    function getSystemReward() external view returns (ISystemReward);

    function getStakingPool() external view returns (IStakingPool);

    function getGovernance() external view returns (IGovernance);

    function getChainConfig() external view returns (IChainConfig);
}

// Dependency file: contracts/Injector.sol

// pragma solidity ^0.8.0;

// import "contracts/interfaces/IChainConfig.sol";
// import "contracts/interfaces/IGovernance.sol";
// import "contracts/interfaces/ISlashingIndicator.sol";
// import "contracts/interfaces/ISystemReward.sol";
// import "contracts/interfaces/IRuntimeUpgradeEvmHook.sol";
// import "contracts/interfaces/IValidatorSet.sol";
// import "contracts/interfaces/IStaking.sol";
// import "contracts/interfaces/IRuntimeUpgrade.sol";
// import "contracts/interfaces/IStakingPool.sol";
// import "contracts/interfaces/IInjector.sol";
// import "contracts/interfaces/IDeployerProxy.sol";

abstract contract AlreadyInit {

    // flag indicating is smart contract initialized already
    bool internal _init;

    modifier initializer() {
        require(!_init, "Injector: already initialized");
        _;
        _init = true;
    }

    modifier whenNotInitialized() {
        require(!_init, "Injector: already initialized");
        _;
    }

    modifier whenInitialized() {
        require(_init, "Injector: not initialized yet");
        _;
    }
}

abstract contract InjectorContextHolder is AlreadyInit, IInjector {

    // system smart contract constructor
    bytes internal _ctor;

    // BSC compatible contracts
    IStaking internal _stakingContract;
    ISlashingIndicator internal _slashingIndicatorContract;
    ISystemReward internal _systemRewardContract;
    // BAS defined contracts
    IStakingPool internal _stakingPoolContract;
    IGovernance internal _governanceContract;
    IChainConfig internal _chainConfigContract;
    IRuntimeUpgrade internal _runtimeUpgradeContract;
    IDeployerProxy internal _deployerProxyContract;

    // already init (1) + ctor(1) + injector (8) = 10
    uint256[100 - 10] private __reserved;

    constructor(bytes memory constructorParams) {
        // save constructor params to use them in the init function
        _ctor = constructorParams;
    }

    function init() external initializer {
        // BSC compatible addresses
        _stakingContract = IStaking(0x0000000000000000000000000000000000001000);
        _slashingIndicatorContract = ISlashingIndicator(0x0000000000000000000000000000000000001001);
        _systemRewardContract = ISystemReward(0x0000000000000000000000000000000000001002);
        // BAS defined addresses
        _stakingPoolContract = IStakingPool(0x0000000000000000000000000000000000007001);
        _governanceContract = IGovernance(0x0000000000000000000000000000000000007002);
        _chainConfigContract = IChainConfig(0x0000000000000000000000000000000000007003);
        _runtimeUpgradeContract = IRuntimeUpgrade(0x0000000000000000000000000000000000007004);
        _deployerProxyContract = IDeployerProxy(0x0000000000000000000000000000000000007005);
        // invoke constructor
        _invokeContractConstructor();
    }

    function initManually(
        IStaking stakingContract,
        ISlashingIndicator slashingIndicatorContract,
        ISystemReward systemRewardContract,
        IStakingPool stakingPoolContract,
        IGovernance governanceContract,
        IChainConfig chainConfigContract,
        IRuntimeUpgrade runtimeUpgradeContract,
        IDeployerProxy deployerProxyContract
    ) public initializer {
        // BSC-compatible
        _stakingContract = stakingContract;
        _slashingIndicatorContract = slashingIndicatorContract;
        _systemRewardContract = systemRewardContract;
        // BAS-defined
        _stakingPoolContract = stakingPoolContract;
        _governanceContract = governanceContract;
        _chainConfigContract = chainConfigContract;
        _runtimeUpgradeContract = runtimeUpgradeContract;
        _deployerProxyContract = deployerProxyContract;
        // invoke constructor
        _invokeContractConstructor();
    }

    function _invokeContractConstructor() internal {
        if (_ctor.length == 0) {
            return;
        }
        (bool success, bytes memory returnData) = address(this).call(_ctor);
        // if everything is success then just exit w/o revert
        if (success) {
            return;
        }
        if (returnData.length == 0) {
            revert("Injector: construction failed w/ unknown error");
        }
        assembly {
            let returnDataSize := mload(returnData)
            revert(add(32, returnData), returnDataSize)
        }
    }

    function isInitialized() external view returns (bool) {
        return _init;
    }

    modifier onlyFromCoinbase() {
        require(msg.sender == block.coinbase, "InjectorContextHolder: only coinbase");
        _;
    }

    modifier onlyFromSlashingIndicator() {
        require(msg.sender == address(_slashingIndicatorContract), "InjectorContextHolder: only slashing indicator");
        _;
    }

    modifier onlyFromGovernance() {
        require(IGovernance(msg.sender) == _governanceContract, "InjectorContextHolder: only governance");
        _;
    }

    modifier onlyFromRuntimeUpgrade() {
        require(IRuntimeUpgrade(msg.sender) == _runtimeUpgradeContract, "InjectorContextHolder: only runtime upgrade");
        _;
    }

    modifier onlyZeroGasPrice() {
        require(tx.gasprice == 0, "InjectorContextHolder: only zero gas price");
        _;
    }

    function getStaking() public view returns (IStaking) {
        return _stakingContract;
    }

    function getSlashingIndicator() public view returns (ISlashingIndicator) {
        return _slashingIndicatorContract;
    }

    function getSystemReward() public view returns (ISystemReward) {
        return _systemRewardContract;
    }

    function getStakingPool() public view returns (IStakingPool) {
        return _stakingPoolContract;
    }

    function getGovernance() public view returns (IGovernance) {
        return _governanceContract;
    }

    function getChainConfig() public view returns (IChainConfig) {
        return _chainConfigContract;
    }
}


// Root file: contracts/DeployerProxy.sol

pragma solidity ^0.8.0;

// import "contracts/Injector.sol";

contract DeployerProxy is IDeployerProxy, InjectorContextHolder {

    event DeployerAdded(address indexed account);
    event DeployerRemoved(address indexed account);
    event DeployerBanned(address indexed account);
    event DeployerUnbanned(address indexed account);
    event ContractDisabled(address indexed contractAddress);
    event ContractEnabled(address indexed contractAddress);

    event ContractDeployed(address indexed account, address impl);

    struct Deployer {
        bool exists;
        address account;
        bool banned;
    }

    enum ContractState {
        NotFound,
        Enabled,
        Disabled
    }

    struct SmartContract {
        ContractState state;
        address impl;
        address deployer;
    }

    mapping(address => Deployer) private _contractDeployers;
    mapping(address => SmartContract) private _smartContracts;

    constructor(bytes memory constructorParams) InjectorContextHolder(constructorParams) {
    }

    function ctor(address[] memory deployers) external whenNotInitialized {
        for (uint256 i = 0; i < deployers.length; i++) {
            _addDeployer(deployers[i]);
        }
    }

    function isDeployer(address account) public override view returns (bool) {
        return _contractDeployers[account].exists;
    }

    function isBanned(address account) public override view returns (bool) {
        return _contractDeployers[account].banned;
    }

    function addDeployer(address account) public onlyFromGovernance virtual override {
        _addDeployer(account);
    }

    function _addDeployer(address account) internal {
        require(!_contractDeployers[account].exists, "Deployer: deployer already exist");
        _contractDeployers[account] = Deployer({
        exists : true,
        account : account,
        banned : false
        });
        emit DeployerAdded(account);
    }

    function removeDeployer(address account) public onlyFromGovernance virtual override {
        _removeDeployer(account);
    }

    function _removeDeployer(address account) internal {
        require(_contractDeployers[account].exists, "Deployer: deployer doesn't exist");
        delete _contractDeployers[account];
        emit DeployerRemoved(account);
    }

    function banDeployer(address account) public onlyFromGovernance virtual override {
        _banDeployer(account);
    }

    function _banDeployer(address account) internal {
        require(_contractDeployers[account].exists, "Deployer: deployer doesn't exist");
        require(!_contractDeployers[account].banned, "Deployer: deployer already banned");
        _contractDeployers[account].banned = true;
        emit DeployerBanned(account);
    }

    function _unbanDeployer(address account) internal {
        require(_contractDeployers[account].exists, "Deployer: deployer doesn't exist");
        require(_contractDeployers[account].banned, "Deployer: deployer is not banned");
        _contractDeployers[account].banned = false;
        emit DeployerUnbanned(account);
    }

    function unbanDeployer(address account) public onlyFromGovernance virtual override {
        _unbanDeployer(account);
    }

    function getContractState(address contractAddress) external view virtual override returns (uint8 state, address impl, address deployer) {
        SmartContract memory dc = _smartContracts[contractAddress];
        state = uint8(dc.state);
        impl = dc.impl;
        deployer = dc.deployer;
    }

    function _registerDeployedContract(address deployer, address impl) internal {
        // make sure this call is allowed
        require(isDeployer(deployer), "Deployer: deployer is not allowed");
        // remember who deployed contract
        SmartContract memory dc = _smartContracts[impl];
        require(dc.impl == address(0x00), "Deployer: contract is deployed already");
        dc.state = ContractState.Enabled;
        dc.impl = impl;
        dc.deployer = deployer;
        _smartContracts[impl] = dc;
        // emit event
        emit ContractDeployed(deployer, impl);
    }

    function registerDeployedContract(address deployer, address impl) public onlyFromCoinbase virtual override {
        _registerDeployedContract(deployer, impl);
    }

    function checkContractActive(address impl) external view virtual override {
        _checkContractActive(impl);
    }

    function _checkContractActive(address impl) internal view {
        // check that contract is not disabled
        SmartContract memory dc = _smartContracts[impl];
        require(dc.state != ContractState.Disabled, "Deployer: contract is not enabled");
    }

    function disableContract(address impl) public onlyFromGovernance virtual override {
        _disableContract(impl);
    }

    function enableContract(address impl) public onlyFromGovernance virtual override {
        _enableContract(impl);
    }

    function _disableContract(address contractAddress) internal {
        SmartContract memory dc = _smartContracts[contractAddress];
        require(dc.state == ContractState.Enabled, "Deployer: contract already disabled");
        dc.state = ContractState.Disabled;
        _smartContracts[contractAddress] = dc;
        //emit event
        emit ContractDisabled(contractAddress);
    }

    function _enableContract(address contractAddress) internal {
        SmartContract memory dc = _smartContracts[contractAddress];
        require(dc.state == ContractState.Disabled, "Deployer: contract already enabled");
        dc.state = ContractState.Enabled;
        _smartContracts[contractAddress] = dc;
        //emit event
        emit ContractEnabled(contractAddress);
    }
}