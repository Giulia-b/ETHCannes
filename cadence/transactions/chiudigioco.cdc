import NumeroGioco from 0x01

transaction {
    prepare(signer: AuthAccount) {
        let vincitore = NumeroGioco.chiudiGioco()
        log(vincitore)
    }
}
