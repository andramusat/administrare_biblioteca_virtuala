# VIZUALIZARE
view_f()
{ echo “Vizualizare baza de date”
if [[ -f “carti” ]]
then
while IFS= read -r linie
do echo “$line”
done < “carti”
else
echo “Baza de date nu exista.”
fi 
}
view_f

# ADAUGARE
add_f()
{ while true
do
echo “Adaugare carti”
read -p “Ttilul cartii:” titlu
read -p “Numele autorului:” nume
read -p “Anul in care a aparut cartea:” an
echo “$titlu|$nume|$an”
read -p “Datele sunt corecte? (y/n)” answ
case “$answ” in
[Yy])
echo “Adaugare in baza de date”
echo “$titlu|$nume|$an” >> carti
sort -u carti -o carti
echo “Mai adaugati? (y/n)”
read answ
if [ $answ = “Y” -o $answ = “y” ]
then
continue
else
return
fi
;;
*)
echo “Incercati din nou? (y/n)”
read answ
case “$answ” in
[Yy]) continue
;;
[Nn]) return
;;
*)
echo “Optiunea nu este valida!”
;;
esac
;;
esac
done
}
add_f

# CAUTARE
search_f()
{ echo “Cautare carti”
echo -e “\n Introduceti titlul cartii, numele autorului sau anul in care a aparut:\c”
read name
grep -i “$name” carti > /dev/null
if [ $? -eq 0 ]
then
echo ”------------- ”
grep -i ”$name” carti
echo ”--------------”
else 
echo ”$name nu a fost gasit in baza de date.”
fi
read -p „Apasati tasta ENTER pentru a continua” key
} 
search_f

# ACTUALIZARE
update_f()
{ echo „Actualizare carti”
echo -e „\n Introduceti titlul cartii pe care doriti sa o inlocuiti, numele autorului si anul in care a 
aparut:\c”
read name_vechi
Echo -e „\n Introduceti noul titlu, numele autorului si anul in care a aparut cartea:\c”
read name_nou
sed s/”$name_vechi”/”$name_nou”/ carti > carti_new
if [ $? -eq 0 ]
then
echo „Modificarea s-a realizat.”
mv carti.new carti
else
echo ”Eroare.”
fi
}
update_f

# STERGERE
delete_f()
{ echo „Stergere carti din baza de date”
echo -e „Introduceti titlul cartii pe care doriti sa o eliminati din baza de date, numele autorului 
si anul in care a aparut(<ENTER> pentru iesire):\c”
read name
if [ „$name” == ” ” ]
then 
continue
fi
sed -e /”$name”/d carti > carti.new
mv carti.new carti
cat carti
read -p ”Apasati ENTER pentru a continua.” Key
}
delete_f

# IESIRE
exit_f()
{ echo ”Multumim pentru timpul acordat!”
exit 0
}
exit_f
