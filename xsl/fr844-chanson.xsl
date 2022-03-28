<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"  
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- Supprime les espaces non voulues-->
    <xsl:strip-space elements="*"/>
    
    <!-- Structure du HTML -->
    <xsl:template match="div[@type='lyrical_text']">
        <xsl:variable name="chansonnierParent" select="fn:lower-case(replace(./preceding-sibling::head/text(), ' ', '-'))"/>
        <xsl:result-document href="../html/fr844-{$chansonnierParent}/{./@xml:id}.html" method="html" indent="yes">
            <html>
                <head>
                    <xsl:element name="title">
                        <xsl:text>Corpus lyrique de Thibaut de Champagne|</xsl:text>
                        <xsl:choose>
                            <xsl:when test="./note/bibl/title/text()">
                                <xsl:value-of select="./note/bibl/title/text()"/>
                            </xsl:when>
                            <!-- Si la chanson est sans titre, on inscrit son @xml:id dans l'élément title -->
                            <xsl:otherwise>
                                <xsl:value-of select="./@xml:id"/>
                            </xsl:otherwise>
                        </xsl:choose>    
                    </xsl:element>
                    <xsl:call-template name="bootstrapCore"/>
                    <xsl:call-template name="stylePageChanson"/>
                    <xsl:call-template name="scriptApparat"/>
                </head>
                <body>
                    <xsl:call-template name="navbar"/>
                    <div class="chansonConteneur">
                        <h1 class="display-4 fst-italic">
                            <xsl:choose>
                                <xsl:when test="./note/bibl/title/text()">
                                    <xsl:value-of select="./note/bibl/title/text()"/>
                                </xsl:when>
                                <!-- Si la chanson est sans titre -->
                                <xsl:otherwise>
                                    <xsl:text>[Sans titre]</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </h1>
                        <xsl:apply-templates select="child::note"/>
                        <div class="corpsChanson">
                            <div class="img">
                                <!-- On récupère dans le premier lb de la chanson le numéro correspondant à la page sur Gallica -->
                                <xsl:variable name="page" select="replace(substring(./descendant::lb[1]/@facs, 7), '_.*', '')"/>
                                <a href="https://gallica.bnf.fr/ark:/12148/btv1b84192440/f{$page}">                                
                                    <img src="https://gallica.bnf.fr/iiif/ark:/12148/btv1b84192440/f{$page}/full/500/0/default.jpg" alt="Gallica, Paris, BNF, fr. 844, f{$page}"/>
                                </a>                                
                            </div>
                            <div class="txt">
                                <xsl:apply-templates select="descendant::lg[@type='stanza']" mode="graphem"/>
                            </div>
                            <div class="txt">
                                <xsl:apply-templates select="descendant::lg[@type='stanza']" mode="interp"/>
                            </div>
                        </div>
                    </div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- Introduction à la chanson -->
    <xsl:template match="div[@type='lyrical_text']/note">
        <!-- Présentation de la chançon -->
        <div class="intro">
            <header>
                <!-- Le nom de l'auteur s'il est certain -->
                <xsl:value-of select=".//author[@cert='high']"/>
            </header>
            <div class="introConteneur">
                <div class="introColonne">
                    <div>
                        <h2>Références</h2>
                        <xsl:variable name="listeCorresp" as="item()" select="./bibl/@corresp"/>
                        <ul>
                            <xsl:if test=".//idno[@type='RS']">
                                <li>RS : <xsl:value-of select=".//idno[@type='RS']"/></li>
                            </xsl:if>
                            <xsl:for-each select="tokenize($listeCorresp, ' ')">
                                <li><xsl:value-of select="replace(replace(current(), '#', ''), '_', ' : ')"/></li>
                            </xsl:for-each>
                        </ul>                
                    </div>
                    <div>
                        <h2>Autorités</h2>
                        <ul>
                            <xsl:for-each select=".//author[not(@cert='high')]">
                                <li>
                                    <xsl:value-of select="current()/witDetail/text()"/>
                                    <span>
                                        <xsl:text> (</xsl:text>
                                        <xsl:value-of select="replace(current()/witDetail/@wit, '#', '')"/>
                                        <xsl:text>)</xsl:text>
                                    </span>
                                    <xsl:if test="current()/note">    
                                        <span>
                                            <xsl:text>. </xsl:text>
                                            <xsl:apply-templates select="current()/note"/>
                                        </span>
                                    </xsl:if>
                                </li>
                            </xsl:for-each>
                        </ul>
                    </div>
                </div>
                <div class="introColonne">
                    <div>
                        <h2>Musique</h2>
                        <p>
                            <xsl:apply-templates select=".//notatedMusic/desc"/>
                        </p>
                    </div>
                    <xsl:if test="./bibl/note">
                        <div>
                            <h2>Note</h2>
                            <p>
                                <xsl:apply-templates select="./bibl/note"/>
                            </p>
                        </div>
                    </xsl:if>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <!-- Strophes -->
    <xsl:template match="lg[@type='stanza']" mode="#all">
        <div>
            <xsl:attribute name="n">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:attribute name="class">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:apply-templates select="l"  mode="#current"/>
        </div>
    </xsl:template>
    
    <!-- Vers -->
    <xsl:template match="l" mode="#all">
        <p>
            <xsl:attribute name="title">
                <!-- On compte les l en continu à l'intérieur de chaque div -->
                <xsl:number count="l" level="any" format="1" from="div"/>
            </xsl:attribute>
            <xsl:apply-templates mode="#current"/>
        </p>
    </xsl:template>
    
    <!-- Lettres ornées -->
    <xsl:template match="hi[@rend='ornate_initial']" mode="#all">
        <span class="ornate_initial">        
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    <!-- Mots -->
    <xsl:template match="w" mode="graphem">
        <xsl:choose>  
            <!-- Le mot n'est pas suivi d'une espace en cas d'élision -->
            <xsl:when test=".[@rend='elision']">
                <xsl:apply-templates mode="graphem"/>
            </xsl:when>
            <!-- Le mot n'est pas suivi d'une espace en cas d'agglutination -->
            <xsl:when test=".[@rend='aggl']">
                <xsl:apply-templates mode="graphem"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates mode="graphem"/>
                <xsl:text> </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="w" mode="interp">
        <xsl:choose>  
            <xsl:when test=".[@rend='elision']">
                <xsl:apply-templates mode="interp"/>
                <xsl:text>'</xsl:text>
            </xsl:when>
            <!-- Le mot est  suivi d'une espace en cas d'agglutination -->
            <xsl:when test=".[@rend='aggl']">
                <xsl:apply-templates mode="interp"/>
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <!-- Si le mot est suivi d'un élément pc, il n'est pas suivi d'une espace -->
                    <xsl:when test="./following-sibling::*[1]/self::pc[descendant::reg/text()]">
                        <xsl:apply-templates mode="interp"/>
                    </xsl:when>
                    <!-- De même s'il est suivi d'un "lb" puis d'un "pc" -->
                    <xsl:when test="./following-sibling::*[1][self::lb]">
                        <xsl:choose>
                            <xsl:when test="./following-sibling::*[2][self::pc]">    
                                <xsl:apply-templates mode="interp"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates mode="interp"/>
                                <xsl:text> </xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>    
                        <xsl:apply-templates mode="interp"/>
                        <xsl:text> </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="app" mode="graphem">
        <xsl:apply-templates select="lem" mode="graphem"/>
    </xsl:template>
    
    <xsl:template match="app" mode="interp">
        <xsl:apply-templates select="lem" mode="interp"/>
        <!-- Les leçons rejetées en apparat -->
        <xsl:if test="./rdg[@wit='#Mt']">
            <span>
                <xsl:attribute name="style">
                    <xsl:text>color : rgb(000, 200, 100, 0.7)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="class">
                    <xsl:text>Mt</xsl:text>
                </xsl:attribute>
                <xsl:text> </xsl:text>
                <xsl:value-of select="./rdg[@wit='#Mt']"/>
                <!-- Si la leçon est suivie d'un élément "w", on ajoute une espace -->
                <xsl:if test="./following-sibling::w">
                    <xsl:text> </xsl:text>
                </xsl:if>
            </span>
        </xsl:if>
        <xsl:if test="./rdg[@resp='#Wallenskold']">
            <span>
                <xsl:attribute name="style">
                    <xsl:text>color : rgb(015, 005, 230, 0.8)</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="class">
                    <xsl:text>Wall</xsl:text>
                </xsl:attribute>
                <xsl:text> </xsl:text>
                <xsl:value-of select="./rdg[@resp='#Wallenskold']"/>
                <xsl:choose>    
                    <xsl:when test="./following-sibling::w">
                        <xsl:text> </xsl:text>
                    </xsl:when>
                </xsl:choose>
            </span>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="lem" mode="interp">
        <!-- En mode interp, on veut pouvoir baliser le lem avec un <span style="font-weight: bold;"> -->
        <span>    
            <xsl:attribute name="class">
                <xsl:text>lem</xsl:text>
            </xsl:attribute>
            <xsl:if test="gap">
                <xsl:text>[…] </xsl:text>
            </xsl:if>
            <xsl:apply-templates mode="interp"/>
        </span>
    </xsl:template>
    
    <xsl:template match="lem" mode="graphem">
        <xsl:apply-templates mode="graphem"/>
        <xsl:if test="gap">
            <xsl:text>[…] </xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="choice" mode="graphem">
        <xsl:value-of select="sic"/>
        <xsl:if test="sic[not(text())]">
            <xsl:choose>
                <!-- Si une correction est proposée, on inscrit entre crochets l'éventuelle forme "orig", sinon, le noeud texte de "corr", sinon […] -->
                <xsl:when test="sic/following-sibling::corr//reg">
                    <xsl:text>[</xsl:text>
                    <xsl:value-of select="sic/following-sibling::corr//orig"/>
                    <xsl:text>]</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="sic/following-sibling::corr/text()">
                            <xsl:text>[</xsl:text>
                            <xsl:value-of select="sic/following-sibling::corr/text()"/>
                            <xsl:text>]</xsl:text>
                        </xsl:when>
                        <xsl:otherwise><xsl:text>[…]</xsl:text></xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <xsl:value-of select="orig"/>
        <xsl:value-of select="abbr"/>
    </xsl:template>
    
    <xsl:template match="choice" mode="interp">
        <xsl:choose>
            <xsl:when test="sic[not(text())]">
                <xsl:choose>
                    <!-- Si une correction est proposée, on inscrit entre crochets l'éventuelle forme "reg", sinon, le noeud texte de "corr", sinon […] -->
                    <xsl:when test="sic/following-sibling::corr//reg">
                        <xsl:text>[</xsl:text>
                        <xsl:value-of select="sic/following-sibling::corr//reg"/>
                        <xsl:text>]</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="sic/following-sibling::corr/text()">
                                <xsl:text>[</xsl:text>
                                <xsl:value-of select="sic/following-sibling::corr/text()"/>
                                <xsl:text>]</xsl:text>
                            </xsl:when>
                            <xsl:otherwise><xsl:text>[…]</xsl:text></xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <!-- En l'absence d'élément sic, on copie la valeur de reg -->
                <xsl:value-of select=".//reg"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="expan"/>
    </xsl:template>
    
    <xsl:template match="pc" mode="graphem">
        <xsl:apply-templates mode="graphem"/>
        <!-- On n'ajoute d'espace que s'il existe d'autres éléments frères consécutifs (sinon, on est en fin de vers) -->
        <xsl:if test="./following-sibling::*">    
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="pc" mode="interp">
        <xsl:choose>
            <!-- Ajout d'une espace avant certains signes de ponctuation seulement -->
            <xsl:when test="./choice/reg/text()=';'">
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="./choice/reg/text()='!'">
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="./choice/reg/text()='?'">
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="./choice/reg/text()=':'">
                <xsl:text> </xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:apply-templates mode="interp"/>
        <!-- On n'ajoute d'espace que s'il existe d'autres éléments frères consécutifs (sinon, on est en fin de vers) -->
        <xsl:if test="./following-sibling::*">    
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="q" mode="#all">
        <!-- On n'ajoute deux points avant une citation que si elle n'est pas en début de vers -->
        <xsl:choose>
            <xsl:when test="./preceding-sibling::*">
                <xsl:choose>
                    <!-- On veille à ce que l'éventuel unique élément qui précède q ne soit pas un lb -->
                    <xsl:when test="count(./preceding-sibling::*) = 1">
                        <xsl:if test="not(./preceding-sibling::lb)">
                            <xsl:text>:</xsl:text>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>:</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
        <xsl:text> « </xsl:text>
        <xsl:apply-templates mode="#current"/>
        <xsl:text> »</xsl:text>
    </xsl:template>
    
    <!-- Style -->
    <xsl:template name="bootstrapCore">
        <xsl:element name="link">
            <xsl:attribute name="rel">stylesheet</xsl:attribute>
            <xsl:attribute name="href">../../static/bootstrap-5.1.3-dist/css/bootstrap.min.css</xsl:attribute>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="navbar">
        <header>
            <!-- Barre de navigation -->
            <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
                <div class="container-fluid">
                    <span class="navbar-brand">Corpus lyrique de Thibaut de Champagne</span>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <ul class="navbar-nav me-auto mb-2 mb-md-0">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="../fr844-accueil.html">Accueil</a>
                            </li>
                            <li>
                                <!-- Boutons pour l'animation de l'apparat -->
                                <xsl:choose>
                                    <!-- On ne montre le bouton d'un apparat que lorsque le témoin est cité dans la pièce -->
                                    <xsl:when test=".//rdg[@wit='#Mt']">    
                                        <input id="mt" type="button" class="btn btn-success" value="Chanson. Mt"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <input id="mt" type="hidden" class="btn btn-success" value="Chanson. Mt"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </li>
                            <li>
                                <input id="wallenskold" type="button" class="btn btn-primary" value="Wallensköld"/>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
    </xsl:template>
    
    <xsl:template name="stylePageChanson">
        <style>
            input {
            margin-left: 10px;
            }
            body {
            margin-top: 150px;
            }
            .intro {
            margin-left: 5%;
            margin-right: 5%;
            margin-bottom: 3%;
            }
            .intro > header {
            margin-bottom: 30px;
            font-size: 32pt;
            }
            .introConteneur {
            display: flex;
            justify-content: space-between;
            }
            .introColonne{
            width: 40%;
            }
            .chansonConteneur {
            background-color:  rgb(253, 245, 245);
            margin-left: 3%;
            margin-right: 3%;
            }
            h1 {
            margin-bottom: 80px;
            }
            .corpsChanson {
            display: flex;
            justify-content: space-around;
            }
            .img {
            }
            .txt {
            font-size: 16pt;
            font-family: "Junicode";
            max-width: 700px; 
            }
            /* Chansons */
            .stanza {
            margin-bottom: 20px;
            }
            /* Initiales ornées */
            .ornate_initial {
            font-size: 40pt;
            }
            /* Vers des chansons */
            .stanza > p {
            margin-bottom: 0px;
            }
        </style>
    </xsl:template>
    
    <!-- Animation de l'apparat -->
    <xsl:template name="scriptApparat">
        <!-- Javascript : Ce script permet d'afficher ou de cacher l'apparat en fonction de l'action de l'utilisateur sur les boutons de la barre de navigation -->
        <script type="text/javascript">
            function auDemarrage() {
            // On sélectionne les boutons Wall et Mt
            let var_boutWall = document.querySelector("#wallenskold")
            let var_boutMt = document.querySelector("#mt")
            // On sélectionne toute la classe Wall et toute la classe Mt
            let Wall = document.querySelectorAll(".Wall");
            let Mt = document.querySelectorAll(".Mt");
            // On écrit les fonctions pour les cacher 
            function cacherWall() {
            Wall.forEach (span => span.style.display = "none");
            }; 
            function cacherMt() {
            Mt.forEach (span => span.style.display = "none");
            }; 
            // On écrit les fonctions pour les montrer
            function montrerWall() {
            Wall.forEach (span => span.style.display = "initial");
            }; 
            function montrerMt() {
            Mt.forEach (span => span.style.display = "initial");
            }; 
            
            // Au démarrage on cache tout
            cacherWall()
            cacherMt()
            // Le statut de Wall et de Mt est alors false
            let statutWall = false;
            let statutMt = false;
            // On définit les fonctions d'animation de l'apparat
            
            // Si l'un des apparats est sélectionné, les span de la classe lem sont mis en gras
            function animLem() {
            if (statutMt == true || statutWall == true ) {
            let lem = document.querySelectorAll(".lem");
            lem.forEach (span => 
            span.setAttribute("style", "font-weight:bold;")
            );
            } else {
            let lem = document.querySelectorAll(".lem");
            lem.forEach (span => 
            span.setAttribute("style", "font-weight:initial;")
            );
            };
            };
            
            function animWall() {
            if (statutWall == false) {
            Wall.forEach (span => span.style.display = "initial");
            statutWall = true;
            animLem()
            } else {
            cacherWall()
            statutWall = false;
            animLem()
            };
            };
            function animMt() {
            if (statutMt== false) {
            Mt.forEach (span => span.style.display = "initial");
            statutMt = true;
            animLem()
            } else {
            cacherMt()
            statutMt = false;
            animLem()
            };
            };
            
            // On définit les évènements liés au clic sur les boutons
            var_boutMt.addEventListener('click', animMt);
            var_boutWall.addEventListener('click', animWall);
            };
            
            // Je m'abonne à l'event 'load' 
            window.addEventListener('load', auDemarrage);
        </script>
    </xsl:template>
    
</xsl:stylesheet>