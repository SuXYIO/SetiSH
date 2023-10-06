cd /
echo -e "\033[33mFor alpine linux v3.14 on ish 1.3.2\033[0m"
echo -e "\033[33mRecommend to read these carefully. If this program crashes the machine, just rerun this.\033[0m"
echo -e "\033[32mSetting apk mirrors to aliyun mirrors\033[0m"
echo http://mirrors.aliyun.com/alpine/v3.14/main > /etc/apk/repositories
echo http://mirrors.aliyun.com/alpine/v3.14/community >> /etc/apk/repositories
apk update
echo -e "\033[32mTesting network connection status to github.com\033[0m"
apk add curl
urlstatus=$(curl -s -m 5 -IL github.com | grep 200)
if [ "$urlstatus" == "" ]; then
	echo -e "\033[31mWarning: network connection to github.com is off, might not be able to properly install ohmyzsh and cause system problems. Recommend you to try to run this program later.\033[0m"
	apk del curl
	exit
else
	echo -e "\033[32mNetwork connection to github normal, download git,zsh,ohmyzsh.\033[0m"
fi
apk add git zsh
git clone http://github.com/ohmyzsh/ohmyzsh.git --depth 1
echo -e "\033[32mInstall openssh,curl,neofetch,neovim,clang,python3. Needs network (doesn't contain pip)\033[0m"
apk add openssh curl neofetch neovim python3 clang
echo -e "\033[32mPrevent apk mirrors reset during reboot\033[0m"
echo "echo "http://mirrors.aliyun.com/alpine/v3.14/main" > /etc/apk/repositories" > /root/repo.sh
echo "echo "http://mirrors.aliyun.com/alpine/v3.14/community" >> /etc/apk/repositories" >> /root/repo.sh
echo "source /root/repo.sh" >> /etc/profile
echo -e "\033[32mFix zsh no matches found when using * to find\033[0m"
echo "setopt nonomatch" >> ~/.zshrc
source ~/.zshrc
echo -e "\033[33mInstall finished, please check the messages above\033[0m"
echo -e "\033[33mEdit custom msg on startup. you can use the command "vi /etc/motd" to chang it yourself.\033[0m"
read SMSG
echo "$SMSG" > /etc/motd
echo -e "\033[33mDone. Reboot to apply all the changes"
echo -e "\033[33mInstalling zsh and ohmyzsh\033[0m"
sed -i "s/ash/zsh/g" /etc/passwd
cd /ohmyzsh/tools
sh install.sh

