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
        <xsl:result-document href="../html/fr844-codico.html" method="html" indent="yes">
            <html>
                <head>
                    <xsl:element name="title">
                        Corpus lyrique de Thibaut de Champagne|Principes d'édition
                    </xsl:element>
                    <xsl:call-template name="bootstrapCore"/>
                    <xsl:call-template name="stylePageContenu"/>
                </head>
                <body>
                    <xsl:call-template name="navbar"/>
                    <xsl:apply-templates select="descendant::sourceDesc"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="sourceDesc">
        <div class="container">
            <h1 class="display-5 fst-italic">
                <xsl:value-of select="./msDesc/head"/>
            </h1>
            
            <h2>Description matérielle</h2>
            <h3>Support</h3>
            <p><xsl:apply-templates select="descendant::support"/></p>
            <h3>Importance matérielle</h3>
            <p><xsl:apply-templates select="descendant::extent"/></p>
            <h3>Foliotation</h3>
            <p><xsl:apply-templates select="descendant::foliation"/></p>
            <h3>Collation des cahiers</h3>
            <xsl:apply-templates select="descendant::collation"/>
            
            <h2>Mise en page</h2>
            <p><xsl:apply-templates select="descendant::layoutDesc/layout/text()"/></p>
            <p>
                <xsl:text>Dimensions : </xsl:text>
                <xsl:value-of select="descendant::layoutDesc//height"/>
                <xsl:text> 𐄂 </xsl:text>
                <xsl:value-of select="descendant::layoutDesc//width"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="descendant::layoutDesc//height/@unit"/>
                <xsl:text>.</xsl:text>
            </p>
            
            <h2>Description des mains</h2>
            <p>Les mains sont au nombre de <xsl:value-of select="descendant::handDesc/@hands"/>.</p>
            <h3>Mains médiévales</h3>
            <xsl:apply-templates select="descendant::handNote[1]"/>
            <h3>Main érudite</h3>
            <xsl:apply-templates select="descendant::handNote[@xml:id='Erudit']"/>
            <h3>Pièces thibaudiennes</h3>
            <xsl:apply-templates select="descendant::handNote[last()]"/>
            
            <h2>Décoration</h2>
            <xsl:apply-templates select="descendant::decoDesc"/>
            
            <h2>Reliure</h2>
            <xsl:apply-templates select="descendant::bindingDesc"/>
            
            <h2>Histoire</h2>
            <h3>Origine</h3>
            <xsl:apply-templates select="descendant::origPlace"/>
            <h3>Date</h3>
            <xsl:apply-templates select="descendant::origDate"/>
            
            <h2>Liste des témoins</h2>
            <p><xsl:value-of select="descendant::listWit[@xml:id='Temoins_Thibaut_Champagne']/head"/></p>
            <xsl:apply-templates select="listWit/listWit"/>
        </div>
    </xsl:template>
    
    <!-- Listes de témoins manuscrits -->
    <xsl:template match="listWit/listWit">
        <h3><xsl:value-of select="./head"/></h3>
        <p><xsl:apply-templates select="./desc"/></p>
        <ul>
            <xsl:apply-templates select="./witness"/>
        </ul>
    </xsl:template>
    
    <xsl:template match="witness">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    
    <xsl:template match="desc">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="p">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="hi">
        <xsl:if test="@rend='sup'">
            <sup>
                <xsl:apply-templates/>
            </sup>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="formula">
        <h4>Formule</h4>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="list">
        <!-- Dans le cas de la liste qui suit immédiatement la formula (collation des cahiers) -->
        <xsl:if test="./ancestor::p/preceding-sibling::p[1]/child::formula">
            <head>Description détaillée</head>
        </xsl:if>
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    
    <xsl:template match="item">
        <xsl:choose>    
            <!-- Pour les liste relatives à un témoin manuscrit spécifiquement traité -->
            <xsl:when test="./ancestor::witness[@xml:id = 'M']">
                <!-- On pose comme condition que la liste possède bien des éléments numérotés (ces listes sont en cours de consitution) -->
                <xsl:if test=".[@n]">
                    <xsl:call-template name="listeChansons"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="./ancestor::witness[@xml:id = 'Mt']">
                <!-- On pose comme condition que la liste possède bien des éléments numérotés (ces listes sont en cours de consitution) -->
                <xsl:if test=".[@n]">
                    <xsl:call-template name="listeChansons"/>
                </xsl:if>
            </xsl:when>
            
            <!-- Pour tous les autres types de listes -->
            <xsl:otherwise>
                <li>
                    <xsl:apply-templates/>
                </li>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Liste de pièces déjà éditées avec le lien vers la page dédiée -->
    <xsl:template name="listeChansons">
        <li>
            <xsl:apply-templates/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="replace(replace(./@corresp, '#', ''), '_', ' ')"/>
            <xsl:text>, </xsl:text>
            <a href="./fr844-chansonnier-{fn:lower-case(ancestor::witness/@xml:id)}/{replace(./@corresp, '#', '')}.html">
                <xsl:text>lien</xsl:text> 
            </a>
            <xsl:text>).</xsl:text>
        </li>
    </xsl:template>
    
    <xsl:template match="foreign">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>
    
    <xsl:template match="title">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>
    
    <xsl:template match="origDate">
        <p>
            <xsl:apply-templates/>
        </p>
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