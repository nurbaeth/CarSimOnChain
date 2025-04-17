# 🏎️ CarSimOnChain

**CarSimOnChain** is an on-chain car driving simulator built entirely with Solidity.  
It’s a minimalistic Web3 experiment where your car's actions — like starting the engine, speeding up, and refueling — are all stored immutably on the blockchain.

No tokens. No rewards. Just pure car vibes... on-chain.

---

## 🚘 Features

- 🔑 Start & stop the engine  
- 💨 Accelerate & brake (with speed limit)  
- ⛽ Fuel system (you need to refuel!)  
- 📦 Each wallet has its own car  
- 🔒 Fully on-chain logic, no frontend required  
- 🛠️ Easy to expand into a multiplayer racing system  

---

## 🧠 How It Works

Each wallet gets its own virtual car, stored in a `mapping(address => Car)` struct.

You interact with the contract to:
- **Start the engine**: `startEngine()`
- **Accelerate**: `accelerate()` (consumes fuel)
- **Brake**: `brake()`
- **Stop engine**: `stopEngine()` (resets speed)
- **Refuel**: `refuel(uint256 amount)`
- **Check status**: `getCarStatus(address)`

---

## 📜 Contract Structure

```solidity
struct Car {
  bool engineOn;
  uint256 speed; // km/h
  uint256 fuel;  // liters
}
