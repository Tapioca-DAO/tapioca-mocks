# MultisigMock









## Methods

### addOwner

```solidity
function addOwner(address _owner) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _owner | address | undefined |

### confirmTransaction

```solidity
function confirmTransaction(uint256 _txIndex) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _txIndex | uint256 | undefined |

### executeTransaction

```solidity
function executeTransaction(uint256 _txIndex) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _txIndex | uint256 | undefined |

### getOwners

```solidity
function getOwners() external view returns (address[])
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address[] | undefined |

### getTransaction

```solidity
function getTransaction(uint256 _txIndex) external view returns (address to, uint256 value, bytes data, bool executed, uint256 numConfirmations)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _txIndex | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| to | address | undefined |
| value | uint256 | undefined |
| data | bytes | undefined |
| executed | bool | undefined |
| numConfirmations | uint256 | undefined |

### getTransactionCount

```solidity
function getTransactionCount() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### isConfirmed

```solidity
function isConfirmed(uint256, address) external view returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |
| _1 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### isOwner

```solidity
function isOwner(address) external view returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### numConfirmationsRequired

```solidity
function numConfirmationsRequired() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### owners

```solidity
function owners(uint256) external view returns (address)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### submitTransaction

```solidity
function submitTransaction(address _to, uint256 _value, bytes _data) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _to | address | undefined |
| _value | uint256 | undefined |
| _data | bytes | undefined |

### transactions

```solidity
function transactions(uint256) external view returns (address to, uint256 value, bytes data, bool executed, uint256 numConfirmations)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| to | address | undefined |
| value | uint256 | undefined |
| data | bytes | undefined |
| executed | bool | undefined |
| numConfirmations | uint256 | undefined |




