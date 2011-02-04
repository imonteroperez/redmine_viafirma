<?php
	include_once("./viafirma/includes.php");
	
	class ViafirmaClientResponsePrueba extends ViafirmaClientResponse {
		public function authenticateOK($usuarioGenerico){
			print ("<body onload=\"location.href= 'http://localhost:81/redmine/login?viafirma_user_id=".$usuarioGenerico->numberUserId."&viafirma_user_info=".$usuarioGenerico->properties."'\"></body>");
		}
		
		public function cancel(){
			echo "Cancelado por el usuario";
		}
		
		public function error($error){
			echo "Error: No se ha podido recuperar el usuario autenticado";
		}

		public function signOK($error){
		}
		
	}

	//Lanzamos el process...
	$test = new ViafirmaClientResponsePrueba();
	$test->process();
?>
