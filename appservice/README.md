Ana klasörde 2 dosya 1 klasör bulunmaktadır.
Ana main.tf dosyası içerisinde Modules içerisinde yazdığımız App Service ve Front Door kaynaklarını çağırarak oluşmasını sağlıyoruz.

- modules
  - app-service
    - main.tf
    - variables.tf  
  - frontdoor
    - main.tf
    - variables.tf
- main.tf
- variable.tf


<p align="left"># App Service & Front Door <br><br>App Servis / Frontdoor  Kontrol Listesi<br>         <br>    1. Header temizlikleri yapılmalıdır <br>        a.  X-Powered-By: ASP.NET        <br>         <br>    2. Cache ayarları<br>        a.  Ignore query yapılacak mı <br>     <br>    3. Site conf ayaları<br>        a.  Session affinity<br>            i.  Eğer yazılımın instancelar arasında session taşıması kısmında bir engel yoksa affinity on yap<br>            ii.  Eğer yazılımın instancelar arasında session taşımada sorun yoksa, isteklerin sürekli login olunan instance üzerinde gezmesi için session affinity off yap<br>        b.  Stack & Runtime version<br>        c.  Timezone ayarı<br>        ç.  Slot yapılması <br>        d.  Gerekiyorsa hata sayfaları customize edilecek<br>        e.  Always on yapılması<br>        f.  Yazılım ekipleri ile görüşülerek Https only ayarları kontrol edilecek<br>         <br>    4. Application insgiht turn on yapılacak<br>        a.  Code tarafında kaynaklar create edilecek.  <br>        b.  Portal tarafında app ins. Turn on ve Apply yapılacak.<br>         <br>    5. Backup<br>        a.  Backup customize edilecek.  <br>        b.  12 saatte bir alınacak<br>        c.  60 gün tutulacak<br>        ç.  Her app service için Özel container create edilecek. <br>         <br>    6. Network<br>        a.  App service için private endpoint eklenecek <br>        b.  Waf policy yapılandırılacak.<br>        c.  Frontdoor kaynağı create edildikten sonra portal'dan app service network sekmesinde private endpoint allow edilecek<br>        ç.  Gerekiyorsa diğer azure resource grupları ile konuşması için vnet integration yapılacak <br>        d.  Dışarı çıkması gerekiyorsa nat eklenecek.<br>         <br>    7. Monitoring<br>        a.  Oluşturulması gereken alarmlar<br>            i. 4xx<br>            ii. 5xx<br>            iii. Responsetime<br>            iv. Request count<br>            v. memory   <br>        b.  Diagnostic settigns ayaları<br>            i. Log kaynaklarının retaion sürelerinin ayarlanması (4 YIL)<br>            ii.  Tüm loglar açılacak<br>            iii.  Log Analytic için ürün bazında servis açılacak <br>            iv.  Loglar aynı zamanda storage accountta tutulacak.<br>             <br>    7. Ürün kurulumu sonrası diagnose and solve problem menüsü incelenecek.<br>       Varsa öneriler değerlendirilecek</p>

###
