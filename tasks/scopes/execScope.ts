import '@nomiclabs/hardhat-ethers';
import { scope } from 'hardhat/config';
import { TAP_TASK } from 'tapioca-sdk';
import { testnetPhase3__mintMockNft__task } from 'tasks/exec/testnetPhase3__mintMockNft';

const execScope = scope('exec', 'Execution tasks');

TAP_TASK(
    execScope
        .task(
            'testnetPhase3MintNft',
            'Mint NFTs for Testnet Phase 3.',
            testnetPhase3__mintMockNft__task,
        )
        .addParam('address', 'The address of the ERC721 contract.')
        .addParam(
            'filePath',
            'The path to the JSON file containing the NFT data.',
        ),
);
