sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install nginx -y

sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs 
sudo apt-get install npm
sudo npm install pm2 -g

sudo apt-get install python-software-properties -y

mkdir repo

cd repo

git clone https://github.com/snaaleeye/eng114_dev_ops.git

cd eng114_dev_ops/

sudo mv default /etc/nginx/sites-available/default

sudo systemctl restart nginx

sudo echo "export DB_HOST=mongodb://172.31.20.139:27017/posts" >> ~/.bashrc

source ~/.bashrc

cd app/app/
sudo npm install -y
sudo npm start -d