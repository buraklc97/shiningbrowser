import Foundation
import UIKit
    


    /*
    * Func AddSite()
    */
    public func AddSite(_ newSite: String) -> Bool {
        let defaults = UserDefaults.standard
        var sites = defaults.stringArray(forKey: "AllWebSite") ?? []
        
        // 1. Boş veya sadece boşluk karakterlerinden oluşuyorsa ekleme
        let trimmed = newSite.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return false }
        
        // 2. Başında http:// veya https:// yoksa https:// ekle
        let normalizedSite: String
        if trimmed.lowercased().hasPrefix("http://") || trimmed.lowercased().hasPrefix("https://") {
            normalizedSite = trimmed
        } else {
            normalizedSite = "https://\(trimmed)"
        }
        
        // 3. Aynı site varsa ekleme
        guard !sites.contains(normalizedSite) else { return false }
        
        // 4. Listeye ekle
        sites.append(normalizedSite)
        defaults.set(sites, forKey: "AllWebSite")
        
        return true
    }

    
    /*
     * Func AddStarSite()
     */
    public func AddStarSite(_ newSite: String) -> Bool {
        let defaults = UserDefaults.standard

          let trimmed = newSite.trimmingCharacters(in: .whitespacesAndNewlines)
          guard !trimmed.isEmpty else { return false }

          defaults.set(trimmed, forKey: "StarWebSite")
          return true
    }

    /*
    * Func GetStarSite()
    */
    public func GetStarSite() -> String {
        let currentSite = UserDefaults.standard.string(forKey: "StarWebSite") ?? ""

        return currentSite
    }

    /*
    * Func RemoveSite()
    */
    public func RemoveStarSite() {
   
        UserDefaults.standard.removeObject(forKey: "StarWebSite")
    }

    /*
     * Func GetAllSites()
     */
    public func GetAllSites() -> [String] {
        return UserDefaults.standard.stringArray(forKey: "AllWebSite") ?? []
    }
    
    /*
     * Func RemoveSite()
     */
    public func RemoveSite(_ siteToRemove: String) {
        var sites = GetAllSites()
        sites.removeAll { $0 == siteToRemove }
        UserDefaults.standard.set(sites, forKey: "AllWebSite")
    }
    
    /*
     * Func RemoveAllSite()
     */
    public func RemoveAllSite() {
        var sites = GetAllSites()
        sites.removeAll()
        UserDefaults.standard.set(sites, forKey: "AllWebSite")
    }
    
    /*
     * Func RemoveAllSite()
     */
    public func showAlert(
        on viewController: UIViewController,
        title: String,
        message: String,
        style: UIAlertController.Style = .alert,
        hasTwoButtons: Bool = false,
        okTitle: String = "Tamam",
        yesTitle: String = "Evet",
        noTitle: String = "Hayır",
        onConfirm: (() -> Void)? = nil,
        onCancel: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if hasTwoButtons {
            // Evet-Hayır versiyonu
            let yesAction = UIAlertAction(title: yesTitle, style: .default) { _ in
                onConfirm?()
            }
            let noAction = UIAlertAction(title: noTitle, style: .cancel) { _ in
                onCancel?()
            }
            alert.addAction(noAction)
            alert.addAction(yesAction)
        } else {
            // Tek buton: Tamam
            let okAction = UIAlertAction(title: okTitle, style: .default) { _ in
                onConfirm?()
            }
            alert.addAction(okAction)
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }

