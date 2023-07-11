# Takım İsmi
F-138
# Ürün İle İlgili Bilgiler
## Takım Üyeleri 
- Egehan Koç: Product Owner / Developer
- Gökçenaz Torgan: Scrum Master / Developer
- Ahsen Aleyna Ceylan: Developer
- Mert Sinan Işıtan: Developer
- Ayşe Serra Gümüştakım: Developer
## Ürün İsmi
_IdeApp_
## Product Backlog URL
[F-138 TRELLO BACKLOG URL ](https://trello.com/w/calismaalani46159697) 

## Ürün Açıklaması
IdeApp, kullanıcıların fikirlerini  kategorize etmesini ve bu sayede daha düzenli bir not tutma deneyimi yaşamasını amaçlar. Kullanıcı, istediği alanda ve isimde bir kategori oluşturup, notlarını bu kategori altına ekleyerek birbiri ile ilişkili notlara daha kolay ulaşır. Ayrıca not tutmayı ve fikir üretmeyi teşvik etmek amacıyla anasayfaya eklenen kartlardan ilham verici sözler okuyabilir. IdeApp her fikrin değerli olduğuna inanır, bu yüzden fikirlerin karmaşık bir not yığını içerisinde kaybolup gözden kaçmalarına izin vermez.

## Ürün Özellikleri
-	İstenilen alanda bir kategori, kategori altında bir başlık, başlık altında ise bir not olacak şekilde hiyerarşik ve düzenli bir not tutma deneyimi sağlaması.
-	Tutulan notların çevrimdışı olarak depolanması.
-	Anasayfada yer alan kartlar ile kullanıcıya ilham vermesi.
 
## Hedef Kitle
Fikir üretme ve not tutma ihtiyacı olan bireyseller; öğretmen, öğrenci, yazar, yazılımcı, sosyal medya içerik üreticisi… vb.

## Juriye Not 
- SQLite ile başlanan veritabanına firebase veritabanını da ekleyip hem online hem offline depolama yapılması konusunda araştırma yapıldı. Uygulama en başta SQLite ile kodlandığı için yedekleme konusunda firebase'in kullanılabileceği düşünüldü. Fakat SQLite'ın firebase ile senkronizasyonunun nasıl yapılabileceği bulunamadı. Bu sebeple veritabanının aynı şekilde offline olarak SQLite veritabanında kalmasına karar verildi.
- SQLite ve Firebase senkronizasyonu yapılamadığı için bu problemden önce eklenmiş olan Firebase kullanıcı girişi işlemlerinin uygulamaya not ekleme veya silme konusunda herhangi bir etkisinin olmadığı fark edilmiş olup uygulamanın genel işleyişinde bir sorun görülmediği için bu durum hata olarak değil tecrübesizlik sebebiyle yapılmış bir tutarsızlık olarak tanımlanmıştır. Çözüm olarak, senkronizasyon yapılamadığı için kullanıcı girişi işlemlerinin Firebase’den SQLite’a taşınarak cihaz üzerinde klasik SQL mantığı ile saklanabileceği düşünülmüştür fakat artık sprint sonuna gelindiği için yetiştirebilmek amacıyla bu haliyle kalmasına ve çalışan bir uygulama teslim edilmesine karar verilmiştir.

# Sprint 1

- Sprint notları: Trello'daki kırmızı kartlar user stories'leri temsil etmektedir. Item'lara tıklandığında detaylar okunabilir.

- Sprint içinde tamamlanması tahmin edilen puan: 125

- Puan tamamlama mantığı: Toplamda proje boyunca tamamlanması gereken 285 puanlık backlog bulunmaktadır. Ağırlığın ilk sprint'e verilerek 125 puan ile başlaması gerektiğine karar verildi.

- Daily Scrum: Daily Scrum toplantılarının discord ve whatsapp üzerinden yapılmasına karar verilmiştir. Discord üzerinden yapılan sesli konuşmalar,  whatsapp üzerinden özet şeklinde her toplantı sonunda proje ekibiyle paylaşılmıştır. Daily Scrum toplantı özetleri word olarak Readme'de tarafımızdan paylaşılmaktadır:
[F-138 Daily Scrum Chats ](https://raw.githubusercontent.com/gokcetrgn/ideapp/main/images/DAILYSCRUMSCREENSHOTS.docx) 

- Sprint board update: Sprint board ekran görüntüleri:
 [F-138 Sprint Board Screenshots ](https://raw.githubusercontent.com/gokcetrgn/ideapp/main/images/trellosema.png) 
  
- Ürün Durumu: Ekran görüntüleri:
<img src="https://raw.githubusercontent.com/gokcetrgn/ideapp/main/images/f1.jpg" height= "750" alt="fotoğraf1">
<img src="https://raw.githubusercontent.com/gokcetrgn/ideapp/main/images/f2.jpg" height= "750" alt="fotoğraf2">

- Sprint Review: Giriş sayfası, anasayfa, kategori, başlık ve not alma sayfası, kategori, başlık ve not okuma sayfaları tasarlanmış ve sqflite ile veritabanı kurulduktan sonra backend bağlantıları giriş sayfası hariç yapılmıştır. Ayrıca ilham verici kartlara API entegrasyonu gerçekleştirilmiştir. Kullanılan API aracı bilgileri: https://github.com/benhoneywill/stoic-quotes

- Sprint Retrospective:
Firebase entegrasyonu için takım üyelerinin teknik bilgi eksikliğini kapatması kararlaştırılmıştır. Hataların tespiti ve raporlanması için görevlendirme yapılması konuşulmuştur. Takım üyelerinin gelecek sprintlerde aktif olması gerektiği belirtilmiştir.

## Backlog URL: 

[Sprint 1 Backlog URL ](https://trello.com/b/A0KmX5gi/f-138-sprint-1) 

# Sprint 2
- Sprint notları: Trello'daki kırmızı kartlar user stories'leri temsil etmektedir. Item'lara tıklandığında detaylar okunabilir. 3 Sprint için 3 şema hazırlanmıştır, url güncellenmiştir.

- Sprint içinde tamamlanması tahmin edilen puan: 80
 
- Puan tamamlama mantığı: İlk sprintte tamamlanılan 125 puanın ardından bu sprintte 80 puanla devam edilmesi kararlaştırılmıştır.
 
- Daily Scrum: Daily Scrum toplantılarının discord ve whatsapp üzerinden yapılmasına karar verilmiştir. Discord üzerinden yapılan sesli konuşmalar,  whatsapp üzerinden özet şeklinde her toplantı sonunda proje ekibiyle paylaşılmıştır. Daily Scrum toplantı özetleri jpeg veya word olarak Readme'de tarafımızdan paylaşılmaktadır: [F-138 Daily Scrum Chats ](https://raw.githubusercontent.com/gokcetrgn/ideapp/main/images/Sprint2DailyScrumChats.docx)
- Sprint board update: Sprint board screenshotları:
   [To do ](https://raw.githubusercontent.com/gokcetrgn/ideapp/main/images/img_2.png) /
   [Doing](https://raw.githubusercontent.com/gokcetrgn/ideapp/main/images/doing.png) /
   [Done ](https://raw.githubusercontent.com/gokcetrgn/ideapp/main/images/done.png)
  
- Ürün Durumu: Ekran görüntüleri:
<img src="https://raw.githubusercontent.com/gokcetrgn/ideapp/main/images/img.png" height= "750" alt="fotoğraf1">
<img src="https://raw.githubusercontent.com/gokcetrgn/ideapp/main/images/img_1.png" height= "750" alt="fotoğraf2">

- Sprint Review: Hatalar düzeltilmiş ve uygulamada eksik görülen özelliklerden; kategori ve başlık arama, kategori ismi düzenleyebilme, kart yenileme, kategorilere anasayfadan ulaşabilme, e posta ile giriş yapabilme özellikleri eklenmiştir. 

- Sprint Retrospective: SQLite ile başlanan veritabanına firebase veritabanını da ekleyip hem online hem offline depolama yapılması konusunda araştırma yapıldı. Uygulama en başta SQLite ile kodlandığı için yedekleme konusunda firebase'in kullanılabileceği düşünüldü. Fakat SQLite'ın firebase ile senkronizasyonunun nasıl yapılabileceği bulunamadı. Bu sebeple veritabanının aynı şekilde offline olarak SQLite veritabanında kalmasına karar verildi.
  
## Product Backlog URL:
  [Sprint 2 Backlog URL ](https://trello.com/b/9jPO2q3Q/f-138-sprint-2) 

# Sprint 3
- Sprint notları: Trello'daki kırmızı kartlar user stories'leri temsil etmektedir. Item'lara tıklandığında detaylar okunabilir. 3 Sprint için 3 şema hazırlanmıştır, bu üçüncü sprint için geçerli olan urldir.
- Sprint içinde tamamlanması tahmin edilen puan: 80
  
- Puan tamamlama mantığı: Tamamlanılan 205 puanın ardından bu sprintte 80 puanla devam edilmesi kararlaştırılmıştır.

- Daily Scrum: Daily Scrum toplantılarının discord ve whatsapp üzerinden yapılmasına karar verilmiştir. Discord üzerinden yapılan sesli konuşmalar,  whatsapp üzerinden özet şeklinde her toplantı sonunda proje ekibiyle paylaşılmıştır. Daily Scrum toplantı özetleri jpeg veya word olarak Readme'de tarafımızdan paylaşılmaktadır: [F-138 Daily Scrum Chats ](https://raw.githubusercontent.com/gokcetrgn/ideapp/main/images/dailyscrumchats.docx)
-  Sprint board update: Sprint board screenshotları:
   [To do ](https://raw.githubusercontent.com/gokcetrgn/ideapp/main/images/todo3.png) /
   [Doing](https://raw.githubusercontent.com/gokcetrgn/ideapp/main/images/doing3.png) /
   [Done ](https://raw.githubusercontent.com/gokcetrgn/ideapp/main/images/donespr3.png)

- Ürün Durumu: Ekran görüntüleri:
<img src="https://raw.githubusercontent.com/gokcetrgn/ideapp/main/images/anaekran3.jpeg" height= "750" alt="fotoğraf1">
<img src="https://raw.githubusercontent.com/gokcetrgn/ideapp/main/images/3foto1.png" alt="fotoğraf2">

- Sprint Review: Hatalar giderilmeye çalışılmış ve tasarım eklenip uygulama son haline getirilmiştir. 
  
- Sprint Retrospective: SQLite ve Firebase senkronizasyonu yapılamadığı için bu problemden önce eklenmiş olan Firebase kullanıcı girişi işlemlerinin uygulamaya not ekleme veya silme konusunda herhangi bir etkisinin olmadığı fark edilmiş olup uygulamanın genel işleyişinde bir sorun görülmediği için bu durum hata olarak değil tecrübesizlik sebebiyle yapılmış bir tutarsızlık olarak tanımlanmıştır. Çözüm olarak, senkronizasyon yapılamadığı için kullanıcı girişi işlemlerinin Firebase’den SQLite’a taşınarak cihaz üzerinde klasik SQL mantığı ile saklanabileceği düşünülmüştür fakat artık sprint sonuna gelindiği için yetiştirebilmek amacıyla bu haliyle kalmasına ve çalışan bir uygulama teslim edilmesine karar verilmiştir. Bundan sonraki projelerde daha dikkatli olmanın altı çizilmiş, daha çok çalışıp eksik olunan noktaları gidermek gerektiği vurgulanmıştır.

## Product Backlog URL:
  [Sprint 3 Backlog URL ](https://trello.com/b/juBlxOfU/f-138-sprint-3) 
