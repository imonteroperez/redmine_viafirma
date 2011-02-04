<?php
	/**
	* Ejemplo de integración con Viafirma.
	* @version viafirma-client-php 1.0
	*/
	try {
		include_once("./viafirma/includes.php");
            // URL en la que se encuentra el servicio de Viafirma y url publica de la aplicacion 
		ViafirmaClientFactory::init($VIAFIRMA_SERVICE_URL, $VIAFIRMA_SERVICE_URL, "http://localhost/viafirma-client-php");
		$viafirmaClient = ViafirmaClientFactory::getInstance();
		//$viafirmaClient->printConfig();
		// Url de retorno a la aplicacion (tras el proceso de autenticacion)
		$viafirmaClient->solicitarAutenticacion("http://localhost/viafirma-client-php/end.php");
		
	}catch(Exception $exception){
		echo "<pre>".$exception."</pre>";
	}
?>