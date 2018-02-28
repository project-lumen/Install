########################### MAIN MENU ##############################
    ####### Installation Virtual box #######
     read -p "
    _______________________________________________________________
    | Menu :                                                        |
    | 1 - Installer Virtual box                                     |
    | 2 - Ne pas installer virtual box                              |
    _______________________________________________________________
    " menu;
    if [[ $menu -eq 1 ]]
    then
            ####### Votre OS #######
             read -p "
            _______________________________________________________________
            | Menu :                                                        |
            | 1 - MAC                                                       |
            | 2 - Linux apt                                                 |
            _______________________________________________________________
            " menu;
            if [[ $menu -eq 1 ]]
            then
              wget https://download.virtualbox.org/virtualbox/5.2.6/VirtualBox-5.2.6-120293-OSX.dmg
            elif [[ $menu -eq 2 ]]
            then
              sudo apt install -y virtualbox-qt
            else
             echo "Saisie incorrect";
           fi
    elif [[ $menu -eq 2 ]]
    then
     echo "Non installer";
    else
     echo "Saisie incorrect";
    fi


    ####### Installation Vagrant #######
     read -p "
    _______________________________________________________________
    | Menu :                                                        |
    | 1 - Installer Vagrant                                         |
    | 2 - Ne pas installer Vagrant                                  |
    _______________________________________________________________
    " menu;
    if [[ $menu -eq 1 ]]
    then
          ####### Votre OS #######
           read -p "
          _______________________________________________________________
          | Menu :                                                        |
          | 1 - MAC                                                       |
          | 2 - Linux apt                                                 |
          _______________________________________________________________
          " menu;
          if [[ $menu -eq 1 ]]
          then
            wget https://releases.hashicorp.com/vagrant/2.0.2/vagrant_2.0.2_x86_64.dmg
          elif [[ $menu -eq 2 ]]
          then
            sudo apt install -y vagrant
          else
           echo "Saisie incorrect";
         fi
    elif [[ $menu -eq 2 ]]
    then
      echo "Non installer";
    else
     echo "Saisie incorrect";
    fi


  #### VERIF DOSSIER data  ####
  if [ ! -d data ];
  then
      mkdir data
      echo -e "
      \033[44mLe dossier data a été creer !\033[0m"
  else
      echo -e "
      \033[45mUn dossier data existe deja !\033[0m"
  fi

  #### VERIF DOSSIER project  ####
  if [ ! -d project ];
  then
      mkdir project
      echo -e "
      \033[44mLe dossier project a été creer !\033[0m"
  else
      echo -e "
      \033[45mUn dossier project existe deja !\033[0m"
  fi



  #### MODIF VAGRANT FILE ####

  #### VERIF VAGRANTFILE ####
  if [ ! -f Vagrantfile ];
  then

      echo "
      # -*- mode: ruby -*-
      # vi: set ft=ruby :
      Vagrant.configure(\"2\") do |config|
      config.vm.box = \"ubuntu/xenial64\"
      config.vm.synced_folder \"./data\", \"/var/www/html\"
      config.vm.network \"private_network\", ip: \"192.168.33.10\"
      config.vm.network \"forwarded_port\", guest: 8000, host: 8000

      config.vm.provision \"shell\", path: \"setup.sh\"
      end" > Vagrantfile

      echo -e "
      \033[44mLe fichier Vagrantfile a été généré !\033[0m"
      echo "Ip connection 192.168.33.10";
  else
      echo -e "
      \033[45mUn Vagrantfile existe déjà dans ce dossier !\033[0m"
      ####### Votre OS #######
       read -p "
      _______________________________________________________________
      | Menu : Voulez vous le modifier                                |
      | 1 - Oui                                                       |
      | 2 - Non                                                       |
      _______________________________________________________________
      " menu;
      if [[ $menu -eq 1 ]]
      then
        echo "
        # -*- mode: ruby -*-
        # vi: set ft=ruby :
        Vagrant.configure(\"2\") do |config|
        config.vm.box = \"ubuntu/xenial64\"
        config.vm.synced_folder \"./data\", \"/var/www/html\"
        config.vm.network \"private_network\", ip: \"192.168.33.10\"
        config.vm.network \"forwarded_port\", guest: 8000, host: 8000
        config.vm.provision \"shell\", path:\"setup.sh\", privileged:false
        end" > Vagrantfile
        echo "Ip connection 192.168.33.10";
      elif [[ $menu -eq 2 ]]
      then
        echo "Ok"
      else
       echo "Saisie incorrecte";
     fi
  fi

  # deplacer wp.sh dans dossier data
    vagrant up
    vagrant provision
 ####### SSH Installation reppo Git/Mongo/lumen #######

    ####### Clone reppo #######
     read -p "
    _______________________________________________________________
    | Menu : Choix branch back-lumen                                |
    | 1 - master (prod)                                             |
    | 2 - Develop                                                   |
    _______________________________________________________________
    " menu;
    cd data
    if [[ $menu -eq 1 ]]
    then
      git clone https://github.com/project-lumen/back-lumen.git
      echo "OK"
    elif [[ $menu -eq 2 ]]
    then
      git clone -b develop https://github.com/project-lumen/back-lumen.git
      echo "OK"
    else
     echo "Saisie incorrecte";
   fi
    cd ../

    read -p "
   _______________________________________________________________
   | Menu : Choix branch front-electron                            |
   | 1 - master (Prod)                                             |
   | 2 - Develop                                                   |
   _______________________________________________________________
   " menu;
   cd project
   if [[ $menu -eq 1 ]]
   then
     git clone https://github.com/project-lumen/front-electron.git
     echo "OK"
   elif [[ $menu -eq 2 ]]
   then
     git clone -b develop https://github.com/project-lumen/front-electron.git
     echo "OK"
   else
    echo "Saisie incorrecte";
  fi
   cd ../
    vagrant ssh
