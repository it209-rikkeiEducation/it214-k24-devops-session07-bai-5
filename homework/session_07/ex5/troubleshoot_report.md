# Bao cao Chan doan va Xu ly Xung dot Cong mang (Port 8082)

## 1. Boi canh
Khi khoi chay ung dung `spring-app.service` tren cong `8082`, he thong bao loi `Address already in use` do cong `8082` dang bi chiem giu boi mot tien trinh khac chay ngam.

## 2. Quy trinh chan doan va xu ly

### Buoc 1: Gia lap su co xung dot cong
Chay mot web server bang Python duoi nen de chiem dung cong 8082:
```bash
python3 -m http.server 8082 > /dev/null 2>&1 &
```

### Buoc 2: Kiem tra va xac dinh PID cua tien trinh chiem dung
Su dung cong cu `ss` hoac `lsof` de kiem tra cong 8082:
```bash
sudo ss -tlnp | grep 8082
# Hoac:
sudo lsof -i :8082
```
**Ket qua ghi nhan:**
- Tien trinh dang lang nghe: `python3`
- PID tim duoc: `12345` (vi du)
- Cong bi chiem: `8082`

### Buoc 3: Tieu diet tien trinh chiem dung cong
Su dung lenh `kill` (hoac `kill -9` neu can) de cham dut tien trinh:
```bash
sudo kill -9 <PID>
```

### Buoc 4: Khoi dong lai dich vu Spring Boot
Khoi dong lai dich vu `spring-app.service` de ung dung Java chiem quyen su dung cong 8082:
```bash
sudo systemctl restart spring-app.service
```

### Buoc 5: Xac nhan ket qua
Kiem tra lai trang thai cong 8082:
```bash
sudo ss -tlnp | grep 8082
```
**Ket qua thu duoc:**
Cong 8082 da duoc chuyen giao thanh cong cho tien trinh `java` (chay `app.jar`).


## Ảnh chụp màn hình kết quả thực nghiệm
![Kết quả thực nghiệm](git_verification_result.png)
