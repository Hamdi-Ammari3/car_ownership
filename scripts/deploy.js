async function main() {
    const [deployer] = await ethers.getSigners();
    console.log(`Deploying the contract with the account ${deployer.address}`);
  
    const carOwner = await ethers.deployContract("CarOwner");
    console.log(`the contract address ${await carOwner.getAddress()}`);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });