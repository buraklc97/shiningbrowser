//
//  ViewController.swift
//  shiningbrowser
//
//  Created by DigerAPP on 16.06.2025.
//

import UIKit
import SafariServices

class URLCells: UITableViewCell {
    
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var Url: UILabel!
    @IBOutlet weak var menuButton: UIImageView!
    
    var menuClick: (() -> Void)? // callback
    override func awakeFromNib() {
          super.awakeFromNib()

          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(menuClickFunc))
        menuButton.isUserInteractionEnabled = true
        menuButton.addGestureRecognizer(tapGesture)
      }
    
    @objc private func menuClickFunc() {
        menuClick?()
       }

}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Header: UILabel!
    @IBOutlet weak var Search: UILabel!
    @IBOutlet weak var HowItWork: UILabel!
    
    @IBOutlet weak var SearchImage: UIImageView!
    @IBOutlet weak var QuestionImage: UIImageView!
    
    @IBOutlet weak var WebSiteAdded: UITextField!
    @IBOutlet weak var PlusWebSite: UIImageView!
    @IBOutlet weak var DeleteAll: UIImageView!
    
    @IBOutlet weak var UrlTableView: UITableView!
    @IBOutlet weak var QuestionView: UIView!
    @IBOutlet weak var SearchView: UIView!
    
    @IBOutlet weak var HowItWorkMainView: UIView!
    
    @IBOutlet weak var q1: UILabel!
    @IBOutlet weak var a1: UILabel!
    
    @IBOutlet weak var q2: UILabel!
    @IBOutlet weak var a2: UILabel!
    
    @IBOutlet weak var q3: UILabel!
    @IBOutlet weak var a3: UILabel!
    
    @IBOutlet weak var q4: UILabel!
    @IBOutlet weak var a4: UILabel!
    
    @IBOutlet weak var q5: UILabel!
    @IBOutlet weak var a5: UILabel!
    
    @IBOutlet weak var q6: UILabel!
    @IBOutlet weak var a6: UILabel!
    
    @IBOutlet weak var q7: UILabel!
    @IBOutlet weak var a7: UILabel!
    
    @IBOutlet weak var q8: UILabel!
    @IBOutlet weak var a8: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var PopupView: UIView!
    @IBOutlet weak var AcilisSayfasi: UIView!
    @IBOutlet weak var Sil: UIView!
    @IBOutlet weak var AcilisLabel: UILabel!
    @IBOutlet weak var SilLabel: UILabel!
    
    var selectedURL = ""
    var hasShowQuest = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return GetAllSites().count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "URLCells", for: indexPath) as! URLCells
        
        // Resme tıklanınca yapılacak işlem
        cell.menuClick = {
            
            print("Image tapped at row \(indexPath.row)")
            self.selectedURL = GetAllSites()[indexPath.row]
            self.showPopup()
            // Burada istediğini yapabilirsin (örneğin: popup aç, detay sayfasına git)
        }
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor(red: 161/255, green: 124/255, blue: 60/255, alpha: 0.3)
        cell.selectedBackgroundView = selectedView
        
        AddShadowImage(image: cell.menuButton)
        
        
        cell.Url.attributedText = NSAttributedString(string: GetAllSites()[indexPath.row], attributes: GetStyleLabel(size: 15.0))
        
        
        cell.MainView.layer.borderWidth = 2.0
        cell.MainView.layer.borderColor = #colorLiteral(red: 0.631372549, green: 0.4862745098, blue: 0.2352941176, alpha: 1)
        cell.MainView.layer.cornerRadius = 10 // İsteğe bağlı köşe yuvarlama
        cell.MainView.layer.masksToBounds = true
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let clickURL = GetAllSites()[indexPath.row]
        
        openLinkInAppBrowser(urlString: clickURL)
        //OpenWebView(link: clickURL)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    /*
     * Func viewDidLoad()
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsHorizontalScrollIndicator = false
        
        Header.attributedText = NSAttributedString(string: "LuckyBrowser", attributes: GetStyleLabel(size: 24.0))
        Search.attributedText = NSAttributedString(string: "Arama", attributes: GetStyleLabel(size: 15.0))
        HowItWork.attributedText = NSAttributedString(string: "Nasıl Çalışır", attributes: GetStyleLabel(size: 15.0))
        AcilisLabel.attributedText = NSAttributedString(string: "Acilis Sayfası Olarak Ayarla", attributes: GetStyleLabel(size: 18.0))
        SilLabel.attributedText = NSAttributedString(string: "Web Sayfasını Sil", attributes: GetStyleLabel(size: 18.0))
        
        let clickScreen = UITapGestureRecognizer(target:self, action: #selector(herhangiBirYereTiklama(_:)))
        clickScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(clickScreen)
        
        AcilisSayfasi.layer.cornerRadius = 10
        AcilisSayfasi.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        AcilisSayfasi.layer.masksToBounds = true
        
        
        ClickEffects(howClick: 0)
        StyleTextEdit()
        AddShadowImage(image:QuestionImage)
        AddShadowImage(image:SearchImage)
        Clicks()
        QuestinLabelSet()
        UrlTableView.delegate = self
        UrlTableView.dataSource = self
   
    }
    
    /*
     * Func Clicks()
     */
    private func Clicks() {
        
        QuestionView.isUserInteractionEnabled = true
        let questionClick = UITapGestureRecognizer(target:self , action: #selector(QuestionButtonClick))
        QuestionView.addGestureRecognizer(questionClick)
        
        SearchView.isUserInteractionEnabled = true
        let searchClick = UITapGestureRecognizer(target:self , action: #selector(SearchButtonClick))
        SearchView.addGestureRecognizer(searchClick)
        
        DeleteAll.isUserInteractionEnabled = true
        let deleteClick = UITapGestureRecognizer(target:self , action: #selector(DeleteButtonClick))
        DeleteAll.addGestureRecognizer(deleteClick)
        
        PlusWebSite.isUserInteractionEnabled = true
        let plusClick = UITapGestureRecognizer(target:self , action: #selector(PlusButtonClick))
        PlusWebSite.addGestureRecognizer(plusClick)
        
        AcilisSayfasi.isUserInteractionEnabled = true
        let AcilisClick = UITapGestureRecognizer(target:self , action: #selector(AcilisButtonClick))
        AcilisSayfasi.addGestureRecognizer(AcilisClick)
        
        Sil.isUserInteractionEnabled = true
        let SilClick = UITapGestureRecognizer(target:self , action: #selector(SilButtonClick))
        Sil.addGestureRecognizer(SilClick)
    }

    /** ** Click Functions ** **/
    
    /*
     * Func openLinkInAppBrowser()
     */
    private func openLinkInAppBrowser(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
    /*
     * Func OpenWebView()
     */
    private func OpenWebView(link: String) {
        let webView = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        webView.modalPresentationStyle = .fullScreen
        webView.selectedUrl = link
        self.present(webView,animated: true)
    }
    
    /*
     * @objc Func SearchButtonClick()
     */
    @objc private func SearchButtonClick() {
        
        if !hasShowQuest {
            return
        }
        
        ClickEffects(howClick: 0)
    }
    
    /*
     * @objc Func ScanButtonClicked()
     */
    @objc private func QuestionButtonClick() {
        
        if hasShowQuest {
            return
        }
        
        ClickEffects(howClick: 1)
        
    }
    
    /*
     * @objc Func SearchButtonClick()
     */
    @objc private func DeleteButtonClick() {
        
        if GetAllSites().count == 0 {
            showAlert(
                on: self,
                title: "Bilgilendirme",
                message: "Silinebilecek kayıtlı site adresi bulunmamaktadır.",
                hasTwoButtons: false,
                okTitle: "Anladım",
                onConfirm: {
                    RemoveAllSite()
                    self.UrlTableView.reloadData()
                },
                onCancel: {
                    print("Kullanıcı vazgeçti")
                }
            )
            
            return
        }
        
        showAlert(
            on: self,
            title: "Katıtlar Siliniyor",
            message: "Tüm kayıtlı siteler silinecektir. Emin misiniz?",
            hasTwoButtons: true,
            yesTitle: "Sil",
            noTitle: "Vazgeç",
            onConfirm: {
                RemoveAllSite()
                self.UrlTableView.reloadData()
            },
            onCancel: {
                print("Kullanıcı vazgeçti")
            }
        )
    }
    
    /*
     * @objc Func SearchButtonClick()
     */
    @objc private func PlusButtonClick() {
        
        let webSiteText = WebSiteAdded.text?.lowercased()
        if AddSite(webSiteText!) {
            
            UrlTableView.reloadData()
            WebSiteAdded.text = ""
            return
        }
        
        showAlert(
            on: self,
            title: "UYARI!",
            message: "Boş kayıt yapılamaz veya aynı adres kayıt edilemez. Lütfen site adresini kontrol ediniz.",
            hasTwoButtons: false,
            okTitle: "Anladım",
            onConfirm: {
                print("Kullanıcı çıktı")
            }
        )
    }
    
    /*
     * @objc Func SearchButtonClick()
     */
    @objc private func AcilisButtonClick() {
        animateTapEffect(on: AcilisSayfasi)
         _ = AddStarSite(selectedURL)
        hidePopup()
        OpenWebView(link: GetStarSite())
    }
    
    /*
     * @objc Func SearchButtonClick()
     */
    @objc private func SilButtonClick() {
        animateTapEffect(on: Sil)
        RemoveSite(selectedURL)
        hidePopup()
        self.UrlTableView.reloadData()
        
    }
    
    /*
     * @objc Func herhangiBirYereTiklama()
     */
    @objc private func herhangiBirYereTiklama(_ sender: UITapGestureRecognizer) {
        
        hidePopup()
    }
    
    /** ** Click Functions ** **/
    
    
    
    /** ** UI Help Functions ** **/
    
    /*
     * Func animateTapEffect()
     */
    private func animateTapEffect(on view: UIView, highlightMultiplier: CGFloat = 1.2, duration: TimeInterval = 0.2) {
        guard let originalColor = view.backgroundColor else { return }
        
        // Daha açık renk üret: RGB bileşenlerini 1.2x artır (max 1.0)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 1
        originalColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let lighterColor = UIColor(
            red: min(red * highlightMultiplier, 1.0),
            green: min(green * highlightMultiplier, 1.0),
            blue: min(blue * highlightMultiplier, 1.0),
            alpha: alpha
        )
        
        // Animasyon: açık renge geç → geri dön
        UIView.animate(withDuration: duration, animations: {
            view.backgroundColor = lighterColor
        }) { _ in
            UIView.animate(withDuration: duration) {
                view.backgroundColor = originalColor
            }
        }
    }
    
    /*
     * Func ClickEffects()
     */
    private func ClickEffects(howClick: Int) {
        
        /* Search = 0
         * HowItWork = 1
         */
        
        SearchView.layer.borderWidth = 0.0
        SearchView.layer.borderColor = #colorLiteral(red: 0.631372549, green: 0.4862745098, blue: 0.2352941176, alpha: 1)
        SearchView.layer.masksToBounds = true
        
        QuestionView.layer.borderWidth = 0.0
        QuestionView.layer.borderColor = #colorLiteral(red: 0.631372549, green: 0.4862745098, blue: 0.2352941176, alpha: 1)
        QuestionView.layer.masksToBounds = true
        
        if  howClick == 0 {
            
            hideSlidingView(HowItWorkMainView)
            SearchView.layer.borderWidth = 2.0
            SearchView.layer.borderColor = #colorLiteral(red: 0.631372549, green: 0.4862745098, blue: 0.2352941176, alpha: 1)
            SearchView.layer.masksToBounds = true
            
            return
        }
        
        showSlidingView(HowItWorkMainView)
        QuestionView.layer.borderWidth = 2.0
        QuestionView.layer.borderColor = #colorLiteral(red: 0.631372549, green: 0.4862745098, blue: 0.2352941176, alpha: 1)
        QuestionView.layer.masksToBounds = true
    }
    
    /*
     * Func showSlidingView()
     */
    private func showSlidingView(_ view: UIView) {
        view.isHidden = false
        view.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
        
        UIView.animate(withDuration: 0.5) {
            view.transform = .identity
            
            self.hasShowQuest = true
        }
    }
    
    /*
     * Func hideSlidingView()
     */
    private func hideSlidingView(_ view: UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            view.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
        }) { _ in
            view.isHidden = true
            self.hasShowQuest = false
        }
    }
    
    /*
     * Func StyleTextEdit()
     */
    private func StyleTextEdit() {
        
        WebSiteAdded.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        WebSiteAdded.layer.borderColor = UIColor(red: 193/255, green: 156/255, blue: 74/255, alpha: 1).cgColor
        WebSiteAdded.layer.borderWidth = 2.5
        WebSiteAdded.layer.cornerRadius = 12
        WebSiteAdded.layer.masksToBounds = true
        
        WebSiteAdded.textColor = UIColor(red: 193/255, green: 156/255, blue: 74/255, alpha: 1)
        WebSiteAdded.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        
        WebSiteAdded.attributedPlaceholder = NSAttributedString(
            string: "Eklenecek Site Adresi",
            attributes: [
                .foregroundColor: UIColor(red: 193/255, green: 156/255, blue: 74/255, alpha: 0.8),
                .font: UIFont(name: "AvenirNext-DemiBold", size: 15)!
            ]
        )
        
        // 🔸 Yazı başlangıcına boşluk ekle (left padding)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: WebSiteAdded.frame.height))
        WebSiteAdded.leftView = paddingView
        WebSiteAdded.leftViewMode = .always
        
    }
    
    /*
     * Func GetStyleLabel()
     */
    private func GetStyleLabel(size: CGFloat) -> [NSAttributedString.Key: Any] {
        
        // 1. Gölge oluştur
        let shadow = GetShadow()
        
        // 2. Stil özellikleri
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.black,
            .foregroundColor: UIColor(red: 193/255, green: 156/255, blue: 74/255, alpha: 1), // Gold
            .strokeWidth: -2.0,
            .font: UIFont(name: "AvenirNext-DemiBold", size: size)!,
            .shadow: shadow
        ]
        
        return strokeTextAttributes
    }
    
    /*
     * Func GetShadow()
     */
    private func GetShadow() -> NSShadow  {
        
        // 1. Gölge oluştur
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.5)
        shadow.shadowOffset = CGSize(width: 3, height: 3)
        shadow.shadowBlurRadius = 3
        
        return shadow
    }
    
    /*
     * Func AddShadowImage()
     */
    private func AddShadowImage(image: UIImageView) {
        
        
        // Shadow'ı imageView'ın parent view'ına ekle
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 0.5
        image.layer.shadowOffset = CGSize(width: 3, height: 3)
        image.layer.shadowRadius = 6
        image.layer.masksToBounds = false  // GÖLGE İÇİN GEREKLİ
    }
    
    /*
     * Func QuestinLabelSet()
     */
    private func QuestinLabelSet() {
        
        q1.attributedText = NSAttributedString(string: "1. Uygulama Nasıl Kullanılır ?", attributes: GetStyleLabel(size: 18.0))
        a1.attributedText = NSAttributedString(string: "Sitenizin adresini site adresini ekle kısmındaki kutucuğa örneğin apple.com şeklinde girip sağdaki + butonuna basın ve aşağıdaki listeden açılış sayfasını kullanarak veya tarayıcıdan dışarıdan açarak kullanabilirsiniz.", attributes: GetStyleLabel(size: 14.0))
        
        q2.attributedText = NSAttributedString(string: "2. Bazı Sitelere Giriş Yapmıyorum Neden ?", attributes: GetStyleLabel(size: 18.0))
        a2.attributedText = NSAttributedString(string: "Öncelikle ekleyeceğiniz sitenin https:// ya da http:// siz halini eklediğinizden emin olun. Eğer bunda bir problem yoksa bizimle iletişime geçip adresi kontrol edip güncellenmesini isteyebilirsiniz.", attributes: GetStyleLabel(size: 14.0))
        
        q3.attributedText = NSAttributedString(string: "3. Tüm Cihazlarda Kullanabilir miyim ?", attributes: GetStyleLabel(size: 18.0))
        a3.attributedText = NSAttributedString(string: "Masaüstü hariç kullanabilirsiniz. Masaüstü versiyonu yakında çıkacaktır.", attributes: GetStyleLabel(size: 14.0))
        
        q4.attributedText = NSAttributedString(string: "4. Tüm Sitelere Uygulama Üzerinden Erişebilir miyim ?", attributes: GetStyleLabel(size: 18.0))
        a4.attributedText = NSAttributedString(string: "Bazı siteler güvenlik amacıyla engellenmiş olabilir, bu yüzden çalışmayabilir.", attributes: GetStyleLabel(size: 14.0))
        
        q5.attributedText = NSAttributedString(string: "5. İstediğim Kadar Site Ekleyebilir miyim ?", attributes: GetStyleLabel(size: 18.0))
        a5.attributedText = NSAttributedString(string: "Evet, istediğiniz kadar site ekleyebilirsiniz.", attributes: GetStyleLabel(size: 14.0))
        
        q6.attributedText = NSAttributedString(string: "6. Uygulama İkonunu ve adını değiştirebilir miyim ?", attributes: GetStyleLabel(size: 18.0))
        a6.attributedText = NSAttributedString(string: "Hayır, değiştiremezsiniz.", attributes: GetStyleLabel(size: 14.0))
        
        q7.attributedText = NSAttributedString(string: "7. Sürekli Değişen Site Adresleri İçin Kullanabilir miyim ?", attributes: GetStyleLabel(size: 18.0))
        a7.attributedText = NSAttributedString(string: "Evet, kullanabilirsiniz. Sürekli değişen adresi bize bildirin, veritabanlarımıza ekledikten sonra sürekli güncel adresi otomatik olarak alacaktır.", attributes: GetStyleLabel(size: 14.0))
        
        q8.attributedText = NSAttributedString(string: "8. Dinamik Link Kullanarak Uygulama İndirilirken Siteleri Otomatik Ekletebilir miyim ?", attributes: GetStyleLabel(size: 18.0))
        a8.attributedText = NSAttributedString(string: "Şu an için uygulamamızda bu özellik bulunmamaktadır. Gelecek versiyonlara eklenecektir.", attributes: GetStyleLabel(size: 14.0))
    }
    
    /*
     * Func showPopup()
     */
    private func showPopup() {
        PopupView.isHidden = false
        PopupView.alpha = 0
        PopupView.transform = CGAffineTransform(translationX: 0, y: 100) // aşağıda başlasın
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            self.PopupView.alpha = 1
            self.PopupView.transform = .identity // yerine geri gelsin
        }, completion: nil)
    }
    
    /*
     * Func hidePopup()
     */
    private func hidePopup() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
            self.PopupView.alpha = 0
            self.PopupView.transform = CGAffineTransform(translationX: 0, y: 100) // aşağı kaydır
        }, completion: { _ in
            self.PopupView.isHidden = true
            self.PopupView.transform = .identity // resetle
        })
    }
    
    /** ** UIHelpFunctions ** **/
    
}

