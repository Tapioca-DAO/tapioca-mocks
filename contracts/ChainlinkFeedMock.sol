// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {
    AggregatorV3Interface,
    AccessControlledOffchainAggregator
} from "tapioca-periph/interfaces/external/chainlink/IAggregatorV3Interface.sol";

contract AccessControlledOffchainAggregatorMock is AccessControlledOffchainAggregator {
    int192 public maxAnswer = type(int192).max;
    int192 public minAnswer = 0;
}

contract ChainlinkFeedMock is AggregatorV3Interface {
    uint256 public constant version = 0;
    AccessControlledOffchainAggregator public aggregator;

    uint8 public decimals;
    int256 public latestAnswer;
    uint256 public latestTimestamp;
    uint256 public latestRound;
    string private _description;

    mapping(uint256 => int256) public getAnswer;
    mapping(uint256 => uint256) public getTimestamp;
    mapping(uint256 => uint256) private getStartedAt;

    constructor(uint8 _decimals, int256 _initialAnswer, string memory __description) {
        decimals = _decimals;
        updateAnswer(_initialAnswer);

        aggregator = AccessControlledOffchainAggregator(address(new AccessControlledOffchainAggregatorMock()));
        _description = __description;
    }

    function updateAnswer(int256 _answer) public {
        latestAnswer = _answer;
        latestTimestamp = block.timestamp;
        latestRound++;
        getAnswer[latestRound] = _answer;
        getTimestamp[latestRound] = block.timestamp;
        getStartedAt[latestRound] = block.timestamp;
    }

    function updateRoundData(uint80 _roundId, int256 _answer, uint256 _timestamp, uint256 _startedAt) public {
        latestRound = _roundId;
        latestAnswer = _answer;
        latestTimestamp = _timestamp;
        getAnswer[latestRound] = _answer;
        getTimestamp[latestRound] = _timestamp;
        getStartedAt[latestRound] = _startedAt;
    }

    function getRoundData(uint80 _roundId)
        external
        view
        override
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
    {
        return (_roundId, getAnswer[_roundId], getStartedAt[_roundId], getTimestamp[_roundId], _roundId);
    }

    function latestRoundData()
        external
        view
        override
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
    {
        return (
            uint80(latestRound),
            getAnswer[latestRound],
            getStartedAt[latestRound],
            getTimestamp[latestRound],
            uint80(latestRound)
        );
    }

    function description() external view override returns (string memory) {
        return _description;
    }
}
