access(all) contract NumeroGioco {

    access(all) struct Giocata {
        access(all) let address: Address
        access(all) let numero: Int

        init(address: Address, numero: Int) {
            self.address = address
            self.numero = numero
        }
    }

    access(all) var giocate: [Giocata]
    access(all) var giocoChiuso: Bool
    access(all) var vincitore: Int?

    init() {
        self.giocate = []
        self.giocoChiuso = false
        self.vincitore = nil
    }

    // Funzione abs custom
    access(all) fun abs(x: Int): Int {
        return x < 0 ? -x : x
    }

    // Devi passare l'indirizzo come parametro!
    access(all) fun partecipa(address: Address, numero: Int) {
        pre {
            !self.giocoChiuso: "Il gioco è chiuso"
        }

        let giocata = Giocata(address: address, numero: numero)
        self.giocate.append(giocata)
    }

    access(all) fun chiudiGioco(): Giocata {
        pre {
            !self.giocoChiuso: "Già chiuso"
            self.giocate.length > 0: "Nessuna giocata"
        }

        self.giocoChiuso = true

        // Somma manuale (niente reduce)
        var totale: Int = 0
        for giocata in self.giocate {
            totale = totale + giocata.numero
        }

        let media = totale / self.giocate.length
        let target = media / 2

        var vincitore: Int = 0
        var minDiff = self.abs(x: self.giocate[0].numero - target)

        for indice, giocata in self.giocate {
            let diff = self.abs(x: giocata.numero - target)
            if diff < minDiff {
                minDiff = diff
                vincitore = indice
            }
        }

        self.vincitore = vincitore
        return self.giocate[vincitore]
    }

    access(all) fun getGiocate(): [Giocata] {
        return self.giocate
    }

    access(all) fun getVincitore(): Giocata? {
	    if let index = self.vincitore {
			return self.giocate[index]
		} else {
			return nil
		}
	}
}
