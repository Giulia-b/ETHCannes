import NumeroGioco from 0x01

transaction(numero: Int) {
    prepare(signer: AuthAccount) {
        NumeroGioco.partecipa(numero: numero)
    }
}
