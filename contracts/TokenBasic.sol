// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract TokenBasic {

    string public constant name = "PichulaCoin";
    string public constant symbol = "PCN"; //va de 3 a 5 letras
    uint public constant decimals = 18; //un balance de este token puede ser escrito hasta 18 decimales

    uint256 _totalSupply; //va a almacenar cuantos tokens vamos a utilizar para su distribución

    mapping(address => uint256) balances; //va a almacenar dependiendo la wallet cuantos tokens va a tener en su balance
    mapping(address => mapping(address => uint256)) allowed; //lo que registra este es una wallet a y una wallet b, significa que la a permite que la b de gestionar cierta cantidad de tokens que le pertenece

    event Transfer(address indexed _from, address indexed _to, uint256 _value); //el evento que se va a ejecutar cuando se pase la coin de una cuenta a otra
    event Approval(address indexed _owner, address indexed _spender, uint256 _value); //se ejecuta cada vez que el owner permita a un spender de gestionar sus tokens

    constructor(uint256 total){
        _totalSupply = total;
        balances[msg.sender] = total; //vamos a asignar toda la cantidad de tokens que hemos generado a nuestra cuenta
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    } 

    function balanceOf(address _owner) public view returns (uint) { //nos va a devolver cual es el balance de una cuenta que pasamos en los parametros de una funcion, cuantos tokens le pertenecen a esta cuenta
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success){ //va a transferir los tokens de la wallet que llama a la funcion a una wallet _to, que va a recibir estos tokens, tambien le vamos a pasar la cantidad de tokens que queremos transferir
        require(_value <= balances[msg.sender], "There are not enough funds to do the transfer"); //Se valida la cuenta que tenemos la cantidad de coins para mandar a la cuenta que recibe
        balances[msg.sender] = balances[msg.sender] - _value; //aqui se actualiza el valor de los balances del owner
        balances[_to] = balances[_to] + _value; //aqui se actualiza la cuenta del usuario
        emit Transfer(msg.sender, _to, _value); //lanzamos nuestro evento de transfer
        success = true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success){ //permite a un spender gestionar una cantidad de tokens
        allowed[msg.sender][_spender] = _value; //cual es esa wallet a que permite a la wallet b gestionar cuantos tokens
        emit Approval(msg.sender, _spender, _value); //lanzamos nuestro evento de approval cual es la informacion del approval
        success = true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        remaining = allowed[_owner][_spender]; //cuantos tokens quedan a esa wallet que fue autorizada por la wallet owner

    }

    function transferFrom(address _from, address _to, uint256 _value) public returns(bool success){ //nos permite transferir tokens de una cuenta a otra cuenta

        require(_value <= balances[_from], "There are not enough funds to do the transfer"); //vamos a validar que tenemos los tokens suficientes para hacer la transferencia
        require(_value <= allowed[_from][msg.sender], "Sender not allowed"); //vemos si esta autorizado por esa cuenta from para gestionar una cantidad de tokens

        balances[_from] = balances[_from] - _value; //restamos del balance 
        allowed[_from][msg.sender] = allowed[_from][msg.sender] - _value; //actualizamos la cantidad de token que tenemos
        balances[_to] = balances[_to] + _value; //añadimos a la cuenta la que recibe la transferencia esa cantidad de tokens que hemos transferido
        emit Transfer(_from, _to, _value);
        success = true;
    }
}