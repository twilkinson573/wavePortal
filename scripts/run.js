const main = async () => {
  const [owner, randomPerson] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
  const waveContract = await waveContractFactory.deploy({
    // fund contract from our wallet
    value: hre.ethers.utils.parseEther('0.5')
  });
  await waveContract.deployed();

  console.log("Contract deployed to:", waveContract.address);
  console.log("Contract deployed by:", owner.address);

  let contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log('Contract balance:', hre.ethers.utils.formatEther(contractBalance));

  let waveCount;
  waveCount = await waveContract.getTotalWaves();

  let waveTxn;
  waveTxn = await waveContract.wave("first the worst");
  await waveTxn.wait();

  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log('Contract balance:', hre.ethers.utils.formatEther(contractBalance));
  
  waveTxn = await waveContract.wave("second the best tho");
  await waveTxn.wait();

  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log('Contract balance:', hre.ethers.utils.formatEther(contractBalance));

  waveCount = await waveContract.getTotalWaves();

  connectTxn = await waveContract.connect(randomPerson).wave("let's go dood");
  await connectTxn.wait();

  waveCount = await waveContract.getTotalWaves();

  await waveContract.listWaveAddresses();

  let allWaves = await waveContract.getAllWaves();
  console.log(allWaves);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
