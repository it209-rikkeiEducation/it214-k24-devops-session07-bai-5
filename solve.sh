#!/bin/bash
set -e

PORT=8082

echo "=== 1. Gia lap cong $PORT bi chiem dung ==="
python3 -m http.server $PORT > /dev/null 2>&1 &
PYTHON_PID=$!
sleep 1

echo "=== 2. Kiem tra tien trinh dang chiem cong $PORT ==="
sudo ss -tlnp | grep ":$PORT" || sudo lsof -i :$PORT || true

echo "=== 3. Tim PID va tat tien trinh chiem dung ==="
OCCUPIED_PID=$(sudo lsof -t -i :$PORT || true)
if [ -n "$OCCUPIED_PID" ]; then
    echo "Phat hien PID $OCCUPIED_PID dang chiem cong $PORT. Tien hanh kill..."
    sudo kill -9 $OCCUPIED_PID
    echo "Da giaiphong cong $PORT."
else
    echo "Khong tim thay tien trinh chiem dung cong $PORT."
fi

echo "=== 4. Khoi dong lai dich vu spring-app.service ==="
if systemctl list-unit-files | grep -q spring-app.service; then
    sudo systemctl restart spring-app.service
    echo "Da restart spring-app.service."
else
    echo "Canh bao: spring-app.service khong ton tai tren he thong nay, bo qua buoc restart service."
fi

echo "=== 5. Kiem tra lai cong $PORT ==="
sudo ss -tlnp | grep ":$PORT" || sudo lsof -i :$PORT || echo "Cong $PORT hien chua duoc lang nghe."
