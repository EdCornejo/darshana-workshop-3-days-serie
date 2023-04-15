// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

contract Modifier2 {
    // Ejemplo de cómo es la manera más segura dado que valida antes de proseguir
    function todoEnOrden() public pure returns (bool) {
        // ejecuta las validaciones necesarias
        return true;
    }

    function estaAutorizado() public pure returns (bool) {
        // ejecuta las validaciones necesarias
        return true;
    }

    modifier SoloSiTodoEnOrdenYAutorizado() {
        require(todoEnOrden());
        require(estaAutorizado());
        _;
    }
}
