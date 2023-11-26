const { ethers } = require('ethers');
require('dotenv').config();
const contract = require('../artifacts/contracts/CarOwner.sol/CarOwner.json');

const ALCHEMY_API_KEY = // your Alchemy (or node provider of your choice) API_Key;
const PRIVATE_KEY = // your wallet PRIVATE_KEY;
const CONTRACT_ADDRESS = // your deployed contract address
const netwrok = "sepolia";

//Provider 
const provider = new ethers.AlchemyProvider(netwrok,ALCHEMY_API_KEY);

//signer
const signer = new ethers.Wallet(PRIVATE_KEY,provider);

//contract
const carOwnerContract = new ethers.Contract(CONTRACT_ADDRESS,contract.abi,signer);


const main = async () => {
    const get_car_info = await carOwnerContract.get_my_car_info('4Y1SL65848Z411439');
    const add_car_info = await carOwnerContract.set_car_info("tesla","model 3",2023,"electric","automatic","red",4,"4Y1SL65848Z411439","Z411439","0xe59dae98A74650e247DF848Afb892B1842A24dE5");
    await add_car_info.wait();
    const add_penalty = await carOwnerContract.add_penalty("4Y1SL65848Z411439","Red light running",300);
    await add_penalty.wait();
    const pay_penalties = await carOwnerContract.pay_penalties("4Y1SL65848Z411439",1,{
        value:300
    })
    await pay_penalties.wait();
}
main()
