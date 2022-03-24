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
        <xsl:result-document href="../html/fr844-princip-edition.html" method="html" indent="yes">
            <html>
                <head>
                    <xsl:element name="title">
                        Corpus lyrique de Thibaut de Champagne|Principes d'édition
                    </xsl:element>
                    <!-- Bootstrap core CSS -->
                    <xsl:element name="link">
                        <xsl:attribute name="rel">stylesheet</xsl:attribute>
                        <xsl:attribute name="href">../static/bootstrap-5.1.3-dist/css/bootstrap.min.css</xsl:attribute>
                    </xsl:element>
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
                </head>
                <body>
                    <!-- Barre de navigation -->
                    <header>
                        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
                            <div class="container-fluid">
                                <a class="navbar-brand" href="#">Corpus lyrique de Thibaut de Champagne</a>
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
                    
                    <xsl:apply-templates select="descendant::front"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="front">
        <div class="container">
            <h1 class="display-4 fst-italic">
            <xsl:value-of select="./child::head"/>
        </h1>
        <xsl:apply-templates select="div"/>
        </div>
    </xsl:template>
    
    <xsl:template match="div">
        <h2>
            <xsl:value-of select="./child::head"/>
        </h2>
        <xsl:apply-templates select="p"/>
    </xsl:template>
    
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="foreign">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>
    
    <xsl:template match="list">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    
    <xsl:template match="item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <!-- En l'état du projet, tous les liens des principes d'édition renvoient à la description codicologique du ms. -->
    <xsl:template match="ref">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:text>./fr844-codico.html</xsl:text>
                <xsl:value-of select="./@target"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>