# git pull
echo "tuflix" && npm install
echo "oci-storage" && cd oci-storage && npm install && cd ..
echo "gateway" && cd gateway && npm install && cd ..
echo "metadata" && cd metadata && npm install && cd ..
echo "video-streaming" && cd video-streaming && npm install && cd ..
echo "video-upload" && cd video-upload && npm install && cd ..
echo "history" && cd history && npm install && cd ..
