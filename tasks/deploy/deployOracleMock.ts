import * as TAPIOCA_PERIPH_CONFIG from '@tapioca-periph/config';
import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { TTapiocaDeployTaskArgs } from 'tapioca-sdk/dist/ethers/hardhat/DeployerVM';
import { buildOracleMock } from 'tasks/builds/buildOracleMock';

export const deployOracleMock__task = async (
    taskArgs: TTapiocaDeployTaskArgs & {
        name: string;
        rate: string;
    },
    hre: HardhatRuntimeEnvironment,
) => {
    await hre.SDK.DeployerVM.tapiocaDeployTask<{ name: string }>(
        taskArgs,
        { hre },
        async ({ VM, tapiocaMulticallAddr }) => {
            VM.add(
                await buildOracleMock(hre, {
                    deploymentName:
                        TAPIOCA_PERIPH_CONFIG.DEPLOYMENT_NAMES
                            .ADB_TAP_OPTION_ORACLE,
                    args: [
                        taskArgs.name,
                        taskArgs.name,
                        hre.ethers.utils.parseEther(taskArgs.rate),
                    ],
                }),
            );
        },
        async ({ VM }) => {
            const addr = VM.list().find(
                (e) => e.name === taskArgs.name,
            )!.address;
            console.log(
                `[+] OracleMock contract with name ${taskArgs.name} deployed at: ${addr} with rate ${taskArgs.rate}`,
            );
        },
    );
};
