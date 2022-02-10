// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    bytes32 private _contributorRole;

    // TODO Turn into struct
    mapping(address => address) _delegates;
    mapping(address => uint256) _votingPower;
    mapping(address => uint256) _delegators;

    address[] allAccounts;
    mapping(address => uint256) _countCalls;

    uint256 _totalVotingPower;

    event DelegateChanged(
        address indexed delegator,
        address currentDelegate,
        address newDelegate
    );
    event DelegateVotesChanged(
        address indexed account,
        uint256 oldVotingPower,
        uint256 newVotingPower
    );

    constructor() {}

    /// @dev Returns the account's current delegate
    /// @param account The account whose delegate is requested
    /// @return Account's voting power
    function getDelegate(address account) internal view returns (address) {
        return _delegates[account];
    }

    /// @dev Returns the amount of valid votes for a given address
    /// @notice An address that is not a contributor, will have always 0 voting power
    /// @notice An address that has not delegated at least itself, will have always 0 voting power
    /// @param account The account whose voting power is requested
    /// @return Account's voting power
    function getVotingPower(address account) public view returns (uint256) {
        return _votingPower[account];
    }

    /// @dev Returns the total amount of valid votes
    /// @notice It's the sum of all tokens owned by contributors who has been at least delegated to themselves
    /// @return Total voting power
    function getTotalVotingPower() public view returns (uint256) {
        return _totalVotingPower;
    }

    /// @dev Allows sender to delegate another address for voting
    /// @notice The first address to be delegated must be the sender itself
    /// @notice Sub-delegation is not allowed
    /// @param newDelegate Destination address of module transaction.
    function delegate(address newDelegate) public {
        //require(
        //    _shareholderRegistry.isAtLeast(_contributorRole, msg.sender),
        //    "Voting: only contributors can delegate."
        //);
        //require(
        //    _shareholderRegistry.isAtLeast(_contributorRole, newDelegate),
        //    "Voting: only contributors can be delegated."
        //);
        _delegate(msg.sender, newDelegate);
    }

    function _delegate(address delegator, address newDelegate) internal {
        require(delegator != address(0) && newDelegate != address(0));

        address currentDelegate = getDelegate(delegator);
        if (currentDelegate == address(0)) {
            require(
                newDelegate == delegator,
                "Voting: first delegate yourself"
            );
        }

        require(
            currentDelegate != newDelegate,
            "Voting: the proposed delegate is already your delegate."
        );

        if (delegator != newDelegate) {
            address currentDelegateeDelegate = getDelegate(newDelegate);
            // Can we remove this?
            require(
                currentDelegateeDelegate != address(0),
                "Voting: the proposed delegate should delegate itself first."
            );
            require(
                currentDelegateeDelegate == newDelegate,
                "Voting: the proposed delegatee already has a delegate. No sub-delegations allowed."
            );
        }

        require(
            _delegators[delegator] == 0 || delegator == newDelegate,
            "Voting: the delegator is delegated. No sub-delegations allowed."
        );

        //_beforeDelegate(delegator);

        //uint256 delegatorBalance = _token.balanceOf(delegator);
        _delegates[delegator] = newDelegate;

        if (delegator != newDelegate && newDelegate != address(0)) {
            _delegators[newDelegate]++;
        }

        if (delegator != currentDelegate && currentDelegate != address(0)) {
            _delegators[currentDelegate]--;
        }

        //emit DelegateChanged(delegator, currentDelegate, newDelegate);

        //_moveVotingPower(currentDelegate, newDelegate, delegatorBalance);

        assert(newDelegate == _delegates[newDelegate]);
    }

    function echidna_voting_power() public returns (bool) {
        return (_totalVotingPower >= 0);
    }
}
