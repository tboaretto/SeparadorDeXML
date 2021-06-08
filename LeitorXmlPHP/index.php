

<html>
    <head>
        <meta charset=UTF-8">
        <title> Leitor de xml via php </title>
    </head>
      <body>
        <?php
          $caminhoxml = "xml/produto.xml";
          $xml = simplexml_load_file($caminhoxml) or die("Não abriu o arquivo");
          
          foreach ($xml->children() as $venda){
               foreach($venda->children() as $produtos){
                  echo $produtos->codigo;
                  echo $produtos->nome;
                  echo $produtos->valor;
                  echo "-------------<br>";
               }
          }
          
        ?>
     </body>
</html>