<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"  
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
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
            <h2>Mise en pages</h2>
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
        </div>
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
        <li>
            <xsl:apply-templates/>
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