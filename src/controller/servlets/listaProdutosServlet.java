package controller.servlets;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.naming.event.EventContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ProdutoController;
import model.Produto;

/**
 * Servlet implementation class listaProdutosServlet
 */
@WebServlet("/listaProdutosServlet")
public class listaProdutosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public listaProdutosServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProdutoController produto = new ProdutoController();
		String caminho = "C:\\Users\\Samuel\\eclipse-workspace\\GestorFinanceiro\\WebContent\\xml\\produtos.xml";	    
		List<Produto> lista = produto.retornarListaProdutos(caminho);
		
		request.setAttribute("listaProdutos",lista);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
