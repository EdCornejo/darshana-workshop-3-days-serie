/**
 * PRACTICA: DE UN SISTEMA DE VOTACION EN EL BLOCKCHAIN
 *
 * Requerimientos:
 * 1. Se creará una lista blanca de personas que pueden votar

                              (LISTA BLANCA)
            Lista de billeteras      |           puede votar
                 0x1                                true
                 0x2                                false
                 0x3                                true
                 0x4                                false

                 mapping(address => bool) listaBlanca;

        Como guardar DNI?
        (ejemplo - no es parte del sistema de votacion)
                    LISTA DE DNIS           |           Puede votar
                       12345678                             true

                maping(uint256 => bool) listaBlancePorDNI;


                    LISTA PARA SABER SI YA VOTO O NO
            Lista de addresses      |            si ya ha votado
                 0x1                                true
                 0x2                                true
                 0x3                                true
                 0x4                                true
                
                mapping(address => bool) siYaVoto;


 * 2. SOlamente hay dos candidatos
        - llevar la cuenta de votos para cada candidato
 * 3. Se creará un método para votar: 'votar'
 *      - Se debe verificar que la persona que vota esté en la lista blanca
 *      - Se debe verificar que la persona que vota no haya votado antes
 *      - Se debe verificar que el candidato exista (candidato1: 1, candidato2: 2);
 *      - Se acumulan  votos para uno de los candidatos
 * 4. Cerrar la votacion y definir al ganador
        - debe impedir que alguien pueda votar (modifier)
        - definir al ganador
        - emite un evento que indica que la votacion ha finalizado
 */

// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Votacion {
    // Layout del smart contract
    // definimos variables
    address admin;
    uint256 votosCandidatoUno;
    uint256 votosCandidatoDos;
    bool votacionFinalizada; // false

    // Definir tiempos en Smart Contracts
    uint256 tiempoDeCierre;

    mapping(address => bool) listaBlanca;
    mapping(address => bool) siYaVoto;

    // modifiers
    modifier onlyAdmin() {
        // si el que llama a este metodo es el admin, entonces que prosiga con lo demás
        // si el que llama a este mtodo no es un admin, que arroje un error
        require(msg.sender == admin, "No eres el admin del contrato");
        _;
    }
    // eventos
    event VotacionRealizada(address votante, uint256 candidato);
    event Ganador(string ganador);

    // constructor
    constructor() {
        // admin => 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        admin = msg.sender; // capturo a la persona que publica el smart contract

        // el tiempo de cierre será 30 dias después de que el contrato se publique
        // block.timestamp => captura la fecha (en segundos) cuando se llama al método
        // 1 days: 1 * 60 * 60 * 24;
        // 5 days: 5 * 60 * 60 * 24;
        // 30 days: 30 * 60 * 60 * 24;
        tiempoDeCierre = block.timestamp + 30 days; // está expresando en segundos
    }

    // metodos
    function guardarEnListaBlanca(
        address votante,
        bool puedeVotar
    ) public onlyAdmin {
        // block.timestamp: esta capturando la fecha en que alguien llama el metodo 'guardarEnListaBlanca'
        listaBlanca[votante] = puedeVotar;
    }

    function guardarEnListaBlancaEnBatch(
        address[] memory votantes,
        bool[] memory siPuedeVotarS
    ) public onlyAdmin {
        for (uint256 i; i < votantes.length; i++) {
            listaBlanca[votantes[i]] = siPuedeVotarS[i];
        }
    }

    /*
    * 3. Se creará un método para votar: 'votar'
 *      - Se debe verificar que la persona que vota esté en la lista blanca
 *      - Se debe verificar que la persona que vota no haya votado antes
 *      - Se debe verificar que el candidato exista (candidato1: 1, candidato2: 2);
 *      - Se acumulan  votos para uno de los candidatos
        - Emitir un evento de VotacionRealizada(address votante, uint256 candidato);
 */
    // candidato 1: tiene valor 1
    // candidato 2: tiene valor 2
    modifier verificaSiHaTerminado() {
        require(!votacionFinalizada, "Votacion ha finalizado");
        _;
    }

    function votar(uint256 candidato) public verificaSiHaTerminado {
        // if (votacionFinalizada) return;
        // require(!votacionFinalizada, "Votacion ha finalizado");

        // Usando el parámetro del tiempo
        // si un usuario llama 'votar' dentro del tiempo, que proceda
        // si un usuario llama 'votar' despues del tiempo, que lance un error
        // timestamp: es el tiempo en segundos: 16 de abril 8:45 PM (PET) => se convierte a segundos medidos desde 1970
        require(
            block.timestamp <= tiempoDeCierre,
            "Ya paso el tiempo de votacion"
        );

        // Validamos lista blanca
        require(listaBlanca[msg.sender], "No estas en la lista blanca");

        // Validadmos si ya voto antes
        require(!siYaVoto[msg.sender], "Usted ya ha votado antes");

        // Validamos que el candidato sea correcto
        require(candidato == 1 || candidato == 2, "El candidato no existe");

        // marcando en la tabla que un address ya votó
        siYaVoto[msg.sender] = true;

        // realizo la acumulación
        if (candidato == 1) {
            votosCandidatoUno++;
        } else {
            votosCandidatoDos++;
        }

        emit VotacionRealizada(msg.sender, candidato);
    }

    /*
    * 4. Cerrar la votacion y definir al ganador
        - debe impedir que alguien pueda votar (modifier)
        - definir al ganador
        - emite un evento que indica que la votacion ha finalizado
    */
    function cerrarVotacionYDefinirGanador() public onlyAdmin {
        votacionFinalizada = true;

        string memory ganador; // ""

        if (votosCandidatoUno > votosCandidatoDos) {
            ganador = "Candidato 1";
        } else if (votosCandidatoDos > votosCandidatoUno) {
            ganador = "Candidato 2";
        } else if (votosCandidatoUno == votosCandidatoDos) {
            ganador = "Empate";
        }

        emit Ganador(ganador);
    }
}
