async function main() {
  // We get the contract to deploy
  const WhelpsOfTheWest = await ethers.getContractFactory("WhelpsOfTheWest");
  const whelps = await WhelpsOfTheWest.deploy();

  await whelps.deployed();

  console.log("whelps deployed to:", whelps.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });