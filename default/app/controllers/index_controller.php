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
    			$this->imagen = $this->get_gravatar($usuario->email);
    			$imagen = "<img style='float:left;padding:4px;' src='".$this->imagen."' width=\"50\" alt=\"Tu Imagen\">";
				$canal->mensaje = "<span style='float:left;padding-top:10px;'>".$imagen."<b>".$usuario->nombre."(".$usuario->email.")</b>: <br>".Input::post("ayuda")."</span> <div class='clearfix'></div>";
    			$canal->identificador_canal = md5(Input::post("email").date("Y-m-d").$id[0]->id);
    			$canal->usuario_id = $id[0]->id;
    			if ($canal->save()) {
    				$this->nombre = Input::post("nombre");
    				$this->email = Input::post("email");
                    $this->identificador_canal = $canal->identificador_canal;
    				$this->usuario_id = $canal->usuario_id;
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
    		$this->salas = $canal->find("columns: usuario.id as usuario_id, usuario.email, usuario.nombre, canal.id as canal_id, canal.identificador_canal, canal.mensaje, canal.created",
    									"conditions: disconnected is null ","join: inner join usuario on canal.usuario_id = usuario.id","group: identificador_canal","order: canal.created desc");
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
        $canal->usuario_id = Input::post('usuario_id');
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
    	$mensajes = $canal->find("columns: usuario.id as usuario_id, usuario.email, usuario.nombre, canal.id, canal.mensaje, canal.created, canal.identificador_canal","conditions: identificador_canal = '".$codigo."' and leido is null","join: inner join usuario on canal.usuario_id = usuario.id");
    	foreach ($mensajes as $key => $value) {
    		$value->leido = 1;
    		$value->update();
    	}
        for ($i=0; $i < count($mensajes) ; $i++) { 
            $mensajes[$i]->gravatar = $this->get_gravatar($mensajes[$i]->email);
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
    // esto es solo administrador
	public function get_mensajes_canal(){
		View::select(null,"json");
    	$canal = new Canal();
    	$codigo = Input::post('codigo');
    	$mensajes = $canal->find("conditions: identificador_canal = '".$codigo."'",
                                "join: inner join usuario on usuario.id = canal.usuario_id",
                                "columns: usuario.id as usuario_id, usuario.nombre, usuario.email, canal.identificador_canal,canal.mensaje, canal.created, canal.id, canal.disconnected",
                                "order: canal.id asc");
        // antes de que los muestre el administrador ya lo tiene que tener como vistos
        //para que no los vuelva a cargar luego
        foreach ($mensajes as $key => $value) {
            $value->leido_admin = 1;
            $value->update();
        }
        for ($i=0; $i < count($mensajes) ; $i++) { 
            $mensajes[$i]->gravatar = $this->get_gravatar($mensajes[$i]->email);
        }
    	$this->data = $mensajes;
	}
    public function eliminar_mensajes(){
        View::select(null,"json");
        $canal = new Canal();
        $codigo = Input::post("codigo");
        $respuesta = $canal->delete("identificador_canal='$codigo'");
        $this->data = $respuesta;
    }
    public function get_mensajes_canal_nuevos(){
                View::select(null,"json");
        $canal = new Canal();
        $mensajes = $canal->find("conditions: leido_admin is null and gravatar_admin is null",
                                "join: inner join usuario on usuario.id = canal.usuario_id",
                                "columns: usuario.id as usuario_id, usuario.nombre, usuario.email, canal.identificador_canal");
        // antes de que los muestre el administrador ya lo tiene que tener como vistos
        //para que no los vuelva a cargar luego
        foreach ($mensajes as $key => $value) {
            $arreglo[$value->identificador_canal] = true; 
        }
        $this->data = isset($arreglo) ? $arreglo : null;
    }
    public function mandar_mensaje_desde_admin(){
        View::select(null,"json");
        $canal = new Canal();
        $canal->mensaje = Input::post("mensaje");
        $canal->identificador_canal = Input::post("codigo");
        $canal->usuario_id = Input::post('usuario_id');
        $canal->gravatar_admin  = Input::post('gravatar_admin');
        if ($canal->save()) {
            $this->data = true;
        }else{
            $this->data = false;
        }

    }
    public function buscar_nuevos_conectados(){
        View::select(null,"json");
        $canal = new Canal();
        $codigos = Input::post("codigos");
        $numero =$canal->count();
        $where = '';
        if ($numero) {
            if (!$codigos) {
                $where = '1=1';
            }else{

                for ($i=0; $i < count($codigos) ; $i++) { 
                    if ($i == 0) {
                        # code...
                        $where.= " identificador_canal != '".$codigos[$i]."' ";
                    }else{
                        $where.= " and identificador_canal != '".$codigos[$i]."' ";

                    }
                }
            }
            $canales = $canal->find("conditions: ".$where,"join: inner join usuario on usuario.id = canal.usuario_id","columns: usuario.id as usuario_id, usuario.nombre, usuario.email, canal.identificador_canal, canal.id");
            for ($i=0; $i < count($canales) ; $i++) { 
                $canales[$i]->gravatar = $this->get_gravatar($canales[$i]->email);
            }
        }
        $this->data = isset($canales) ? $canales : null;
    }

    public function cerrar_sesion_usuario(){
        View::select(null,'json');
        $canal = new Canal();
        $canal_ = $canal->find("usuario_id = '".Input::post('usuario_id')."'");
        $canal_[0]->disconnected = 1;
        $this->data = $canal_[0]->update();
    }
}
