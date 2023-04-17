// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Mapping {
    /**
     * Digamos que deseo guardar en una tabla de doble entrada
     * el saludo de cada persona que me visite.
     *
     * La tabla luce como la siguiente:
     *
     *          Nombre (key)        |    Saludo (valor)
     * -----------------------------|---------------------------
     * 1. Juan                      | Hola, soy Juan
     * 2. Maria                     | Hola, soy Maria
     * 3. Jose                      | Hola, soy Jose
     * 4. Carlos                    | Hola, soy Carlos
     * 5. Alicia                    | Hola, soy Alicia
     */

    // En javascript seria así;
    //  var tabla = {}
    //  tabla["Juan"] = "Hola, soy Juan";

    //  tabla["Juan"]
    //  Hola, soy Juan

    address miAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    // Creacion de un evento: para que front o back lo escuche
    event SaludoGuardado(string nombre, string saludo);
    event SaludoEliminado(string nombre);

    mapping(string => string) listaDeSaludosPorNombre;

    // listaDeSaludosPorNombre["Juan"] = "Hola, soy Juan"

    // definir un setter (crea un metodo para guardar informacion en la tabla)
    function guardaSaludoPorNombre(
        string memory _nombre,
        string memory _saludo
    ) public {
        // Mecanismo de proteccion
        // Quiero que solo mi address pueda usar este metodo
        if (msg.sender != miAddress) {
            return;
        }

        // Al emitir un evento se guarda informacion en el Blokchcain
        emit SaludoGuardado(_nombre, _saludo);

        listaDeSaludosPorNombre[_nombre] = saludo;
    }

    // definir un getter (crea un metodo para leer informacion de la tabla)
    function leerSaludoPorNombre(
        string memory nombre
    ) public view returns (string memory) {
        // En metodos read-only o view o solo lectura no se pueden emitir eventos
        return listaDeSaludosPorNombre[nombre];
    }

    function eliminarSaludo(string memory nombre) public {
        delete listaDeSaludosPorNombre[nombre];

        emit SaludoEliminado(nombre);
    }

    function quienLlamaAlMetodo() public view returns (address) {
        return msg.sender;
    }

    modifier siNoEsMiAddress() {
        // if (msg.sender != miAddress) return;

        // require
        // Si el lado izquierdo es true, continua con lo demás operaciones
        // si el lado izquierdo es false, interrumpe la operacion
        require(msg.sender == miAddress, "No eres una persona autorizada");
        _; // ahora ejecura el cuerpo del metodo
    }

    function guardarSaludoProtegido(
        string memory _nombre,
        string memory _saludo
    ) public soloAdmin {
        // cuerpo del metodo
        listaDeSaludosPorNombre[_nombre] = _saludo;
    }

    // 1. Es como un metodo que solamente se ejecuta una sola vez en toda la vida del smart contract
    // 2. Se utiliza para inicializar variables. Si no se inicializa en el constructor, tendrias que crear metodos setter

    address admin;
    string saludo;

    constructor() {
        // dentro del constructor, mesg.sender captura el address de la persona que publica el contracto
        admin = msg.sender;
        saludo = "Hola";
    }

    modifier soloAdmin() {
        require(msg.sender == admin);
        _;
    }
}
