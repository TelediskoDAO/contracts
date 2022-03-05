import { task } from "hardhat/config";
import { keccak256, parseEther, toUtf8Bytes } from "ethers/lib/utils";
import { loadContract } from "./config";
import { ResolutionManager__factory } from "../typechain";

task("voter", "Get voter stats")
  .addParam("resolution", "The resolution id")
  .addParam("account", "The address")
  .setAction(
    async (
      { resolution, account }: { resolution: string; account: string },
      hre
    ) => {
      const contract = await loadContract(
        hre,
        ResolutionManager__factory,
        "ResolutionManager"
      );
      console.log(resolution);
      const response = await contract.getVoterVote(resolution, account);
      console.log("Is Yes ", response[0]);
      console.log("Has Voted ", response[1]);
      console.log("Voting Power ", response[2]);
    }
  );
