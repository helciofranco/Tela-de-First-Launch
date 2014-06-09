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
    @IBOutlet var scrollView : UIScrollView = nil
    
    // UIPageControl
    @IBOutlet var pageControl : UIPageControl = nil
    
    // UIImageViews para realizar a transição suave
    var fundoAtual : UIImageView = UIImageView()
    var fundoTransicao : UIImageView = UIImageView()
    
    // Nome dos Fundos - Coloque aqui o nome das imagens que você importou para o fundo
    let fundos = ["bg1.png", "bg2.png", "bg3.png", "bg4.png"]
    
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
        
        // Fundo preto na scroll view
        scrollView!.backgroundColor = UIColor.blackColor()
        
        // Determina o número de páginas na UIPageControl
        pageControl!.numberOfPages = fundos.count
        self.view.bringSubviewToFront(pageControl!)
        
        // Apresenta o primeiro fundo
        trocarFundo()
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
