# DARSHANA - APRENDE SOLIDITY DESDE 0

![image](https://user-images.githubusercontent.com/3300958/225121040-c8d007f5-38f1-4abe-8a6a-a4e9c364c4ea.png)

## **Ponente - LEE MARREROS**

Fundador de la escuela online **Blockchain Bites** (programación para el Blockchain). Conferencista, escritor y profesor en tópicos de Blockchain. Cofundador del juego [Pachacuy.io](http://pachacuy.io/) (El Axie Infinity de South America). Desarrollador Blockchain en [CuyToken.com](http://cuytoken.com/), la primera empresa de criptocréditos del Perú. 5+ años de experiencia en compañías Fintech (e.g. Yodlee, Tenpo, FIDIS, CuyToken y dcSpark). Estudió Computer Programming Certificate en la Universidad de Santa Clara, California, USA. Graduado del bootcamp del programa inmersivo de Ingeniería de Software Hack Reactor, Los Ángeles. Graduado de Lean UX and Service Design Program (UTEC) y del diplomado de Finanzas Corporativas (UPC).



## Únete a nuestra comunidad

[Discord](https://discord.gg/s5HRnGEG)

[LinkedIn](https://www.linkedin.com/company/blockchain-bites-es/)

[MeetUp](https://www.meetup.com/blockchain-bites)

[Bootcamp 15 días (3 julio)](https://www.meetup.com/blockchain-bites/events/292916827/)

## **Objetivo**

En esta clase exploraremos el blokchain de Ethereum para comprender su uso y funcionamiento a alto nivel. Explicaremos la relevancia de los Contratos Inteligentes para luego crearlos usando el lenguaje de programación Solidity. Finalmente, explicaremos el papel que juegan que las billeteras (e.g. Metamask) de Cryptomonedas para la publicación de Contratos Inteligentes y el procesamiento de las transacciones que se realizan en dichos contratos.

### Temario

1. Requisitos
2. Partes constitutivas del Blockchain
3. Máquina Virtual de Ethereum (EVM)
4. Programando en Solidity
   1. Mi Primer Contrato en Solidity
      1. Layout de un smart contract
      2. Definición de funciones
   2. Publicando un Smart Contract
   3. Verificando un Smart Contract
   4. Hash Table en Solidity
   5. Eventos
   6. Modifiers
5. Creación de un token ERC20 usando la herramienta `Contracts Wizard` de Open Zeppelin

### Requisitos

1. Repositorio y Sistema

   - Node version 14.x. Usar nvm para intalar otras versiones de `nodeJS`

   - Hacer fork del [repositorio de la clase](https://github.com/steveleec/darshana-conferencia)
   - Ubicarte en el branch `setUp` y luego instalar los paquetes de NPM
     - `$ git checkout setUp`
     - `$ npm install`
   - Abrir un terminal en la carpeta raíz. Correr el siguiente comando y verificar errores:
     - `$ npx hardhat compile`

2. Billetera y Matic

   - Instalar extensión de Metamask en Navegador. Crear cuenta. Habilitar una billetera en Metamask. Cambiar a la red `Mumbai`. Enviar `Matic` a la billetera creada usando el `address` de la billetera. Para solicitar `Matic`, ingresar a [Polygon Faucet](https://faucet.polygon.technology/). Recibirás un balance en `Matic`

3. Añadir Mumbai a Metamask

   1. Dirigirte a [Polygon Scan](https://mumbai.polygonscan.com/)

   2. Hacia el final de la página buscar el botón `Add Mumbai Network`

   3. Se abrirará una ventana de Metamask. Dar confirmar y continuar hasta que se efectúe el cambio de red

4. Crear archivo de Secrets `.env` duplicando el archivo `.env-copy`

   - `$ cp .env-copy .env`

5. Rellenar las claves del archivo `.env`:

   - `API_KEY_POLYGONSCAN`: Dirigirte a [PolygonScan](https://polygonscan.com/). Click en `Sign in`. Click en `Click to sign up` y terminar de crear la cuenta en Polygon Scan. Luego de crear la cuenta ingresar con tus credenciales. Dirigirte a la columna de la derecha. Buscar `OTHER` > `API Keys`. Crear un nuevo api key haciendo click en `+ Add` ubicado en la esquina superior derecha. Darle nombre al proyecto y click en `Create New API Key`. Copiar el `API Key Token` dentro del archivo `.env`.
   - `PRIVATE_KEY`: Obtener el `private key` de la wallet que se creó en el punto `2` siguiendo [estos pasos](http://help.silamoney.com/en/articles/4254246-how-to-generate-ethereum-keys#:~:text=Retrieving%20your%20Private%20Key%20using,password%20and%20then%20click%20Confirm.) y copiarlo en esta variable en el archivo `.env`.
   - `MUMBAI_TESNET_URL`: Crear una cuenta en [Alchemy](https://dashboard.alchemyapi.io/). Ingresar al dashboard y crear una app `+ CREATE APP`. Escoger `NAME` y `DESCRIPTION` cualquiera. Escoger `ENVIRONMENT` = `Development`, `CHAIN` = `Polygon` y `NETWORK` = `Mumbai`. Hacer click en `VIEW KEY` y copiar el valor dentro de `HTTPS` en el documento `.env` para esta variable de entorno. Saltar el paso de pago del servicio.

6. Comprobar que no hay ningún error ejecutando el siguiente comando:

   - `$ npx hardhat --network mumbai run scripts/deploy.js`
   - Esperar de 2 a 3 minutos mientras se hace el deployment.
   - Si todo fue correctamente ejecutado, se verá el siguiente resultado:

   ```bash
   MiPrimerContrato se publicó en 0xE6Cc58D83aea8BAfE847A0545DdbB17528Dcafc9
   Nothing to compile
   Successfully submitted source code for contract
   contracts/MiPrimerContrato.sol:MiPrimerContrato at 0xE6Cc58D83aea8BAfE847A0545DdbB17528Dcafc9
   for verification on the block explorer. Waiting for verification result...

   Successfully verified contract MiPrimerContrato on Etherscan.
   https://mumbai.polygonscan.com/address/0xE6Cc58D83aea8BAfE847A0545DdbB17528Dcafc9#code
   ```

7. Razones por las cuales el comando anterior podría fallar

   - El archivo `.env` no tiene las claves correctas
   - La llave privada de la billetara de Metamask no cuenta con los fondos suficientes
   - `NodeJS` es una versión antigua

## **Blockchain Framework:**

![image-20221001173609057](https://user-images.githubusercontent.com/3300958/193497008-44d89e72-3b9d-413c-af32-68bc8a3a5b54.png)

1. Transacción: unidad fundamental dentro de un blockchain. Cualquier operación llevada a cabo se atomiza en una transacción que es enviada por un usuario para ser incluida en el siguiente blocke.
2. Wallet: Es como una cuenta de banco. Se usa para ejecutar transacciones. Así mismo, una wallet puede llevar la cuenta de los activos de una dirección (address). La wallet en sí misma no almacena los activos, solo muestra los balances.
3. Signature: Una firma digital por el usuario es necesaria firmar una transacción antes de que sea incluida en la network,
4. Mempool: Luego de que una transacción es firmada, se incluye en la Mempool. Este es el lugar donde todas las transacciones esperan por un validador para que puede incluirlo en el bloque.
5. Network: la naturaleza de la red de nodos que mantiene en pie al Blockchain es distribuida. Cualquiera está en la posibilidad de obtener una copia desde la primera hasta la última transacción del Blockchain (no centralización de la información). Bajo este modelo, la red es capaz de determinar qué transacciones son válidas.
6. Consensus: Es una manera de crear un mecanismo de votación entre los nodos. PoS, PoW.
7. Hashing: es el proceso de generar una huella digital única. Se utilizan funciones que hacen Hash cuyo input es la data. Un cambio infinitesimal en la data y el hash obtenido es completamente diferente. Ello invalidaría al bloque.
8. Block: Es un contenedor de todas las transacciones que se añadirán al blockchain. Estos bloques están linkeados unos con otros mediante valores de hash.
9. Blockchain: Es un libro público en el cual los bloques están linkeados, lo cual nos permite ver si las transacciones son validas o no.

## **Ethereum Virtual Machine**

**_Ambiente virtual_**

EVM significa Máquina Virtual de Ethereum. En simple, EVM es el sistema operativo de Ethereum. Dentro de esto, una máquina virtual puede proporcionar un entorno de ejecución para ejecutar contratos inteligentes.

Por lo general, una vez que se compila un contrato inteligente, genera dos salidas: Bytecode y ABI. El primero se carga en el EVM para el cálculo. El segundo es más legible por humanos. El código de bytes se distribuye a cada nodo que se ejecuta dentro de la red. El código de bytes se ejecuta y genera un "cambio de estado", que solo podría lograrse mediante el consenso de cada nodo. Eso convierte a la EVM en una "máquina de estado distribuida": rastrea el estado del Blockchain en cada transacción.

Existen diferentes lenguajes de programación que pueden ser entendidos por la EVM (Solidity, Vyper, etc.).

**_Computadora Mundial_**

La máquina virtual de Ethereum funciona como una sola entidad mantenida por miles de computadoras interconectadas llamadas nodos, que también se conoce como la computadora mundial. Estas computadoras ejecutan una implementación del cliente Ethereum y tienen una estructura de igual a igual (Peer to Peer - P2P). Su trabajo principal es procesar y validar transacciones, así como asegurar y estabilizar todo el ecosistema. Por eso, el EVM podría verse como un motor de procesamiento y una plataforma de software que utiliza computación descentralizada.

**_Estado de la cadena de bloques_**

Dentro de la EVM se definen las reglas para crear un nuevo estado válido de bloque a bloque. Una vez que se ejecutan los contratos inteligentes, el EVM calcula el nuevo estado de la red después de agregar un nuevo bloque a la cadena. En cualquier momento dado, la EVM tiene un y solo un estado 'canónico'. Es en este entorno que viven las cuentas de Ethereum y los contratos inteligentes. El protocolo Ethereum tiene como objetivo mantener esta máquina especial realizando operaciones ininterrumpidas.

En otras palabras, el objetivo de EVM es averiguar el estado general de Ethereum para cada bloque en el Blockchain. Utiliza un libro mayor (public ledger) distribuido donde se rastrean las transacciones y, al mismo tiempo, impone reglas a los usuarios sobre cómo interactuar con la red.

**_Capa_**

Se encuentra en la parte superior de la capa de red de nodos y hardware de Ethereum.

**_Turing completo_**

Puede realizar pasos lógicos para la función computacional. Es capaz de hacer cualquier cálculo o programa informático posible. Detrás de esta característica se encuentran los OPCODES que son como una lista operaciones aisladas que arman como piezas de lego.

**_Gas_**

A cada instrucción de EVM se le asigna un costo. Eso ayuda a mantener un recuento de los costos totales de cualquier transacción determinada. Las unidades de gas miden el costo de ejecutar operaciones en EVM. Para calcular el total de gas a gastar se cuentan el total de OPCODES a usar dado que cada uno de ellos tiene un costo espécifico. Cualquier transacción empieza en 21000 gas.

**_OPCODES (códigos de operación)_**

El EVM es capaz de ejecutar instrucciones a nivel de máquina conocidas como OPCODES (códigos de operación). Estos códigos de operación se utilizan para definir cualquier operación particular dentro del EVM. Hay códigos de operación especiales para operaciones aritméticas, así como para leer desde el almacenamiento. Cada código de operación es un byte. Se puede utilizar un máximo de 256 códigos de operación. [Ver lista completa](https://ethereum.org/en/developers/docs/evm/opcodes/).

![image-20221001194415274](https://user-images.githubusercontent.com/3300958/193497004-445908d4-23d9-4054-acaf-2f455a784a26.png)

**_Contratos inteligentes_**

Los contratos inteligentes son líneas de código utilizadas por diferentes dos o más partes para realizar transacciones entre sí. Dado que los contratos inteligentes se cargan y ejecutan en el EVM, no se necesita un tercero fiscalizador. Un contrato inteligente es una lista de operaciones que se ejecutarán cuando se cumplan ciertas condiciones. Estas operaciones pueden ser muy diferentes (por ejemplo, creación de tokens, transferencia de fondos) y estarán guiadas por código y ejecutados por máquina.

**_Bytecode_**

![image-20221001200726257](https://user-images.githubusercontent.com/3300958/193497003-3d281061-3387-4ce1-b9c0-bca9b56d0bb6.png)

El Smart Contract se compila a bytcode y ABI. El bytecode se puede traducir en OPCODES.

[Ver ejemplo de NFT del juego Pachacuy](https://polygonscan.com/address/0xc9Fd34bDA1965f2965C5238838EbB230482167B0#code)

**_ABI (application binary interface)_**

![image-20221001202149628](https://user-images.githubusercontent.com/3300958/193497002-f9fa12d0-e1cb-47b6-8019-fce5682d79e2.png)

Usado por el front para poder instanciar el objeto 'Contrato' de las librerías como Ethers.js. Es una interface en el cual se definen qué parámetros serán pasados, qué valores ser retornarán, nombres de los métodos y otras características de los métodos y propiedades del smart contract.

## **Stack (tooling) de desarrollo web 3**

Las herramientas de un blockchain developer son variadas e incluyen herramientas de testing, auditoría, computación en la nube y demás. Estas son las herramientas que uso en mi día a día como desarrollador blockchain:

- Hardhat
- Ethers.js
- Metamask
- Gnosis safe
- Open Zeppelin (standards)
- Open Zeppelin Defender
- Remix
- Mythril (by ConsenSys)
- Alchemy/Infura/Moralis
- Etherscan
- Solidity
- Faucets
- MythX

## **Programando en Solidity**

Vamos a aprender a programar en Solidity con el objetivo de desarrollar una startup ficticia que desea llevar al mercado sus NFTs. A medida que aprendemos Solidity, iremos desarrollando diferentes Smart Contracts requeridos.

El primer Smart Contract que vamos a desarrollar será la criptomoneda (token ERC20) de la empresa que será publicado en una Testnet llamada Goerli. Antes de lograr ello, revisemos algunos conceptos sobre Solidity.

**_¿Qué es Solidity?_**

- Es un lenguaje orientado a objetos
- Lenguaje de alto nivel para la implementación de Smart Contracts
- "El código es la ley": un smart contract luego de publicado imposibilita su modificación y se ejecuta por una máquina tal cual fue redactado
- Lenguaje de llaves diseñado para desarrollar código compatible con la Máquina Virtual de Ethereum (EVM)
- Influenciado por C++, Python y Javascript
- Es estáticamente tipado, soporta la herencia (de objetos), librerías y definición de tipos de datos complejos definidos por el usuario

**_Dos tipo de cuentas en Ethereum_**

![image-20221001222155465](https://user-images.githubusercontent.com/3300958/193497001-1ad024fe-ed54-4ead-a926-b45d7c58bdb1.png)

- EOA (Externally owned account): Son usuarios (personas) que posee una llave privada. No posee código. Pueden mantener un balance positivo de Ether. Firma transacciones. Puede transferir activos (assets).
- SCA (Smart Contract Account): Son cuentas controladas por código dentro del Smart Contract.

**_Mi primer contrato en Solidity_**

1_MyFirstContract

En [Remix](https://remix.ethereum.org/), crear un nuevo archivo llamada

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0;

contract MiPrimerContrato {
    string saludo;

    function set(string memory _nuevoSaludo) public {
        saludo = _nuevoSaludo; // no se necesita 'this'
    }

    function get() public view returns (string memory) {
        return saludo;
    }
}
```

- La primera línea nos indica la licencia del código a ser publicado de una manera en que la máquina puede entender. Imprescindible cuando se desea publicar el contrato en una red blockchain.
- La siguiente línea nos indica la versión de Solidity en la cual el código fue escrito. La palabra clave `pragma` hace referencia a instrucciones para que el compilador sepa cómo tratar el código. Cada versión de compilador podría generar un diferente output con respecto al anterior. Al especificiar versiones te aseguras compile como lo especificas según las versiones.
- Un contrato es una colección de código y estado (code + state) que vive dentro de una dirección específica en el Blokchain. En este contrato definimos una variable llamda `saludo` del tipo `string`. Se puede entender esta variable como si fuera una entrada en una base de datos que se puede consultar (usando `get`) y modificar (mediante `set`).

La gran diferencia de escribr este mismo código en otro lenguage de programación, como Javascript, es que para lograr lo mismo tendríamos que levantar un servidor y una base de datos. Además de la creación de la clase (Class - ES6) que lleve los mismo métodos, se requiriría métodos para poder guardar y leer información de la base de datos. Ello sin contar la creación de la conexión con la base de datos.

Usando Smart Contracts, el "servidor" y la "base de datos" están dados por la Máquina Virtual de Ethereum (EVM). Las lecturas y escrituras a raíz de la ejecución del código, se hace desde y sobre el blockchain.

**_Publicar el Smart Contract_**

1. Para publicar el contrato usar Metamask en la red Testnet de Goerli. Previamente solicitar Ether en algún [faucet de Goerli](https://goerlifaucet.com/).

![image-20221002063129132](https://user-images.githubusercontent.com/3300958/193497000-4ac8b832-d990-4631-8f83-d303c4b27494.png)

2. En `ENVIROMENT` escoger `Injected Provider - Metamask`, lo cual conectará el IDE de Remix con una billetera de Metamask.
3. En `CONTRACT` asegurar que está seleccionado el contrato que se desa publicar
4. Al hacer clic en `Deploy`, abrirá un pop-up de Metamask para poder confirmar y firmar la transacción, lo cual hará posible la creación del Smart Contract en el Blockchain.

<img src="https://user-images.githubusercontent.com/3300958/193496997-8adc83b8-bc59-446e-b748-add08ad19be0.png" alt="image-20221002063404065" style="zoom:30%;" />

5. Cuando la transacción haya terminado, se podrá visualizar dentro de la pestaña de `Actividad`. Hacer click en `Implementación de contrato` y se abrirá otra ventana. En dicha ventana hacer click en `Ver en el explorador de blockes`.

<img src="https://user-images.githubusercontent.com/3300958/193496996-6e1893fe-7356-4f8f-9626-6e8d978efb3a.png" alt="image-20221002065253371" style="zoom:30%;" />

6. Serás dirigido a Goerli.etherescan.io donde podrás ver los detalles de la transacción (publicación del Smart Contract). Se puede observar que el contrato ha sido creado en la siguiente dirección: `0xc5bccf767704432a3a22318a0df3067d9a3fc217`. Esta misma dirección servirá para hacer su posterior verificación.

![image-20221002070341543](https://user-images.githubusercontent.com/3300958/193496993-ecfc7741-1d7e-4e69-a7ec-2e07f0b593b3.png)

**_Verificación de un Smart Contract_**

1. Para verificar, hacer click en la dirección del contrato creado en el anterior paso. O en su defecto, ir al siguiente link `https://goerli.etherscan.io/address/0xc5bccf767704432a3a22318a0df3067d9a3fc217`, del cual la última parte será reemplazada por la dirección (address) de tu contrato.

![image-20221002071148343](https://user-images.githubusercontent.com/3300958/193496991-3ff9fb42-5b9b-4442-8e88-30999e588e1e.png)

2. Hacer click en la pestaña `Contract` que te permitirá ver el bytecode generado del Smart Contract. Para verificar, hacer clic en `Verify and Publish`.

![image-20221002072149755](https://user-images.githubusercontent.com/3300958/193496987-b6646c29-213c-470d-a925-2fe2a33a7a07.png)

3. Se abrirá una lista de opciones que tienen que ser llenadas de la siguiente manera: address del smart contract, Single File, versión del compilador (debe ser la misma usada en Remix), MIT de licencia.

![image-20221002072916426](https://user-images.githubusercontent.com/3300958/193496585-8fbdb073-48b2-407c-8308-45be845286d1.png)

4. En esta ventana copias y pegas el código de Remix. Verificas el CAPTCHA. Luego clic en `Verify and Publish`.

![image-20221002074129280](https://user-images.githubusercontent.com/3300958/193496578-46b72f49-0855-4915-acfb-67d2c78d3832.png)

4. Si todos los valores fueron incluidos correctamente, se verá el siguiente resultado:

![image-20221002073334433](https://user-images.githubusercontent.com/3300958/193496583-67848f32-7e90-48a2-b7dc-b727020e191a.png)

6. Al dirigirte a tu contrato en Goerli.etherscan.io con el siguiente link `https://goerli.etherscan.io/address/0xc5bccf767704432a3a22318a0df3067d9a3fc217`, del cual la última parte será reemplazada por la dirección (address) de tu contrato, podrás (1) encontrar el código del Smart Contract, (2) interactuar con el contrato directamente (`Read Contract` y `Write Contract`) y (3) observar otros detalles del mismo.

![image-20221002073616250](https://user-images.githubusercontent.com/3300958/193496581-80b79e6a-78df-4718-9c28-fb779aaabf85.png)

**_Hash table en contratos inteligentes_**

La estructura de datos llamado mapping es uno de los más usados en Solidity. `mapping(_KeyType => _ValueType)` Es el equivalente a un Hash Table o un objeto (`var obj = {}`) en Javascript. A cada `key` le corresopnde un `value` dentro del mapping.

![image-20221002122245338](https://user-images.githubusercontent.com/3300958/193496570-606c0ff9-4e69-4fe0-92af-24c07e9de6c0.png)

`_KeyType` no puede ser otro mapping, struct o array. `_ValueType` puede ser de cualquier tipo, incluyendo mapping, arrays y structs.

Un `mapping` empieza con una inicialización de todos los posibles valores de `_KeyType` que están mapeados a un valor por defecto que es 0. Además, con `mapping` no se lleva la cuenta de los keys cuyos valores sea 0. Ello justamente impide que no se pueda borrar un `mapping` a menos que se sepa el `key`.

Los `mapping`s solo pueden tener un tipo de ubicación de información: `storage`. No se pueden usar `mapping`s como parámetros de una función o como el valor de retorno.

Un `mapping` no tiene longitud (`length`), como lo puede tener un array. Un `mapping` tampoco es iterable porque no hay manera de conocer sus `key`s mediante ningún método. Se puede guardar las llaves del `mapping` en otro array para poder iterar luego.

En el siguiente ejemplo se incluye un `mapping` para guardar una lista de saludos en el cual el `_KeyType` se va incrementando en uno a medida que la función `set` es llamada.

2_Mapping

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0;

contract MiPrimerContrato {
    string saludo; // empieza como un string vacío ('') por definición

    uint256 counter; // empieza en zero por definición
    mapping(uint256 => string) listaSaludos;

    function set(string memory _nuevoSaludo) public {
        saludo = _nuevoSaludo;

        // guardando en el mapping;
        listaSaludos[counter] = _nuevoSaludo;
        counter++; // counter += 1; // counter = counter + 1;
    }

    function get() public view returns (string memory) {
        return saludo;
    }
}
```

**_El tipo de data `Address`_**

Cada EOA (externally owned account) y Smart Contract Account tiene una dirección (`address`). Se guarda como un valor de 20 bytes (160 bits o 40 caractéres hexadecimales). Siempre se le prefija el `0x` por el formato hexadecimal. Es usado para enviar y recibir Ether, así como también otras criptomonedas no nativas.

Ejemplo: 0x5387ddeec8ddC004a217d8e172241EB5F900B302

Puede ser considerado como una indentidad pública en el Blockchain, más como un seudónimo. Para ser más preciso, se puede entender como una cuenta de banco. En el mismo modo en que necesitas una cuenta de banco para recibir y enviar dinero, se usará el `address` para enviar y/o recibir dinero, además de realizar transacciones.

En lo sucesivo se usará `address` como identificador único de un usuario involucrado en realizar alguna transacción dentro del Smart Contract.

Supongamos que deseamos asociar la edad (`uint256`) de cada usuario con su `address`. Para ello usaremos un mapping:

3_MappingEdad

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0;

contract MiPrimerContrato {
    string saludo; // empieza como un string vacío ('') por definición

    uint256 counter; // empieza en zero por definición
    mapping(uint256 => string) listaSaludos;

    // mapping address a edad
    mapping(address => uint256) public edadPorAddress;

    function set(string memory _nuevoSaludo) public {
        saludo = _nuevoSaludo;

        // guardando en el mapping;
        listaSaludos[counter] = _nuevoSaludo;
        counter++; // counter += 1; // counter = counter + 1;
    }

    function get() public view returns (string memory) {
        return saludo;
    }

    function setEdadPorAddress(address _account, uint256 _edad) public {
        edadPorAddress[_account] = _edad;
    }
}
```

El método `setEdadPorAddress` nos ayuda a maper un `address` a una `edad` en particular.

Cabe resaltar que la palabra clave `public` se ha utilizado cuando se define el mapping de `edadPorAddress`. Al usar esta palabra clave, Solidity, automáticamente, ha creado un getter. Sin la palabra clave `public`, se tendría que añadir el siguiente código:

```solidity
    function getEdadporAddress(address _account) public view returns (uint256 _edad) {
        return edadPorAddress[_account];
    }
```

Tipos de llaves (key) and valores (value) permitidos:

`mapping(keyType => ValueType) mappingName;`

![image-20221005060109568](https://user-images.githubusercontent.com/112733805/194439375-8ad58d9c-e895-4eb7-9238-11f953a32068.png)

El doble mapping es Smart Contracts es usando frecuentemente y cabe ahondar en su entendimiento y uso. Si hablamos de base de datos, esta relación podría considerarse _one-to-many_. Veamos el siguiente ejemplo:

3_5_DoubleMapping

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0;

contract DoubleMapping {
    // Queremos llevar una contabilidad de las deudas de cada persona (usando su nombre)
    // Esto requiere de un simple 'mapping' que asocia string => uint256
    mapping(string => uint256) saldos;

    function fijarSaldo(string memory _name, uint256 _saldo) public {
        saldos[_name] = _saldo;
    }

    function leerSaldo(string memory _name) public view returns (uint256) {
        return saldos[_name];
    }

    /**
     Realizar las siguientes operaciones
     1. Registrar que Lee tiene un saldo de 10,000
     2. Registrar que Jen tiene un saldo de 100,000

     Desarrollo:
     fijarSaldo("Lee", 10000)
     fijarSaldo("Jen", 100000)
     */

    // Queremos llevar la contabilidad de cuanto debe una persona a otra usando su nombre
    // Esto require de un doble mapping porque una persona puede deber a varias personas
    //  Lee -> Carmen: debe 100
    //  Lee -> Jen: debe 200
    //  Lee -> Lea: debe 300
    //  Carmen -> Lee: 200
    //  Carmen -> Jhon: 400
    mapping(string => mapping(string => uint256)) saldosMatrix;

    function fijarSaldoMatrix(
        string memory acreedor, // al que se le debe
        string memory deudor, // el que debe
        uint256 amount
    ) public {
        saldosMatrix[acreedor][deudor] = amount;
    }

    function leerSaldoMatrix(
        string memory acreedor, // al que se le debe
        string memory deudor // el que debe
    ) public view returns (uint256) {
        return saldosMatrix[acreedor][deudor];
    }

    /**
     Desarrollo:
        fijarSaldoMatrix("Carmen", "Lee", 100);
        fijarSaldoMatrix("Jen", "Lee", 200);
        fijarSaldoMatrix("Lea", "Lee", 300);
        fijarSaldoMatrix("Lee", "Carmen", 200);
        fijarSaldoMatrix("Jhon", "Carmen", 400);
     */
}
```

Limitaciones de la estructura de datos `mapping`:

- Existe un conjuto de typos definidos para ser usados en la llave (`KeyType`) del mapping
- No se puede iterar sobre un `mapping` porque virtualmente todas las llaves son inicializadas. Tampongo un `mapping` tiene longitud.
- Tampoco es posible solicitar todas las llaves del `mapping`, por la razón anterior.
- Un `mapping` no se puede usar como valor de retorno de una función.

**_Propagación de un Error vía `require` o `revert`_**

`require` o `revert` en Solidity es usado para validar ciertas condiciones dentro del código y lanzar una excepción si dicha condición no es cumplida. Esto es importante para prevenir la finalización de una transacción si se detecta una condición indeseada.

Cabe mencionar que esta propagación del error será notada por el usuario en el front-end (dApp) antes de firmar una transacción mediante su billetera (de Metamask u otra).

Veamos cómo aplicamos `require` o `revert` en el código:

4_ErroRevert.sol

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0;

contract MiPrimerContrato {
		//...

    function setEdadPorAddressManejaError(address _account, uint256 _edad)
        public
    {
        require(_edad >= 30, "Edad menor a 30");
        edadPorAddress[_account] = _edad;
    }

    function setEdadPorAddressManejaError2(address _account, uint256 _edad)
        public
    {
        if (_edad <= 29) {
            revert("Edad menor a 30");
        }
        edadPorAddress[_account] = _edad;
    }
}
```

`revert` y `require` propagarán el error si es que no cumple las condiciones allí definidas. La única diferencia entre uno y otro es que `require` lleva el condicional y el mensaje de error como argumentos de un método. En cambio, `revert` ofrece mayor flexibilidad para validar y plantear las condiciones a cumplir. `revert` solo lleva como argumento el mensaje del error.

Ejemplo de cómo se vería un error en producción [link](https://mumbai.polygonscan.com/tx/0xc96a8ad2c078065dae2c1fb02cf2590870346e17c5055e5ddc4637eb3f85d977):

![image-20221005063900106](https://user-images.githubusercontent.com/112733805/194439364-dad1caf3-0c8f-47d6-aca6-c12587945d4e.png)

**_Usando eventos a modo de notificación_**

`Events` dentro de Solidity son disparados cuando algún metodo en particular es ejecutado. Los eventos pueden llevar información adicional para explicar lo que esá sucediendo. Normalmente, el nombre del evento seguido de la información que contiene, explica muy bien un suceso dentro del blockchain.

Los eventos disparados desde un Smart Contract son prograpagos en el Blockchain. Dichos eventos quedan registrados por siempre. En un futuro se pueden hacer queries de eventos disparados anteriormente. Incluso se puede usar para almacenar información de manera económica. Estos eventos pueden ser captados desde el front-end en un dApp si se establece una conexión.

5_Events.sol

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0;

contract MiPrimerContrato {
    string saludo; // empieza como un string vacío ('') por definición

    uint256 counter; // empieza en zero por definición
    mapping(uint256 => string) listaSaludos;

    // mapping address a edad
    mapping(address => uint256) public edadPorAddress;

    // Eventos
    // 1 - Disparar un evento cada vez que se cambia el saludo
    // _account - address de la persona que está llamando el método
    // _nuevoSaludo - string que representa al nuevo saludo
    event CambioDeSaludo(address _account, string _nuevoSaludo);

    // 2 - Disparar un evento cuando se asocia un 'address' con una edad
    // _account - address para el cual se asocia la edad
    // _edad - nueva edad para asociar con un address
    event NuevaEdadParaAddress(address _account, uint256 _edad);

    function set(string memory _nuevoSaludo) public {
        saludo = _nuevoSaludo;

        // guardando en el mapping;
        listaSaludos[counter] = _nuevoSaludo;
        counter++; // counter += 1; // counter = counter + 1;
        emit CambioDeSaludo(msg.sender, _nuevoSaludo);
    }

    function get() public view returns (string memory) {
        return saludo;
    }

    function setEdadPorAddress(address _account, uint256 _edad) public {
        edadPorAddress[_account] = _edad;
        emit NuevaEdadParaAddress(_account, _edad);
    }
}
```

Ejemplos de eventos propagados en la red [link](https://polygonscan.com/address/0x54FC36444355602Fb110842411D3b0E6C4F1Cfd6#events).

![image-20221005063541888](https://user-images.githubusercontent.com/112733805/194439372-2e95a90d-1d59-4c92-8e45-9f7746906317.png)

**_msg.sender_**

Es la cuenta (address) que llama o ha ejecutado una función (de smart contract) o ha creado una transacción.

Esta cuenta (address) puede ser una dirección de un contrato (CA) o una persona como nosotros (EOA).

`msg.sender` funciona como una variable global dentro de Solidity y puede ser usada dentro de los métodos del Smart Contract como una variable ya definida.

Otras variables globales en Solidity [link](https://docs.soliditylang.org/en/v0.8.9/cheatsheet.html?highlight=global%20variables#global-variables).

5_5_MsgSender.sol

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0;

contract MiPrimerContrato {
    // ...
    address caller;
    function setCaller() public returns(address) {
        caller = msg.sender;
        return msg.sender;
    }
}
```
