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
    
    <xsl:template match="TEI">
        <!-- Page d'accueil -->
        <xsl:result-document href="../html/fr844-accueil.html" method="html" indent="yes">
            <html>
                <head>
                    <xsl:element name="title">
                        <xsl:text>Corpus lyrique de Thibaut de Champagne|Accueil</xsl:text>
                    </xsl:element>
                    <xsl:call-template name="bootstrapCore"/>
                    <!-- Feuilles de style propres au carrousel -->
                    <xsl:element name="link">
                        <xsl:attribute name="rel">stylesheet</xsl:attribute>
                        <xsl:attribute name="href">../static/bootstrap-5.1.3-dist/css/carousel.css</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="link">
                        <xsl:attribute name="rel">canonical</xsl:attribute>
                        <xsl:attribute name="href">https://getbootstrap.com/docs/5.1/examples/carousel/</xsl:attribute>
                    </xsl:element>
                    
                    <style>
                        img {
                        min-height: 1000px;
                        }
                    </style>
                    
                    
                </head>
                <body>
                    <xsl:call-template name="navbar"/>
                    <main>
                        <!-- Carrousel -->
                        <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-indicators">
                                <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                                <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                                <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
                            </div>
                            <div class="carousel-inner">
                                <!-- Contenu du carrousel -->
                                <xsl:apply-templates select="descendant::body/div"/>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                        <!-- Marketing messaging and featurettes
                            ================================================== -->
                        <!-- Wrap the rest of the page in another container to center all the content. -->
                        <div class="container marketing">
                            <!-- Three columns of text below the carousel -->
                            <div class="row">
                                <div class="col-lg-4">
                                    <svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img"  preserveAspectRatio="xMidYMid slice" focusable="false">
                                        <rect width="100%" height="100%" fill="#3b4b71"/>
                                    </svg>
                                    <h2>Le manuscrit</h2>
                                    <p>Description codicologique <br/> et paléographique du Manuscrit du Roi.</p>
                                    <p><a class="btn btn-secondary" href="./fr844-codico.html">Voir</a></p>
                                </div><!-- /.col-lg-4 -->
                                <div class="col-lg-4">
                                    <svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img"  preserveAspectRatio="xMidYMid slice" focusable="false">
                                        <rect width="100%" height="100%" fill="#bd5422"/>
                                    </svg>
                                    
                                    <h2>Les principes d'édition</h2>
                                    <p>Explication des objectifs éditoriaux du projet<br/>et description corpus du thibaudien.</p>
                                    <p><a class="btn btn-secondary" href="./fr844-princip-edition.html">Voir</a></p>
                                </div><!-- /.col-lg-4 -->
                                <div class="col-lg-4">
                                    <svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img"  preserveAspectRatio="xMidYMid slice" focusable="false">
                                        <rect width="100%" height="100%" fill="#e3bc66"/>
                                    </svg>
                                    <h2>Index</h2>
                                    <p>Un index des noms de personnes<br/>cités dans les chansons.</p>
                                    <p><a class="btn btn-secondary" href="./fr844-index.html">Voir</a></p>
                                </div><!-- /.col-lg-4 -->
                            </div><!-- /.row -->
                            <!-- START THE FEATURETTES
                                <div class="row featurette">
                                <div class="col-md-7">
                                <h2 class="featurette-heading">First featurette heading. <span class="text-muted">It’ll blow your mind.</span></h2>
                                <p class="lead">Some great placeholder content for the first featurette here. Imagine some exciting prose here.</p>
                                </div>
                                <div class="col-md-5">
                                <svg class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" width="500" height="500" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 500x500" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#eee"/><text x="50%" y="50%" fill="#aaa" dy=".3em">500x500</text></svg>
                                </div>
                                </div>
                            -->
                        </div><!-- fin du container -->
                        
                        <!-- FOOTER 
                            <footer class="container">
                            <p class="float-end"><a href="#">Back to top</a></p>
                            <p> 2017–2021 Company, Inc.  <a href="#">Privacy</a>  <a href="#">Terms</a></p>
                            </footer>
                        -->
                        
                    </main>
                    <script src="../static/bootstrap-5.1.3-dist/js/bootstrap.bundle.min.js"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="body/div">
        <xsl:variable name="nomChansonnier" select="./head"/>
        <xsl:choose>
            <!-- Pour le premier chansonnier, la classe du carrousel est active -->
            <xsl:when test=".[@n='1']">
                <div class="carousel-item active">
                    <img class="bd-placeholder-img" src="https://gallica.bnf.fr/iiif/ark:/12148/btv1b84192440/f27/0,533,3426,1905/1800/0/default.jpg" alt="Paris, BNF, fr. 844, f. 4r"/>
                    <div class="container">
                        <div class="carousel-caption text-start">
                            <h1>
                                <xsl:value-of select="./head"/>
                            </h1>
                            <p>Du texte pour présenter le chansonnier</p>
                            <p><a class="btn btn-lg btn-primary" href="./fr844-tdm-{fn:lower-case(replace($nomChansonnier, ' ', '-'))}.html">Voir</a></p>
                        </div>
                    </div>
                </div>
            </xsl:when>
            <!-- Pour les autres chansonniers, il n'y a pas la classe active -->
            <xsl:otherwise>
                <div class="carousel-item">
                    <xsl:choose>
                        <!-- L'image est adaptée au chansonnier qu'elle illustre -->
                        <xsl:when test=".[@n='2']">
                            <img class="bd-placeholder-img" src="https://gallica.bnf.fr/iiif/ark:/12148/btv1b84192440/f135/11,2160,3394,1619/1800/0/default.jpg" alt="Paris, BNF, fr. 844, f. 59r"/>
                        </xsl:when>
                    </xsl:choose>
                    <div class="container">
                        <div class="carousel-caption">
                            <h1>
                                <xsl:value-of select="./head"/>
                            </h1>
                            <p>Du texte pour présenter le chansonnier</p>
                            <p><a class="btn btn-lg btn-primary" href="./fr844-tdm-{fn:lower-case(replace($nomChansonnier, ' ', '-'))}.html">Voir</a></p>
                        </div>
                    </div>
                </div>
            </xsl:otherwise>
        </xsl:choose>        
        
        <!-- Pour chaque chansonnier, on génère également une table des matières dans une autre sortie -->
        <xsl:result-document href="../html/fr844-tdm-{fn:lower-case(replace($nomChansonnier, ' ', '-'))}.html" method="html" indent="yes">
            <html>
                <head>
                    <xsl:element name="title">
                        <xsl:text>Corpus lyrique de Thibaut de Champagne|</xsl:text>
                        <xsl:value-of select="$nomChansonnier"/>
                    </xsl:element>
                    <xsl:call-template name="bootstrapCore"/>
                </head>
                <body>
                    <xsl:call-template name="navbar"/>
                    <xsl:call-template name="stylePageContenu"/>
                    <div class="container">
                        <h1 class="display-4 fst-italic">
                            <xsl:value-of select="$nomChansonnier"/>
                        </h1>
                        <ol>
                            <xsl:apply-templates select="./div[@type='lyrical_text']"/>
                        </ol>
                    </div>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    <!-- Pour la table des matières de chaque chansonnier, on créé une liste des chansons qu'il contient -->
    <xsl:template match="div[@type='lyrical_text']">
        <xsl:variable name="chansonnierParent" select="fn:lower-case(replace(./preceding-sibling::head/text(), ' ', '-'))"/>
        <li>
            <a href="./fr844-{$chansonnierParent}/{./@xml:id}.html">
                <xsl:attribute name="id">
                    <xsl:value-of select="./@xml:id"/>
                </xsl:attribute>
                <!-- Nom de l'auteur : uniquement si @cert est "high" -->
                <xsl:if test="./note/bibl/author[@cert='high']">
                    <xsl:value-of select="./note/bibl/author[@cert='high']"/>
                    <xsl:text>, </xsl:text>
                </xsl:if>
                <!-- Titre de la chanson -->
                <i>
                    <xsl:value-of select="./note/bibl/title"/>
                </i>
                <xsl:if test="not(./note/bibl/title/text())">
                    <xsl:text>[sans titre]</xsl:text>
                </xsl:if>
            </a>
        </li>
    </xsl:template>
    
    <!-- Style -->
    <xsl:template name="bootstrapCore">
        <xsl:element name="link">
            <xsl:attribute name="rel">stylesheet</xsl:attribute>
            <xsl:attribute name="href">../static/bootstrap-5.1.3-dist/css/bootstrap.min.css</xsl:attribute>
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
                                <a class="nav-link active" aria-current="page" href="./fr844-accueil.html">Accueil</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="./fr844-index.html">Index</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="./fr844-codico.html">Manuscrit</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="./fr844-tdm-chansonnier-m.html">Chansonnier M</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="./fr844-tdm-chansonnier-mt.html">Chansonnier Mt</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
    </xsl:template>
    
    <xsl:template name="stylePageContenu">
        <xsl:element name="link">
            <xsl:attribute name="rel">stylesheet</xsl:attribute>
            <xsl:attribute name="href">../static/pageContenu.css</xsl:attribute>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>