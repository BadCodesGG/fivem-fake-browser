# FiveM In-Game Fake Browser

### Setup

Feel free to rename, change, modify or use as needed. Just give credit where it's due.
```lua
ensure fivem-browser
```

## How to Use

I've registered a client side command called `register` which will trigger the event to open the UI.
Feel free to create your own way of opening this whether it's through your in-game phone or item.

#### Command Name 
```lua
/browser
```

#### Event Trigger Name 
```lua
TriggerEvent("fivem-tablet:open-tablet", "browser")
```