
appname=$1
wordpress_flag=$2

rm -rf ../${appname}/
mkdir ${appname}
cp -rp Site_TEMPLATE/* ${appname}/

if $? != 0; then
  exit 1
fi

cd ${appname}
for files in `grep -R "<CHANGE_ME_TEMPLATE>" * | awk '{print $1}'| awk -F":" '{print $1}'`
   do 
     pwd
     echo $files
     sed "s|<CHANGE_ME_TEMPLATE>|${appname}|g" $files > ${files}_withsed
	 rm -f ${files}
	 mv ${files}_withsed  $files
     echo "=============================="
   done

mv ../${appname} ../../

cd ../../

if [ $wordpress_flag == "yes" ]; then
  rm -f ${appname}/htdocs/index.html
  tar -zxf Xampp_Script/wordpress_5.1.tar.gz --directory Xampp_Script/
  cp -rp Xampp_Script/wordpress/* ${appname}/htdocs/
  rm -rf Xampp_Script/wordpress
fi

pwd
ls -ltr

echo "Include \"C:/MyLab/xampp/apps/${appname}/conf/httpd-prefix.conf\"" >> /c/MyLab/xampp/apache/conf/httpd.conf

echo "${appname} application is ready to use"

cd /c/MyLab/xampp/
./xampp_stop.exe
./xampp_start.exe
   
