import NumeroGioco from 0xf8d6e0586b0a20c7

transaction {
    prepare(signer: AuthAccount) {
        let vincitore = NumeroGioco.chiudiGioco()
        log(vincitore)
    }
}
