import NumeroGioco from 0xf8d6e0586b0a20c7

transaction(numero: Int) {
    prepare(signer: auth(BorrowValue) &Account) {
        NumeroGioco.partecipa(address: signer.address, numero: numero)
    }
}
