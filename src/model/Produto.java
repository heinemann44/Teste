package model;
	
public class Produto {
	
	private int id;
	private String nome;
	private int codigo;
	private int quantidade;
	private double preco;
	
	public Produto() {
		
	}
	
	

	public Produto(int id, String nome, int codigo, int quantidade, double preco) {
		this.id = id;
		this.nome = nome;
		this.codigo = codigo;
		this.quantidade = quantidade;
		this.preco = preco;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public int getCodigo() {
		return codigo;
	}

	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}

	public int getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}

	public double getPreco() {
		return preco;
	}

	public void setPreco(double preco) {
		this.preco = preco;
	}
	
	

}
