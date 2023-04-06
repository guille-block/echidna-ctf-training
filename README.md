# echidna-ctf-training
## Findings:

### Exercise #1
There is an underflow issue that makes the user end up with more tokens than the initial amount

### Exercise #2
The ownership can be claimed by any address as it has no safeguard check that only owner can call.

### CTF: Token whale challenge
The issue can be found on the transferFrom function as it uses _transfer() that substracts the value to the balance of the spender and not the sending address.

### DEX challenge
The tests showed that swapping back and forth a certain amount of tokens doesnt return you to the initial balance setup but gives you 1 additional unit of a certain token. By doing this you can drain the contract token balance entirely

### Linear bonding curve token
No issues found.


