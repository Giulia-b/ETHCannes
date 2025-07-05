# Usage

1. launch "flow emulator"
2. open another terminal, launch "flow deploy"
3. write a number XX with the command: 
		flow transactions send cadence/transactions/partecipa.cdc 'XX' --signer emulator-account

4. close the game and get the winner with:
		flow transactions send cadence/transactions/chiudiGioco.cdc --signer emulator-account
		flow scripts execute cadence/scripts/getVincitore.cdc