const hre = require("hardhat");

async function main() {
  const Votacion = await hre.ethers.getContractFactory("Votacion");
  const votacion = await Votacion.deploy();
  var tx = await votacion.deployed();

  console.log(`MiPrimerContrato se publicó en ${votacion.address}`);

  // wait for 5 blocks confirmation
  await tx.deployTransaction.wait(10);

  await hre.run("verify:verify", {
    address: votacion.address,
    constructorArguments: [],
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
