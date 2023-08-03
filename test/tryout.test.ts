import hre, { ethers } from 'hardhat';
import { expect } from 'chai';

// try out different scenarios
describe.skip('research', () => {
    it('should test msg.value', async () => {
        const delegatorTest = await (
            await ethers.getContractFactory('DelegatorTest')
        ).deploy();
        await delegatorTest.deployed();

        const receiverTest = await (
            await ethers.getContractFactory('ReceiverTest')
        ).deploy();
        await receiverTest.deployed();

        await expect(
            delegatorTest.testMsgValue(receiverTest.address, {
                value: ethers.utils.parseEther('1'),
            }),
        ).to.be.reverted;

        const usedEth = await receiverTest.totalEth();
        console.log(usedEth);
    });
});
