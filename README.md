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
