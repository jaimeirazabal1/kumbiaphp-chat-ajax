<?php

/**
 * Controller por defecto si no se usa el routes
 * 
 */
Load::models("usuario","canal");
class IndexController extends AppController
{

    public function index()
    {
        
    }
    public function chat(){
    	$this->title = 'Ventana de chat';
    }
    public function chat_admin(){
    	$this->title = 'Ventana de chat administrador';
    }
    public function sala(){
    	// http://gravatar.com/avatar/
    	$this->title = 'Sala de Asistencia';
    	if (Input::post("nombre") and Input::post("email") and Input::post("ayuda")) {
    		$usuario = new Usuario();
    		$usuario->nombre = Input::post("nombre");
    		$usuario->email = Input::post("email");
    		$usuario->online = 1;
    		if ($usuario->save()) {
    			$id = $usuario->find('columns: id','limit: 1','order: id desc');
    			$canal = new Canal();
    			$this->imagen = $this->get_gravatar($this->email);
    			$imagen = "<img style='float:left;padding:4px;' src='".$this->imagen."' width=\"50\" alt=\"Tu Imagen\">";
				$canal->mensaje = "<span style='float:left;padding-top:10px;'>".$imagen."<b>".$usuario->nombre."(".$usuario->email.")</b>: <br>".Input::post("ayuda")."</span>";
    			$canal->identificador_canal = md5(Input::post("email").date("Y-m-d").$id[0]->id);
    			$canal->usuario_id = $id[0]->id;
    			if ($canal->save()) {
    				$this->nombre = Input::post("nombre");
    				$this->email = Input::post("email");
    				$this->identificador_canal = $canal->identificador_canal;
    			}else{
    				Flash::error("No se pudo abrir un canal de asistencia, Vuelva a intentarlo por favor!");
    				Router::redirect("index/chat");
    			}
    		}else{
    			Flash::error("No pudo ingresar a una sala de asistencia, por favor intentelo de nuevo");
    		}
    	}else{
    		Flash::error("El nombre, email y la consulta de como podemos ayudarte, son obligatorios");
    		Router::redirect("index/chat");
    	}
    }
    public function sala_admin(){
    	$this->title = 'Sala de Asistencia';
    	if (Input::post("email") and Input::post("password") and Input::post("password") == 'administrador') {
    		$canal = new Canal();
    		$this->mensaje = "Estas a la espera de que alguien se conecte para dar una asistencia";
    		$this->salas = $canal->find("columns: usuario.id as usuario_id, usuario.email, usuario.nombre, canal.id as canal_id, canal.identificador_canal, canal.mensaje",
    									"conditions: disconnected is null ","join: inner join usuario on canal.usuario_id = usuario.id");
    		for ($i=0; $i < count($this->salas) ; $i++) { 
    			$this->salas[$i]->gravatar = $this->get_gravatar($this->salas[$i]->email);
    		}
    	}
    }
    public function mandar_mensaje(){
    	View::select(null,"json");
    	$canal = new Canal();
    	$canal->mensaje = Input::post("mensaje");
    	$canal->identificador_canal = Input::post("codigo");
    	if ($canal->save()) {
    		$this->data = true;
    	}else{
    		$this->data = false;
    	}

    }
    public function consultar_mensaje_desde_admin(){
    	View::select(null,"json");
    	$canal = new Canal();
    	$mensajes = $canal->find("conditions: leido_admin is null","group: identificador_canal");
    	foreach ($mensajes as $key => $value) {
    		$value->leido_admin = 1;
    		$value->update();
    	}
    	$this->data = $mensajes;
    }
    public function consultar_mensaje(){
    	View::select(null,"json");
    	$canal = new Canal();
    	$codigo = Input::post('codigo');
    	$mensajes = $canal->find("conditions: identificador_canal = '".$codigo."' and leido is null");
    	foreach ($mensajes as $key => $value) {
    		$value->leido = 1;
    		$value->update();
    	}
    	$this->data = $mensajes;
    }
	public function get_gravatar( $email, $s = 80, $d = 'mm', $r = 'g', $img = false, $atts = array() ) {
	    $url = 'http://www.gravatar.com/avatar/';
	    $url .= md5( strtolower( trim( $email ) ) );
	    $url .= "?s=$s&d=$d&r=$r";
	    if ( $img ) {
	        $url = '<img src="' . $url . '"';
	        foreach ( $atts as $key => $val )
	            $url .= ' ' . $key . '="' . $val . '"';
	        $url .= ' />';
	    }
	    return $url;
	}
	public function get_mensajes_canal(){
		View::select(null,"json");
    	$canal = new Canal();
    	$codigo = Input::post('codigo');
    	$mensajes = $canal->find("conditions: identificador_canal = '".$codigo."'");
    	
	}

}
