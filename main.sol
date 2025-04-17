// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CarSimOnChain {
    struct Car {
        bool engineOn;
        uint256 speed; // km/h
        uint256 fuel;  // liters
    }

    mapping(address => Car) public cars;

    uint256 public constant MAX_SPEED = 180;
    uint256 public constant FUEL_CONSUMPTION = 1; // 1 liter per action

    event EngineStarted(address indexed player);
    event EngineStopped(address indexed player);
    event Accelerated(address indexed player, uint256 newSpeed);
    event Braked(address indexed player, uint256 newSpeed);
    event Refueled(address indexed player, uint256 fuelAdded);

    modifier hasFuel(address _player) {
        require(cars[_player].fuel >= FUEL_CONSUMPTION, "Not enough fuel");
        _;
    }

    function startEngine() external {
        Car storage car = cars[msg.sender];
        require(!car.engineOn, "Engine already on");
        car.engineOn = true;
        emit EngineStarted(msg.sender);
    }

    function stopEngine() external {
        Car storage car = cars[msg.sender];
        require(car.engineOn, "Engine is already off");
        car.engineOn = false;
        car.speed = 0;
        emit EngineStopped(msg.sender);
    }

    function accelerate() external hasFuel(msg.sender) {
        Car storage car = cars[msg.sender];
        require(car.engineOn, "Engine is off");
        require(car.speed < MAX_SPEED, "Max speed reached");

        car.speed += 10;
        if (car.speed > MAX_SPEED) {
            car.speed = MAX_SPEED;
        }

        car.fuel -= FUEL_CONSUMPTION;
        emit Accelerated(msg.sender, car.speed);
    }

    function brake() external {
        Car storage car = cars[msg.sender];
        require(car.engineOn, "Engine is off");
        require(car.speed > 0, "Already stopped");

        if (car.speed <= 10) {
            car.speed = 0;
        } else {
            car.speed -= 10;
        }

        emit Braked(msg.sender, car.speed);
    }

    function refuel(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        cars[msg.sender].fuel += amount;
        emit Refueled(msg.sender, amount);
    }

    function getCarStatus(address player) external view returns (
        bool engineOn,
        uint256 speed,
        uint256 fuel
    ) {
        Car memory car = cars[player];
        return (car.engineOn, car.speed, car.fuel);
    }
}
