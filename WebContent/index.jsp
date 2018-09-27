<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<jsp:include page="/listaProdutosServlet" />

	<div>
	Produto: 
		<select id="cbProduto" onchange="carregarDadosProduto()">
		    <option value=""></option>
		    <c:forEach var="produto" items="${listaProdutos}">
		        <option value="${produto.id}">
		            ${produto.nome}
		        </option>
		     </c:forEach>
		</select>
	Código: 
		<input type="text" id="codigoProduto" value="" disabled>	
	Custo/Preço: 
		<input type="text" id="precoProduto" value="" disabled>	
	Quantidade: 
		<input type="text" id="quantidadeProduto" value="" disabled>	
	</br>
	</div>
	<div id="divPagamento" style="display: none;">
	Forma de pagamento: 
		<select id="cbOpcaoPagamento" onchange="mostrarTaxa()">
			<option value="">Opção</option>
		    <option value="credito">Crédito</option>
		    <option value="parcelado">Parcelado</option>
		    <option value="creditoEParcelado">Crédito e Parcelado</option>
		    <option value="debito">Débito</option>
		</select>
	</div>
	<div id="divTaxaCredito" style="display: none;">
	Taxa de crédito negociada: 
		<input type=text value="0.00" id="taxaCredito" onkeypress="verificarNumero(event)" oninput="validarTaxaCredito()" required="required" />
	</div>
	<div id="divTaxaParceladox6" style="display: none;">
	Taxa do Parcelado 6x negociada: 
		<input type="text" value="0.00" id="taxaParceladox6" oninput="validarTaxaParceladox6()" />
	</div>
	<div id="divTaxaParceladox12" style="display: none;">
	Taxa do Parcelado 12x negociada: 
		<input type="text" id="taxaParceladox12" />
	</div>
	<div id="divTaxaAmexCredito" style="display: none;">
	Taxa Amex Crédito na concorrência: 
		<input type="text" id="taxaAmexCredito" onkeypress="verificarNumero(event)" oninput="validarTaxaAmexCredito()"required="required" />
	</div>
	
	<button type="submit" id="btnSalvar">Salvar</button>

</body>

<script type="text/javascript">

	function verificarNumero(evt){        
        var character = String.fromCharCode(evt.which);
        if(!(/[0-9]/.test(character)) && !(character == ".")){
            evt.preventDefault();
    	}
	}
        
	function carregarDadosProduto() {
		idSelecionado = document.getElementById("cbProduto").value;

		<c:forEach var="produto" items="${listaProdutos}">
			index = "${produto.id}";
			if (idSelecionado == index){
				document.getElementById("divPagamento").style.display = 'block';
				document.getElementById("codigoProduto").value = "${produto.codigo}";
				document.getElementById("precoProduto").value = "${produto.preco}";
				document.getElementById("quantidadeProduto").value = "${produto.quantidade}";
			}
	    </c:forEach>		
	    mostrarOpcoesPagamento(document.getElementById("codigoProduto").value);
	    mostrarTaxa();
	}
	
	function mostrarOpcoesPagamento(codigo){
		if (codigo == 4409 || codigo == 4628){
			document.getElementById("divPagamento").style.display = 'block';
		}else{
			document.getElementById("divPagamento").style.display = 'none';
		}	
	}
	
	function mostrarTaxaCredito(){
		codigo = document.getElementById("codigoProduto").value;
		formaPagamento = document.getElementById("cbOpcaoPagamento").value; 

		if ((codigo == 4628) && (formaPagamento == "credito" || formaPagamento == "creditoEParcelado")){
				document.getElementById("divTaxaCredito").style.display = 'block';				
		}else{
			document.getElementById("divTaxaCredito").style.display = 'none';
		}	
	}
		
	function validarTaxaCredito(){
		precoProduto = document.getElementById("precoProduto").value;
		taxaCredito = document.getElementById("taxaCredito").value;
		
		if (taxaCredito > precoProduto){
			document.getElementById("btnSalvar").disabled = false;
		}else{
			document.getElementById("btnSalvar").disabled = true;
		}
	}
	
	function mostrarTaxaParceladox6(){
		codigo = document.getElementById("codigoProduto").value;
		formaPagamento = document.getElementById("cbOpcaoPagamento").value; 

		if ((codigo == 4628) && (formaPagamento == "parcelado" || formaPagamento == "creditoEParcelado")){
				document.getElementById("divTaxaParceladox6").style.display = 'block';	
		}else{
			document.getElementById("divTaxaParceladox6").style.display = 'none';
		}	
	}
	
	function mostrarTaxaParceladox12(){
		codigo = document.getElementById("codigoProduto").value;
		formaPagamento = document.getElementById("cbOpcaoPagamento").value; 

		if ((codigo == 4628) && (formaPagamento == "parcelado" || formaPagamento == "creditoEParcelado")){
				document.getElementById("divTaxaParceladox12").style.display = 'block';	
				completarCampoTaxaCreditox12();
		}else{
			document.getElementById("divTaxaParceladox12").style.display = 'none';
		}	
	}
		
	function completarCampoTaxaParceladox12(){
		preco = document.getElementById("precoProduto").value;
		
		if (verificarEstoque()){
			document.getElementById("taxaParcelado").value = (preco + 1);
			document.getElementById("taxaParceladox12").disabled = false;
		}else{
			document.getElementById("taxaParceladox12").value = "N/A";
			document.getElementById("taxaParceladox12").disabled = true;
		}
	}
	
	function verificarEstoque(){
		quantidade = document.getElementById("quantidadeProduto").value;
		if (quantidade > 0){
			return true;
		}else{
			return false;
		}					
	}
	
	function validarTaxaAmexCredito(){
		precoProduto = Number(document.getElementById("precoProduto").value);
		taxaAmexCredito = Number(document.getElementById("taxaAmexCredito").value);
		
		if (taxaAmexCredito < precoProduto){
			document.getElementById("btnSalvar").disabled = false;
		}else{
			document.getElementById("btnSalvar").disabled = true;
		}
	}
	
	function mostrarTaxaAmexCredito(){
		codigo = document.getElementById("codigoProduto").value;

		if (codigo == 4430){
				document.getElementById("divTaxaAmexCredito").style.display = 'block';	
		}else{
			document.getElementById("divTaxaAmexCredito").style.display = 'none';
		}	
	}
	
	function mostrarTaxa(){
		mostrarTaxaCredito();
		mostrarTaxaParceladox6();
		mostrarTaxaParceladox12();
		mostrarTaxaAmexCredito();
	}
</script>
</html>