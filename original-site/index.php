<?php 

if($_SERVER['REQUEST_URI'] != '/') {
	header('Location: /');
	die();
}

echo '<?xml version="1.0" encoding="ISO-8859-1" ?>'; ?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta name='description' content='Deze domeinnaam inclusief webhosting is geactiveerd maar er is nog geen pagina aangemaakt.' />
        <meta name="robots" content="index, all" />
        <meta name="author" content="Argeweb voor webhosting en domeinregistratie" />
        <title>Deze domeinnaam is geactiveerd</title>
        <link rel="stylesheet" type="text/css" href="http://www.argeweb.nl/style.css" />
        <style type="text/css">
            div.innerContentBox {
                background-color:#f0f3f8;
                border-bottom:2px solid #a61040;
                padding-top:7px;
                padding-right:5px;
            }
            div.innerContentText {
                margin-left: 35px;
                margin-right: 35px;
            }
        </style>
    </head>
    <body>
        <div id="wrapper" style="">
            <div id="main" style="background:none;">
                <div id="header" style="background-image:none;">
                    <img src="http://www.argeweb.nl/images/102003_linksboven4.jpg" alt="linksboven4.jpg" id="logolinks" style="border:0;" />
                </div>
                <div class="whoisbox" style="width:90%;height:80px;margin-left:5%;margin-top:30px;">
                    <a href="http://www.argeweb.nl"><img src="http://www.argeweb.nl/images/102003_logolinks2.jpg" alt="Argeweb" style="float:left;margin-top:13px;border:0;" /></a>
                    <br />
                    <form id="whois2" method="post" action="https://www.argeweb.nl/bestellen/index.php?functie=whois">
                        <div style="float:right;margin-right:10px;">
                            <strong>Is uw domein nog beschikbaar?</strong><br />
                            <span class="www">www.</span>
                            <input type="text" name="sb_domein" size="15" class="inputbox" />.
                            <select size="1" name="sb_extensie" class="inputbox">
                                <option value="alles">alle</option>
                                <option value='nl'>.nl</option>
                                <option value='com'>.com</option>
                                <option value='net'>.net</option>
                                <option value='org'>.org</option>
                                <option value='info'>.info</option>
                                <option value='biz'>.biz</option>
                                <option value='eu'>.eu</option>
                                <option value='be'>.be</option>
                                <option value='nu'>.nu</option>
                                <option value='de'>.de</option>
                                <option value='mobi'>.mobi</option>
                                <option value='es'>.es</option>
                                <option value='co.uk'>.co.uk</option>
                                <option value='at'>.at</option>
                                <option value='it'>.it</option>
                                <option value='me'>.me</option>
                                <option value='tv'>.tv</option>
                            </select>
                            <input type="submit" name="submit" value="Check!" class="inputbox" />
                        </div>
                    </form>
                </div>
                <div class="contentBox" style="width:90%;margin-left:5%;">
                    <h6>DEZE DOMEINNAAM IS GEACTIVEERD</h6>
                    <div class="innerContentBox">
                        <div class="innerContentText">


                            Het webhostingpakket is aangemaakt en de domeinnaam is geregistreerd of verhuisd.
                            <br /><br />

                            <strong>Hoe plaats ik mijn website op internet?</strong>

                            <ul>
                                <li>Dit kunt u doen met behulp van een FTP-programma of via de Script installer.</li>
                            </ul>

                            <br />
                            <strong>Mijn website staat op de server, maar ik blijf deze pagina zien. Hoe kan dat?</strong><br />
                            <ul>
                                <li> Verwijder eerst deze pagina (het bestand index.php in de map /public_html/) en zorg dat de eerste pagina die geladen moet worden als iemand uw domeinnaam bezoekt als index.html, index.htm of index.php opgeslagen staat in de map /public_html/.</li>
                                <li> Druk op CTRL-SHIFT-VERNIEUWEN (REFRESH) om de pagina te herladen.</li>
                            </ul>

                            <ul>
                                <li> U vindt alle nodige informatie op de <a href="http://www.customersite.nl">Customer Site</a>.</li>
                            </ul>

                            <br />
                            <strong>Hoe kom ik op de Customer Site?</strong>

                            <ul>
                                <li> U surft naar <a href="http://www.customersite.nl">www.customersite.nl</a> en u vult daar uw debiteurnummer/klantnummer en uw wachtwoord in. Let op! Dit wachtwoord is niet hetzelfde wachtwoord als voor uw FTP en Email.</li>
                            </ul>

                            <ul>
                                <li> U kunt contact met ons opnemen via onze online helpdesk. Deze vindt u op de <a href="http://www.customersite.nl">Customer Site.</a></li>
                                <li> Onze contactgegevens vindt u op onze website.</li>
                            </ul>

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </body>
</html>
