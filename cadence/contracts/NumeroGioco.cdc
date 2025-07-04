access(all) contract NumeroGioco {

    // Struttura che rappresenta una giocata
    access(all) struct Giocata {
        access(all) let address: Address
        access(all) let numero: Int

        init(address: Address, numero: Int) {
            self.address = address
            self.numero = numero
        }
    }

    // Lista di tutte le giocate
    access(all) var giocate: [Giocata]
    access(all) var giocoChiuso: Bool
    access(all) var vincitore: Address?

    init() {
        self.giocate = []
        self.giocoChiuso = false
        self.vincitore = nil
    }

    // Funzione per partecipare al gioco
    access(all) fun partecipa(numero: Int) {
        pre {
            !self.giocoChiuso: "Il gioco è chiuso"
        }

        let giocata = Giocata(address: AuthAccount(payer: signer).address, numero: numero)
        self.giocate.append(giocata)
    }

    // Funzione solo admin per chiudere il gioco e calcolare il vincitore
    access(all) fun chiudiGioco(): Address {
        pre {
            !self.giocoChiuso: "Già chiuso"
            self.giocate.length > 0: "Nessuna giocata"
        }

        self.giocoChiuso = true

        let totale = self.giocate.reduce(0, fun (somma: Int, giocata: Giocata): Int {
            return somma + giocata.numero
        })

        let media = totale / self.giocate.length
        let target = media / 2

        var vincitore: Address = self.giocate[0].address
        var minDiff = abs(self.giocate[0].numero - target)

        for giocata in self.giocate {
            let diff = abs(giocata.numero - target)
            if diff < minDiff {
                minDiff = diff
                vincitore = giocata.address
            }
        }

        self.vincitore = vincitore
        return vincitore
    }

    access(all) fun getGiocate(): [Giocata] {
        return self.giocate
    }

    access(all) fun getVincitore(): Address? {
        return self.vincitore
    }
}
