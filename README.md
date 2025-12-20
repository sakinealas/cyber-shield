# cyber-shield – Siber Olay Müdahale İstasyonu – Cyber Shield Projesi

## Proje Tanımı
Bu proje, AKİS dersi kapsamında güvenli yazılım geliştirme prensiplerini uygulamak amacıyla oluşturulmuştur. 
Proje süresince kimlik yönetimi, erişim kontrolü, yetkilendirme ve yapılandırma güvenliği konuları ele alınmıştır.

## Amaç
- Git tabanlı sürüm kontrolü kullanımı
- Sunucu tarafında kullanıcı ve grup bazlı yetkilendirme
- ACL (Access Control List) ile dosya erişim güvenliği sağlanması
- Açık kaynak lisanslama bilincinin kazanılması

## Kapsam
Bu depo, projenin kaynak kodlarını, yapılandırma dosyalarını ve güvenlik yapılandırmalarını içermektedir.

## Kurulum ve Çalıştırma
Proje Linux tabanlı bir ortamda çalışacak şekilde tasarlanmıştır. Gerekli bağımlılıkların
kurulmasının ardından proje dizini klonlanarak servisler ayağa kaldırılabilir.
```bash
git clone https://github.com/sakinealas/cyber-shield.git
cd cyber-shield
Gerekli dizin yapıları kontrol edilir:
         /var/www/cyber-shield → Web uygulaması
         /opt/cyber-shield/evidence → Kritik delil klasörü
Yetkili kullanıcı ve gruplar oluşturulur:
         webadmin → Web dizini yönetimi
         analysts → Delil analizi yetkisi
Dosya ve dizin izinleri ACL ve SGID kullanılarak yapılandırılır:
         /var/www yalnızca webadmin grubuna açıktır
         evidence dizini yalnızca analysts grubuna açıktır
         Default ACL sayesinde yeni dosyalar otomatik olarak korunur
Servisler ve betikler (scripts) sistem servisleri üzerinden çalıştırılabilir hale getirilir.

## Lisans Seçimi (GPLv3)
Bu projede GNU General Public License v3 (GPLv3) tercih edilmiştir. 
Bu lisansın seçilme nedeni, projenin ve projeden türetilen çalışmaların açık kaynak olarak kalmasının garanti altına alınmak istenmesidir.

GPLv3, yazılımın özgürce kullanılmasına, incelenmesine, değiştirilmesine ve dağıtılmasına izin verirken; 
türetilen çalışmaların da aynı lisans koşullarıyla paylaşılmasını zorunlu kılar. 
Bu sayede proje, kapalı kaynaklı hale getirilemez ve açık kaynak felsefesine uygun şekilde sürdürülebilirliği sağlanır.

## Proje Dizin Yapısı ve Güvenlik Tasarımı
docker/
Projenin taşınabilir ve izole bir ortamda çalıştırılabilmesi amacıyla Docker yapılandırmaları bu dizin altında tutulmuştur. Bu yaklaşım kurulum bağımlılıklarını azaltmakta ve tekrar edilebilirliği sağlamaktadır.

scripts/
Siber olay tespiti ve müdahale süreçlerinde kullanılan tüm Bash script’leri bu dizin altında merkezi olarak toplanmıştır. Script’ler log analizi, sistem izleme ve şüpheli IP yönetimi gibi görevleri yerine getirmektedir.

services/
Script’lerin sistem seviyesinde otomatik çalıştırılabilmesi için systemd servis ve zamanlayıcı (timer) dosyaları bu dizinde konumlandırılmıştır. Bu sayede sürekli izleme ve otomasyon sağlanmıştır.

evidence/
Olay müdahalesi sürecinde elde edilecek dijital kanıtların saklanması için ayrılmıştır. Klasör bilinçli olarak boş bırakılmış, yalnızca Git tarafından takip edilebilmesi amacıyla .gitkeep dosyası eklenmiştir. Bu yaklaşım delil bütünlüğü prensibine uygundur.

.gitignore
Log çıktıları ve geçici dosyaların sürüm kontrolüne dahil edilmemesi için yapılandırılmıştır.

README.md ve LICENSE
Projenin amacı, mimarisi ve kullanım yaklaşımı README dosyasında açıklanmış; açık kaynak lisanslama ile yeniden kullanılabilirlik sağlanmıştır.

## Proje Dizin Yapısı ve Güvenlik Tasarımı
Kritik delil klasörleri, olay müdahale senaryosu kapsamında güvenli olacak şekilde yapılandırılmıştır. 
Evidence dizini root sahipliğinde oluşturulmuş, Access Control List (ACL) kullanılarak yalnızca yetkili analiz grubunun erişimine açılmıştır. Default ACL (setfacl -d) tanımlanarak sonradan oluşturulan dosyaların da otomatik olarak aynı yetkilendirme politikalarıyla korunması sağlanmıştır.

## Kullanıcı / Grup İzolasyonu ve Dosya Yetkilendirme
Bu projede web kök dizini olan /var/www/cyber-shield için kullanıcı ve grup bazlı yetkilendirme uygulanmıştır.
Dizin sahibi root, grup sahibi ise webadmin olarak yapılandırılmıştır.
Dizinde SGID biti etkinleştirilmiş (chmod 2770) ve ACL ile yetkilendirme yapılmıştır.
Bu sayede yalnızca webadmin grubuna üye kullanıcılar dizin üzerinde işlem yapabilmektedir.
Ayrıca Default ACL (setfacl -d) tanımlanarak, dizin altında oluşturulan yeni dosyaların da otomatik olarak aynı yetkileri miras alması sağlanmıştır.
other (yetkisiz) kullanıcılar için tüm erişimler kapatılmıştır.
Bu yapılandırma ile En Az Yetki (Least Privilege) ilkesi uygulanmış ve yetkisiz erişim bilinçli olarak engellenmiştir.

## Süreç (Process) İzleme
Bu projede Linux sistem üzerinde çalışan süreçler CPU ve RAM kullanımına göre analiz edilmiştir. Anormal süreçler (Zombie process) kontrol edilmiş ve sistemde olağandışı bir durum tespit edilmemiştir.

Log Analizi
Güvenlik logları grep, awk, sed ve Regex kullanılarak işlenmiş; saldırgan IP adresleri ve saldırı sayıları ayıklanmıştır. Elde edilen veriler temiz bir formatta raporlanmış ve en çok saldıran IP listenin başında gösterilmiştir.

Otomasyon
Log analizi bir Bash betiği ile otomatikleştirilmiş, betiğin CPU süresi ve bellek kullanımı (time / RSS) raporlanmıştır.

## SERVİS YÖNETİMİ VE GÜNLÜKLEME
-Systemd servisi systemctl edit yöntemiyle özelleştirilmiş, servis davranışı override yapılandırması ile kontrol altına alınmıştır.

-Servis dosyasında Restart=on-failure ve RestartSec parametreleri kullanılarak hata durumlarında otomatik yeniden başlatma mekanizması uygulanmıştır.

-Servis bağımlılıkları doğru şekilde tanımlanmış, ağ servisi hazır olmadan başlatılmaması için After=network.target kullanılmıştır.

-Servise ait hata kayıtları journalctl -u <servis_adı> -p err filtresi ile analiz edilmiş, kritik veya hata seviyesinde log tespit edilmemiştir.

-Servis logları logrotate ile yönetilmiş, yapılandırma logrotate -f komutu kullanılarak zorla tetiklenmiş ve log döndürme işleminin başarılı olduğu kanıtlanmıştır.

-Sistem paketleri (systemd, logrotate vb.) APT üzerinden hatasız şekilde yönetilmiş, servislerin kararlı çalıştığı doğrulanmıştır.

## Sistem Sertleştirme ve Otomasyon
Bu haftada sistem erişimi ve otomasyon süreçleri güvenlik odaklı şekilde yapılandırılmıştır.
SSH erişimi parola tabanlı kimlik doğrulama kapatılarak yalnızca anahtar (key-based) üzerinden sağlanmıştır. Root kullanıcısı ile doğrudan erişim devre dışı bırakılmıştır.

Açık portlar ss komutu ile analiz edilmiş, SSH logları üzerinden başarısız giriş denemeleri tespit edilmiştir. Belirlenen eşik değerin üzerindeki IP adresleri otomatik olarak ufw güvenlik duvarı kurallarına eklenerek engellenmiştir.

Otomasyon betiği modüler (fonksiyon bazlı) yapıda geliştirilmiş, set -e ve trap kullanılarak hata yönetimi sağlanmıştır. Gereksiz tekrar çalışmaları önlemek amacıyla önbellek (cache) mekanizması uygulanmıştır.

Betik, systemd service ve systemd timer kullanılarak insan müdahalesi olmadan periyodik olarak çalışacak şekilde zamanlanmış, tüm çıktılar merkezi log dosyasına kaydedilmiştir.
