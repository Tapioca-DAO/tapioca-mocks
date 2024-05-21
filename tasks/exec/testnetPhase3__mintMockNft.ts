import fs from 'fs';
import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { TTapiocaDeployTaskArgs } from 'tapioca-sdk/dist/ethers/hardhat/DeployerVM';
import { TapiocaMulticall } from 'tapioca-sdk/dist/typechain/tapioca-periphery';

export const testnetPhase3__mintMockNft__task = async (
    taskArgs: TTapiocaDeployTaskArgs & {
        address: string;
        filePath: string;
    },
    hre: HardhatRuntimeEnvironment,
) => {
    await hre.SDK.DeployerVM.tapiocaDeployTask<{
        address: string;
        filePath: string;
    }>(
        taskArgs,
        { hre },
        // eslint-disable-next-line @typescript-eslint/no-empty-function
        async () => {},
        async ({ VM, tapiocaMulticallAddr, taskArgs }) => {
            const filePath = taskArgs.filePath;

            const nft = await hre.ethers.getContractAt(
                'ERC721Mock',
                taskArgs.address,
            );

            const jsonData = (await getJsonData(filePath)) as string[];

            const calls: TapiocaMulticall.CallStruct[] = [];
            for (const address of jsonData) {
                calls.push({
                    target: taskArgs.address,
                    callData: nft.interface.encodeFunctionData('mint', [
                        address,
                    ]),
                    allowFailure: false,
                });
            }

            const splitChunks = splitArrayIntoSubArrays(calls, 7); // 7 chunks, for 700 addresses, that's 100 addresses per chunk
            console.log('[+] Total chunks', splitChunks.length);
            console.log('[+] Chunk size', splitChunks[0].length);
            for (const chunk of splitChunks) {
                await VM.executeMulticall(chunk);
            }
        },
    );
};

function splitArrayIntoSubArrays(inputArray: any[], subArrayCount: number) {
    const perChunk = Math.ceil(inputArray.length / subArrayCount); // items per sub-array
    const result = inputArray.reduce((resultArray, item, index) => {
        const chunkIndex = Math.floor(index / perChunk);

        if (!resultArray[chunkIndex]) {
            resultArray[chunkIndex] = []; // start a new chunk
        }

        resultArray[chunkIndex].push(item);

        return resultArray;
    }, [] as any[][]);

    return result as any[][];
}

async function getJsonData(filePath: string) {
    const fileData = fs.readFileSync(filePath, 'utf-8');
    const jsonData = JSON.parse(fileData);
    return jsonData;
}
