import { ERC721Mock__factory } from '@typechain/index';
import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { IDeployerVMAdd } from 'tapioca-sdk/dist/ethers/hardhat/DeployerVM';

export const buildERC721Mock = async (
    hre: HardhatRuntimeEnvironment,
    params: {
        deploymentName: string;
        args: Parameters<ERC721Mock__factory['deploy']>;
    },
): Promise<IDeployerVMAdd<ERC721Mock__factory>> => {
    console.log('[+] buildERC721Mock');

    return {
        contract: new ERC721Mock__factory().connect(
            hre.ethers.provider.getSigner(),
        ),
        deploymentName: params.deploymentName,
        args: params.args,
    };
};
