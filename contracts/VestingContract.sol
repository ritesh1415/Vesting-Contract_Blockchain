// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VestingContract {
    // Define the roles
    enum Role { User, Partner, Team }

    // Define the vesting schedules
    struct VestingSchedule {
        uint256 cliff;
        uint256 duration;
        uint256 totalTokens;
    }

    // Mapping of beneficiaries to their vesting schedules
    mapping(address => VestingSchedule) public beneficiaries;

    // Mapping of roles to their vesting schedules
    mapping(Role => VestingSchedule) public roleSchedules;

    // Event emitted when vesting starts
    event VestingStarted();

    // Event emitted when a beneficiary is added
    event BeneficiaryAdded(address beneficiary, Role role);

    // Event emitted when tokens are withdrawn
    event TokensWithdrawn(address beneficiary, uint256 amount);

    // Initialize the contract
    constructor()  {
        // Set up the role schedules
        roleSchedules[Role.User] = VestingSchedule(10 * 30 * 24 * 60 * 60, 2 * 365 * 24 * 60 * 60, 50);
        roleSchedules[Role.Partner] = VestingSchedule(2 * 30 * 24 * 60 * 60, 1 * 365 * 24 * 60 * 60, 25);
        roleSchedules[Role.Team] = VestingSchedule(2 * 30 * 24 * 60 * 60, 1 * 365 * 24 * 60 * 60, 25);
    }

    // Function to start vesting
    function startVesting() public {
        emit VestingStarted();
    }

    // Function to add a beneficiary
    function addBeneficiary(address beneficiary, Role role) public {
        beneficiaries[beneficiary] = roleSchedules[role];
        emit BeneficiaryAdded(beneficiary, role);
    }

    // Function to claim vested tokens
    function claimTokens() public {
        // Calculate the vested tokens
        uint256 vestedTokens = calculateVestedTokens(msg.sender);

        // Transfer the vested tokens to the beneficiary
        // NOTE: This is a placeholder, you'll need to implement the actual token transfer logic
        // msg.sender.transfer(vestedTokens);

        emit TokensWithdrawn(msg.sender, vestedTokens);
    }

    // Function to calculate vested tokens
    function calculateVestedTokens(address beneficiary) internal returns (uint256) {
        // Get the beneficiary's vesting schedule
        VestingSchedule memory schedule = beneficiaries[beneficiary];

        // Calculate the vested tokens based on the cliff and duration
        uint256 vestedTokens = schedule.totalTokens * (block.timestamp - schedule.cliff) / schedule.duration;

        return vestedTokens;
    }
}