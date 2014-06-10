//
//  TutorialViewController.swift
//  Tela de Tutorial
//
//  Created by Hélcio Franco on 09/06/14.
//  Copyright (c) 2014 Hélcio Franco. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIScrollViewDelegate {

    // UIScrollView
    @IBOutlet var scrollView: UIScrollView = nil
    
    // UIPageControl
    @IBOutlet var pageControl: UIPageControl = nil
    
    // UIImageViews para realizar a transição suave
    var fundoAtual : UIImageView = UIImageView()
    var fundoTransicao : UIImageView = UIImageView()
    
    // Fonte título e fonte da descrição
    let fonteTitulo = UIFont(name: "Myriad Pro", size: 60.0)
    let fonteTexto = UIFont(name: "Myriad Pro", size: 20.0)
    
    // Botão "pular tutorial"
    let pularTutorialLabel: String = "Pular"
    
    // Botão "finalizar tutorial"
    let finalizarTutorialLabel: String = "Pronto"
    
    // Distância do ícone no eixo y
    let distanciaIconeY: Float = 45.0
    
    // Distância do título no eixo y
    let distanciaTituloY: Float = 155.0
    
    // Nome dos Fundos - Coloque aqui o nome das imagens que você importou para o fundo
    let fundos: String[] = ["bg1.png", "bg2.png", "bg3.png", "bg4.png"]
    
    // Informações das páginas
    let paginas: (String, String, String)[] = [("icon1.png", "Título 1", "Descrição"), ("icon2.png", "Título 1", "Descrição"), ("icon3.png", "Título 1", "Descrição"), ("icon4.png", "Título 1", "Descrição")]
    
    // Página atual
    var paginaAtual = -1
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fundo que será destaque na View
        fundoAtual = UIImageView(frame: self.view.frame)
        self.view.addSubview(fundoAtual)
        
        // Fundo que fará transição na View
        fundoTransicao = UIImageView(frame: self.view.frame)
        self.view.addSubview(fundoTransicao)
    
        // Dimensões básicas da UIScrollView
        let numeroDePaginas = fundos.count
        let larguraTutorial = CGFloat(numeroDePaginas) * CGRectGetWidth(self.view.bounds)

        // Configura tamanho do conteúdo da UIScrollView
        scrollView!.delegate = self
        scrollView!.contentSize = CGSizeMake(larguraTutorial, CGRectGetHeight(self.view.bounds))
        self.view.bringSubviewToFront(scrollView!)
        
        // Fundo preto na tela
        self.view.backgroundColor = UIColor.blackColor()
        
        // Determina o número de páginas na UIPageControl
        pageControl!.numberOfPages = fundos.count
        self.view.bringSubviewToFront(pageControl!)
        
        // Apresenta o primeiro fundo
        trocarFundo()
        
        // Popula ScrollView com as informação da Tupla "paginas"
        popularScrollView()
    }
    
    func popularScrollView() {
        // Percorre todas tuplas
        for (paginaNumero, (icone, titulo, descricao)) in enumerate(paginas) {
            // Início da página no eixo X
            let origemPagina = (CGRectGetWidth(self.view.bounds) * Float(paginaNumero))
            
            // Coloca o ícone na tela
            let iconeImage = UIImage(named: icone)
            let iconeView = UIImageView(frame: CGRect(x: origemPagina + (CGRectGetWidth(self.view.bounds) - iconeImage.size.width) / 2, y: distanciaIconeY, width: iconeImage.size.width, height: iconeImage.size.height))
            iconeView.image = iconeImage
            scrollView!.addSubview(iconeView)
            
            // Coloca o título na tela
            let tituloLabel = UILabel(frame: CGRect(x: origemPagina, y: distanciaTituloY, width: CGRectGetWidth(self.view.bounds), height: 70))
            tituloLabel.text = titulo
            tituloLabel.textAlignment = .Center
            tituloLabel.font = fonteTitulo
            tituloLabel.textColor = UIColor.whiteColor()
            scrollView!.addSubview(tituloLabel)
            
            // Coloca a descrição na tela
            let descricaoLabel = UILabel(frame: CGRect(x: origemPagina + 30, y: distanciaTituloY, width: CGRectGetWidth(self.view.bounds) - 60, height: 300))
            descricaoLabel.text = descricao
            descricaoLabel.textAlignment = .Center
            descricaoLabel.font = fonteTexto
            descricaoLabel.numberOfLines = 5
            descricaoLabel.textColor = UIColor.whiteColor()
            scrollView!.addSubview(descricaoLabel)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        trocarFundo()
    }
    
    func trocarFundo() {
        // Constantes para lidar com a posição do Scroll
        let larguraTela = CGRectGetWidth(self.view.bounds)
        let distanciaDeslocada = scrollView.contentOffset.x
        let paginaScrollAtual = maximo(0.0, numero2: minimo(Float(fundos.count - 1), numero2: distanciaDeslocada / larguraTela))

        // Defino a página atual e as imagens para transição a próxima transição
        if paginaScrollAtual != paginaAtual {
            paginaAtual = Int(paginaScrollAtual)
            fundoAtual.image = UIImage(named: fundos[paginaAtual])
            fundoTransicao.image = (paginaAtual + 1 != fundos.count) ? UIImage(named: fundos[paginaAtual + 1]) : nil
        }
        
        // Offset da rolagem horizontal
        var offset = distanciaDeslocada - (Float(paginaAtual) * larguraTela)
        
        // Rolando para extrema esquerda da tela
        if offset < 0 {
            pageControl!.currentPage = 0
            offset = larguraTela - minimo(-offset, numero2: larguraTela)
            fundoTransicao.alpha = 0
            fundoAtual.alpha = offset / larguraTela
        } else if offset != 0 {
            // Rolando para a extrema direita da tela
            if paginaScrollAtual == fundos.count - 1 {
                pageControl!.currentPage = fundos.count - 1
                fundoAtual.alpha = 1.0 - (offset / larguraTela)
            } else { // Rolou para alguma que possui página verdadeira
                pageControl!.currentPage = (offset > larguraTela / 2) ? paginaAtual + 1 : paginaAtual
                fundoTransicao.alpha = offset / larguraTela
                fundoAtual.alpha = 1.0 - fundoTransicao.alpha
            }
        } else { // Acabou de abrir a View
            pageControl!.currentPage = paginaAtual
            fundoAtual.alpha = 1
            fundoTransicao.alpha = 0
        }
    }
    
    func minimo(numero1: Float, numero2: Float) -> Float {
        let resultado = (numero1 < numero2) ? numero1 : numero2
        return resultado
    }
    
    func maximo(numero1: Float, numero2: Float) -> Float {
        let resultado = (numero1 > numero2) ? numero1 : numero2
        return resultado
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
