import { FormToken__factory } from '@typechain/index';
import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { IDeployerVMAdd } from 'tapioca-sdk/dist/ethers/hardhat/DeployerVM';

export const buildFormToken = async (
    hre: HardhatRuntimeEnvironment,
    params: {
        deploymentName: string;
        args: Parameters<FormToken__factory['deploy']>;
    },
): Promise<IDeployerVMAdd<FormToken__factory>> => {
    console.log('[+] buildFormToken');

    return {
        contract: new FormToken__factory().connect(
            hre.ethers.provider.getSigner(),
        ),
        deploymentName: params.deploymentName,
        args: params.args,
    };
};
