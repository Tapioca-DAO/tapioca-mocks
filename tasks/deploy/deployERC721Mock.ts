import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { TTapiocaDeployTaskArgs } from 'tapioca-sdk/dist/ethers/hardhat/DeployerVM';
import { buildERC721Mock } from 'tasks/builds/buildERC721Mock';

export const deployERC721Mock__task = async (
    taskArgs: TTapiocaDeployTaskArgs & {
        name: string;
    },
    hre: HardhatRuntimeEnvironment,
) => {
    await hre.SDK.DeployerVM.tapiocaDeployTask<{ name: string }>(
        taskArgs,
        { hre },
        async ({ VM, tapiocaMulticallAddr }) => {
            VM.add(
                await buildERC721Mock(hre, {
                    deploymentName: taskArgs.name,
                    args: [taskArgs.name, taskArgs.name, tapiocaMulticallAddr],
                }),
            );
        },
    );
};
