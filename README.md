## Pausable with reason string

Currently, when someone needs to pause a contract (i.e., stop its functioning for any reason), the OpenZeppelin _pause() function can be invoked.

```javascript
function _pause() internal virtual whenNotPaused {
     _paused = true;
    emit Paused(_msgSender());
}
```

When this function is called, the contract is paused, and the Paused(address) event is emitted. Below are the statistics showing how many times this event has been triggered, based on data from Dune Analytics (as of 2024-09-13). It has been called a substantial number of times:

```sql
select count() as c from ethereum.logs where topic0 = keccak(to_utf8('Paused(address)')) -- 20523
select count() as c from optimism.logs where topic0 = keccak(to_utf8('Paused(address)')) -- 1724
select count(*) as c from arbitrum.logs where topic0 = keccak(to_utf8('Paused(address)')) -- 48418
select count(*) as c from avalanche_c.logs where topic0 = keccak(to_utf8('Paused(address)')) -- 4177
select count(*) as c from polygon.logs where topic0 = keccak(to_utf8('Paused(address)')) -- 34208
```

However, when a contract is paused, users receive no additional information regarding the reason for the pause or any possible actions they can take. They only encounter a generic Paused error.

The proposed enhancement is to extend the pause mechanism to include a string reason, which will provide meaningful information to users. This change will allow users to see a reason for the pause, improving transparency and communication.

```diff
function _pause(string memory reason) internal virtual whenNotPaused {
     _paused = true;
+    _reason =  reason;
    emit Paused(_msgSender());
}

function _requireNotPaused() internal view virtual {
    if (paused()) {
+        revert EnforcedPause(_reason);
-        revert EnforcedPause();
    }
}
```