// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

contract Events {
    event SaludoGuardado(string nombre, string saludo);
    event SaludoEliminado(string nombre);

    mapping(string => string) listaSaludosPorNombre;

    function guardarSaludoPorNombre(
        string calldata _nombre,
        string calldata _nuevoSaludo
    ) public {
        // guardando en el mapping;
        listaSaludosPorNombre[_nombre] = _nuevoSaludo;

        emit SaludoGuardado(_nombre, _nuevoSaludo);
    }

    function obtenerSaludoPorNombre(
        string memory nombre
    ) public view returns (string memory) {
        return listaSaludosPorNombre[nombre];
    }

    function eliminarSaludo(string memory nombre) public {
        delete listaSaludosPorNombre[nombre];

        emit SaludoEliminado(nombre);
    }
}
