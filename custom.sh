read -p "Your Custom Iso:" iso
sudo apt-get update
apt-get install qemu -y
sudo apt install qemu-utils -y
sudo apt install qemu-system-x86 -y
qemu-img create -f raw memay.img 1T
wget -O virtio-win.iso 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-1/virtio-win-0.1.215.iso'
wget -O deptrai.iso $iso

curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
sudo qemu-system-x86_64 \
  -m 8G \
  -cpu EPYC \
  -boot order=d \
  -drive file=deptrai.iso,media=cdrom \
  -drive file=memay.img,format=raw \
  -drive file=virtio-win.iso,media=cdrom \
  -device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
  -device usb-tablet \
  -vnc :0 \
  -device e1000
  -smp cores=2 \
