import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { TTapiocaDeployTaskArgs } from 'tapioca-sdk/dist/ethers/hardhat/DeployerVM';
import { buildOracleMock } from 'tasks/builds/buildOracleMock';

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
                await buildOracleMock(hre, {
                    deploymentName: taskArgs.name,
                    args: [taskArgs.name, taskArgs.name, tapiocaMulticallAddr],
                }),
            );
        },
    );
};
