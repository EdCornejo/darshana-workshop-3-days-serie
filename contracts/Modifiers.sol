// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

contract Modifiers {
    address owner = 0xCA420CC41ccF5499c05AB3C0B771CE780198555e;
    bool paused = false;

    /**
     * Este modifier solo permite que la funcion sea llamada por el owner
     *
     * Ello se logra a través de la comparación de la dirección del msg.sender
     * con una address guardada previamente en el contrato
     *
     * En caso que la comparación falle, se lanza un error a través
     * de un 'require' que permite detener la ejecución de la función
     */
    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Solo el owner puede llamar a esta funcion"
        );
        _;
    }

    /**
     * Este modifier solo permite que la funcion sea ejecutada
     * cuando `paused` es false. De otro modo interrumpe la
     * ejecución de la función.
     *
     * Dicho flag 'paused' puede ser cambiado a 'true' o
     * 'false' a través de la función 'pause' y 'unpause'
     *
     * Estas dos funciones están protegidas por el modifier
     * 'onlyOwner' y solo pueden ser llamadas por el owner
     */
    modifier whenNotPaused() {
        require(!paused, "El contrato esta pausado");
        _;
    }

    event SaludoGuardado(string nombre, string saludo);
    event SaludoEliminado(string nombre);
    event Paused();
    event Unpaused();

    mapping(string => string) listaSaludosPorNombre;

    function guardarSaludoPorNombre(
        string calldata _nombre,
        string calldata _nuevoSaludo
    ) public whenNotPaused {
        // guardando en el mapping;
        listaSaludosPorNombre[_nombre] = _nuevoSaludo;

        emit SaludoGuardado(_nombre, _nuevoSaludo);
    }

    function obtenerSaludoPorNombre(
        string memory nombre
    ) public view returns (string memory) {
        return listaSaludosPorNombre[nombre];
    }

    function eliminarSaludo(string memory nombre) public onlyOwner {
        delete listaSaludosPorNombre[nombre];

        emit SaludoEliminado(nombre);
    }

    function pause() public onlyOwner {
        paused = true;

        emit Paused();
    }

    function unpause() public onlyOwner {
        paused = false;

        emit Unpaused();
    }
}
