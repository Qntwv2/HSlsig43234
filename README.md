# vuohi.org klooni VÄRI EI TOIMI

Ohjeet hostaukseen:

1. Kloonaa repositorio esim. ```git clone https://github.com/vuohigoat/vuohi-clone/```
2. ```cd vuohi-clone```
3. Pythonin pitäisi olla automaattisesti asennettuna. Käytä pythonin http-serveriä: ```python3 -m http.server```
4. Löydät vuohen osoitteesta ```localhost:8000```

Huom. linkit eivät toimi eli siirry simulaattoriin lisäämällä urlin loppuun /ticket.html tai /settings.html  Dashboard ei toimi!!!

Voit tässä vaiheessa kokeilla puhelimella sivua. ```Kirjoita hostname -I``` ja saat koneen private IP selville. Kirjoita tämä puhelimen selaimeen esim. ```192.168.10.1:8000```

Jos haluat, että saat vuoheen yhteyden myös kodin wifin ulkopuolelta, sinun tulee luoda routterisi asetuksissa uusi NAT-sääntö ja avata portti 8000. Tai voit ostaa itsellesi palvelimen esimerkiksi googlelta.
