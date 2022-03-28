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
    
    <xsl:template match="back">
        <xsl:result-document href="../html/fr844-index.html" method="html" indent="yes">
            <html>
                <head>
                    <xsl:element name="title">
                        Corpus lyrique de Thibaut de Champagne|Index
                    </xsl:element>
                    <xsl:call-template name="bootstrapCore"/>
                    <xsl:call-template name="stylePageContenu"/>
                </head>
                <body>
                    <xsl:call-template name="navbar"/>
                    <div class="container">
                        <h1 class="display-4 fst-italic">Index</h1>
                        <xsl:apply-templates select="descendant::div[@type='index-pers']"/>
                        <xsl:apply-templates select="descendant::div[@type='index-lieux']"/>
                    </div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="div[@type='index-pers']">
        <h2>
            <xsl:value-of select="./child::head"/>
        </h2>
        <ul>    
            <xsl:apply-templates select="listPerson/person"/>
        </ul>
    </xsl:template>
    
    <xsl:template match="div[@type='index-lieux']">
        <h2>
            <xsl:value-of select="./child::head"/>
        </h2>
        <ul>    
            <xsl:apply-templates select="listPlace/place"/>
        </ul>
    </xsl:template>
    
    <xsl:template match="listPerson/person">
        <li>
            <xsl:value-of select="current()/persName/text()"/>
            <xsl:variable name="personne" select="current()"/>
            <xsl:text> : </xsl:text>
            <!-- Pour chaque chansonnier -->
            <xsl:for-each select="//body/descendant::div[@type='chansonnier'][descendant::persName[@ref=concat('#', $personne/@xml:id)]]">
                <xsl:variable name="chansonnier" select="current()/head"/>
                <!-- Pour chaque chanson -->
                <xsl:for-each select="current()/div[descendant::persName[@ref=concat('#', $personne/@xml:id)]]">   
                    <!-- On écrit le nom du chansonnier à partir de son identifiant -->
                    <xsl:variable name="chanson" select="current()/@xml:id"/>
                    <xsl:value-of select="replace($chansonnier, 'Chansonnier ', '')"/>
                    <xsl:text> </xsl:text>
                    <a href="./fr844-{replace(fn:lower-case($chansonnier), ' ', '-')}/{$chanson}.html">
                        <xsl:value-of select="replace($chanson, '_', '')"/>
                    </a>
                    <xsl:text>, </xsl:text>
                    <!-- Pour chaque occurrence de l'item dans la chanson -->
                    <xsl:for-each select="current()/descendant::persName[@ref=concat('#', $personne/@xml:id)]">    
                        <xsl:choose>    
                            <xsl:when test="current()/ancestor::head[@type='rubric']">
                                <xsl:text> rubrique</xsl:text>
                                <xsl:if test="position() != last()">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if test="position() = 1">
                                    <xsl:text> v. </xsl:text>
                                </xsl:if>
                                <xsl:value-of select="current()/ancestor::l/@n"/>
                                <xsl:choose>    
                                    <xsl:when test="position() != last()">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text></xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    <xsl:if test=".//persName[@ref=concat('#', $personne/@xml:id)]">    
                        <xsl:if test="position() != last()">
                            <xsl:text> ; </xsl:text>
                        </xsl:if>
                    </xsl:if>
                </xsl:for-each>
                <xsl:if test=".//persName[@ref=concat('#', $personne/@xml:id)]">    
                    <xsl:choose>    
                        <xsl:when test="position() != last()">
                            <xsl:text> ‒ </xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>.</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:for-each>
        </li>
    </xsl:template>
    
    <xsl:template match="listPlace/place">
        <li>
            <xsl:value-of select="current()/placeName/text()"/>
            <xsl:variable name="lieu" select="current()"/>
            <xsl:text> : </xsl:text>
            <!-- Pour chaque chansonnier -->
            <xsl:for-each select="//body/descendant::div[@type='chansonnier'][descendant::placeName[@ref=concat('#', $lieu/@xml:id)]]">
                <xsl:variable name="chansonnier" select="current()/head"/>
                <!-- Pour chaque chanson -->
                <xsl:for-each select="current()/div[descendant::placeName[@ref=concat('#', $lieu/@xml:id)]]">   
                    <!-- On écrit le nom du chansonnier à partir de son identifiant -->
                    <xsl:variable name="chanson" select="current()/@xml:id"/>
                    <xsl:value-of select="replace($chansonnier, 'Chansonnier ', '')"/>
                    <xsl:text> </xsl:text>
                    <a href="./fr844-{replace(fn:lower-case($chansonnier), ' ', '-')}/{$chanson}.html">
                        <xsl:value-of select="replace($chanson, '_', '')"/>
                    </a>
                    <xsl:text>, </xsl:text>
                    <!-- Pour chaque occurrence de l'item dans la chanson -->
                    <xsl:for-each select="current()/descendant::placeName[@ref=concat('#', $lieu/@xml:id)]">    
                        <xsl:choose>    
                            <xsl:when test="current()/ancestor::head[@type='rubric']">
                                <xsl:text> rubrique</xsl:text>
                                <xsl:if test="position() != last()">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if test="position() = 1">
                                    <xsl:text> v. </xsl:text>
                                </xsl:if>
                                <xsl:value-of select="current()/ancestor::l/@n"/>
                                <xsl:choose>    
                                    <xsl:when test="position() != last()">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text></xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    <xsl:if test=".//placeName[@ref=concat('#', $lieu/@xml:id)]">    
                        <xsl:if test="position() != last()">
                            <xsl:text> ; </xsl:text>
                        </xsl:if>
                    </xsl:if>
                </xsl:for-each>
                <xsl:if test=".//placeName[@ref=concat('#', $lieu/@xml:id)]">    
                    <xsl:choose>    
                        <xsl:when test="position() != last()">
                            <xsl:text> ‒ </xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>.</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:for-each>
        </li>
    </xsl:template>
    
    <xsl:template match="div/lg//persName">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="w">
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
    </xsl:template>
    
    <xsl:template match="choice">
        <xsl:value-of select="reg"/>
        <xsl:value-of select="expan"/>
    </xsl:template>
    
    <xsl:template match="listPlace">
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
                                <a class="nav-link active" aria-current="page" href="./fr844-accueil.html">Accueil</a><!-- MAJ lien vers page d'accueil -->
                            </li>
                            <!-- Ajouter des liens
                                <li class="nav-item">
                                <a class="nav-link" href="#">Link</a>
                                </li>
                            -->
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
    </xsl:template>
    
    <xsl:template name="stylePageContenu">
        <style>
            body {
            margin-left: 15%;
            margin-right: 15%;
            margin-top: 150px;
            }
            ul {
            margin: 0px;
            }
            .container {
            padding: 80px;
            background-color:  rgb(253, 245, 245);
            }
            h1 {
            margin-bottom: 80px;
            }                        
        </style>
    </xsl:template>
    
</xsl:stylesheet>