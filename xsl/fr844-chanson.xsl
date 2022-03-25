<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"  
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- Supprime les espaces non voulues-->
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="div[@type='lyrical_text']">
        <xsl:result-document href="../html/fr844-chanson-{./@xml:id}.html" method="html" indent="yes">
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
                    <xsl:call-template name="stylePageContenu"/>
                </head>
                <body>
                    <xsl:call-template name="navbar"/>
                    <xsl:call-template name="stylePageContenu"/>
                    <div class="container">
                        <h1 class="display-4 fst-italic">
                        </h1>
                        <p>Hello</p>
                    </div>
                </body>
            </html>
        </xsl:result-document>
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