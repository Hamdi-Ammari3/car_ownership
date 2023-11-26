//SPDX-License-Identifier: Unlicensed

pragma solidity >= 0.8.0 < 0.9.0;

contract CarOwner {
    address private manager;
    constructor() {
        manager = msg.sender;
    }

    modifier isManager {
        require(msg.sender == manager);
        _;
    }

    struct Penalties {
        string offence;
        uint fine;
        bool payed;
        uint id;
    }
    Penalties penalties;
    
    struct Car {
        string manufacturer;
        string model;
        uint year;
        string fuel;
        string transmission;
        string color;
        uint8 doors;
        string VIN;
        string stock_number;
        address owner_address;
        Penalties[] myPenalties;
    }

    mapping(string => Car) fetch_car_by_vin;

    function set_car_info(
            string memory _manufacturer,
            string memory _model,
            uint _year,
            string memory _fuel,
            string memory _transmission,
            string memory _color,
            uint8 _doors,
            string memory _VIN,
            string memory _stock_number,
            address _owner_address
            ) public isManager {
            Car storage myCar = fetch_car_by_vin[_VIN];
            myCar.owner_address = _owner_address;
            myCar.manufacturer = _manufacturer;
            myCar.model = _model;
            myCar.year = _year;
            myCar.fuel = _fuel;
            myCar.transmission = _transmission;
            myCar.color = _color;
            myCar.doors = _doors;
            myCar.VIN = _VIN;
            myCar.stock_number = _stock_number;
        }

    function add_penalty(string memory _vin, string memory _offence, uint _fine) public isManager {
        Car storage myCar = fetch_car_by_vin[_vin];
        require(myCar.owner_address != 0x0000000000000000000000000000000000000000,"no car with this VIN number");
        uint _id = myCar.myPenalties.length + 1;
        penalties = Penalties({
            offence:_offence,
            fine:_fine,
            payed:false,
            id:_id
        });
        myCar.myPenalties.push(penalties);
    }
 
    function get_my_car_info (string memory _vin) public view returns (Car memory) {
        Car storage myCar = fetch_car_by_vin[_vin];
        require(myCar.owner_address != 0x0000000000000000000000000000000000000000,"no car with this VIN number");
        if(msg.sender == myCar.owner_address || msg.sender == manager)
            return myCar;
        else
            revert("you are not the car owner");
    }

    function pay_penalties(string memory _vin,uint _id) public payable  {
        Car storage myCar = fetch_car_by_vin[_vin];
        require(myCar.owner_address != 0x0000000000000000000000000000000000000000,"no car with this VIN number");
        require(msg.sender == myCar.owner_address);
        require(msg.value == myCar.myPenalties[_id -1].fine);
        myCar.myPenalties[_id -1].payed = true;
    }  
}



