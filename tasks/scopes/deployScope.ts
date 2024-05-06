import '@nomiclabs/hardhat-ethers';
import { scope, types } from 'hardhat/config';
import { TAP_TASK } from 'tapioca-sdk';
import { deployFormToken__task } from 'tasks/deploy/deployFormToken';

const deployScope = scope('deploys', 'Deployment tasks');

TAP_TASK(
    deployScope
        .task('formToken', 'Deploy FormToken contract.', deployFormToken__task)
        .addParam('name', 'The name of the ERC20 token to deploy.')
        .addOptionalParam(
            'decimals',
            'The number of decimals for the token.',
            18,
            types.int,
        ),
);
