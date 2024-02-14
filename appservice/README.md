# App Service & Front Door 

App Servis / Frontdoor  Kontrol Listesi
         
1. Header temizlikleri yapılmalıdır 

a.  X-Powered-By: ASP.NET
   
3. Cache ayarları
        a.  Ignore query yapılacak mı 
     
    3. Site conf ayaları
        a.  Session affinity
            i.  Eğer yazılımın instancelar arasında session taşıması kısmında bir engel yoksa affinity on yap
            ii.  Eğer yazılımın instancelar arasında session taşımada sorun yoksa, isteklerin sürekli login olunan instance üzerinde gezmesi için session affinity off yap
        b.  Stack & Runtime version
        c.  Timezone ayarı
        ç.  Slot yapılması 
        d.  Gerekiyorsa hata sayfaları customize edilecek
        e.  Always on yapılması
        f.  Yazılım ekipleri ile görüşülerek Https only ayarları kontrol edilecek
         
    4. Application insgiht turn on yapılacak
        a.  Code tarafında kaynaklar create edilecek.  
        b.  Portal tarafında app ins. Turn on ve Apply yapılacak.
         
    5. Backup
        a.  Backup customize edilecek.  
        b.  12 saatte bir alınacak
        c.  60 gün tutulacak
        ç.  Her app service için Özel container create edilecek. 
         
    6. Network
        a.  App service için private endpoint eklenecek 
        b.  Waf policy yapılandırılacak.
        c.  Frontdoor kaynağı create edildikten sonra portal'dan app service network sekmesinde private endpoint allow edilecek
        ç.  Gerekiyorsa diğer azure resource grupları ile konuşması için vnet integration yapılacak 
        d.  Dışarı çıkması gerekiyorsa nat eklenecek.
         
    7. Monitoring
        a.  Oluşturulması gereken alarmlar
            i. 4xx
            ii. 5xx
            iii. Responsetime
            iv. Request count
            v. memory   
        b.  Diagnostic settigns ayaları
            i. Log kaynaklarının retaion sürelerinin ayarlanması (4 YIL)
            ii.  Tüm loglar açılacak
            iii.  Log Analytic için ürün bazında servis açılacak 
            iv.  Loglar aynı zamanda storage accountta tutulacak.
             
    7. Ürün kurulumu sonrası diagnose and solve problem menüsü incelenecek.
       Varsa öneriler değerlendirilecek
