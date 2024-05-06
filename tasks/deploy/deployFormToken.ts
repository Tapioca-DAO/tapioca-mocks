import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { TTapiocaDeployTaskArgs } from 'tapioca-sdk/dist/ethers/hardhat/DeployerVM';
import { buildFormToken } from 'tasks/builds/buildFormToken';

export const deployFormToken__task = async (
    taskArgs: TTapiocaDeployTaskArgs & {
        name: string;
        decimals: number;
    },
    hre: HardhatRuntimeEnvironment,
) => {
    await hre.SDK.DeployerVM.tapiocaDeployTask<{ name: string }>(
        taskArgs,
        { hre },
        async ({ VM, tapiocaMulticallAddr }) => {
            VM.add(
                await buildFormToken(hre, {
                    deploymentName: taskArgs.name,
                    args: [
                        taskArgs.name,
                        taskArgs.name,
                        (1e18).toString(),
                        taskArgs.decimals,
                        tapiocaMulticallAddr,
                    ],
                }),
            );
        },
        async ({ VM }) => {
            const addr = VM.list().find(
                (e) => e.name === taskArgs.name,
            )!.address;
            console.log(
                `[+] FormToken contract with name ${taskArgs.name} deployed at: ${addr}`,
            );
        },
    );
};
