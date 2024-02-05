// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

interface IReceiver {
    function receiveSomeEth() external payable;
}

contract DelegatorTest {
    function testMsgValue(address receiver) external payable {
        for (uint256 i = 0; i < 2; i++) {
            (bool success, bytes memory reason) =
                address(this).delegatecall(abi.encodeWithSelector(this.testMsgValueInternal.selector, receiver));
            if (!success) {
                revert(_getRevertMsg(reason));
            }
        }
    }

    function testMsgValueInternal(address receiver) public payable {
        IReceiver(receiver).receiveSomeEth{value: msg.value}();
    }

    function _getRevertMsg(bytes memory _returnData) internal pure returns (string memory) {
        // If the _res length is less than 68, then the transaction failed silently (without a revert message)
        if (_returnData.length < 68) return "no return data";
        // solhint-disable-next-line no-inline-assembly
        assembly {
            // Slice the sighash.
            _returnData := add(_returnData, 0x04)
        }
        return abi.decode(_returnData, (string)); // All that remains is the revert string
    }
}
