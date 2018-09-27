package controller;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.w3c.dom.Document;
import org.w3c.dom.*;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

import model.Produto; 

public class ProdutoController {
	
	public List<Produto> retornarListaProdutos(String caminhoXml) {
		List<Produto> listaProduto = new ArrayList<>();
		NodeList nodeListaProdutos = carregarXml(caminhoXml, "produto");		
		
        for(int index=0; index<nodeListaProdutos.getLength() ; index++){	
            Node nodeProduto = nodeListaProdutos.item(index);
            Produto produto = new Produto();

            if(nodeProduto.getNodeType() == Node.ELEMENT_NODE){
                Element elementoProduto = (Element)nodeProduto;

                NodeList nodeId = elementoProduto.getElementsByTagName("id");
                NodeList nodeNome = elementoProduto.getElementsByTagName("nome");
                NodeList nodeCodigo = elementoProduto.getElementsByTagName("codigo");
                NodeList nodePreco = elementoProduto.getElementsByTagName("preco");
                NodeList nodeQuantidade = elementoProduto.getElementsByTagName("quantidade");
                
                int id = converterNoteParaInteiro(nodeId);
                String nome = converterNoteParaString(nodeNome);
                int codigo = converterNoteParaInteiro(nodeCodigo);
                double preco = converterNoteParaDouble(nodePreco);
                int quantidade = converterNoteParaInteiro(nodeQuantidade);
                
                produto.setId(id);
                produto.setNome(nome);
                produto.setCodigo(codigo);
                produto.setPreco(preco);
                produto.setQuantidade(quantidade);
            }
            
            listaProduto.add(produto);
        }
        
        return listaProduto;
	}

	public NodeList carregarXml(String caminhoXml, String item) {
		NodeList nodeLista = null;
		try {			
	        DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
	        DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
	        Document documentoXml = docBuilder.parse (new File(caminhoXml));

	        documentoXml.getDocumentElement ().normalize ();	       	
	        nodeLista = documentoXml.getElementsByTagName(item);
	        
	    }catch (SAXParseException err) {
	    System.out.println ("** Parsing error" + ", line " 
	         + err.getLineNumber () + ", uri " + err.getSystemId ());
	    System.out.println(" " + err.getMessage ());
	
	    }catch (SAXException e) {
	    Exception x = e.getException ();
	    ((x == null) ? e : x).printStackTrace ();
	
	    }catch (Throwable t) {
	    t.printStackTrace ();
	    }
		
		return nodeLista;		
	}
	
	public String converterNoteParaString(NodeList node) {
        Element elemento = (Element)node.item(0);
        NodeList textoQuantidade = elemento.getChildNodes();
        String retorno = ((Node)textoQuantidade.item(0)).getNodeValue().trim();        
        return retorno;
	}
	
	public int converterNoteParaInteiro(NodeList node) {
		String stringNode = converterNoteParaString(node);
        int retorno = Integer.parseInt(stringNode);
        return retorno;
	}
	
	public double converterNoteParaDouble(NodeList node) {
		String stringNode = converterNoteParaString(node);
        double retorno = Double.parseDouble(stringNode);
        return retorno;
	}
}
