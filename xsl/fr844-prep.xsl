<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"  
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- Cette feuille effectue des transformations du fichier source vers une sortie TEI afin de préparer la transformation XML vers HTML -->
    
    <xsl:output method="xml" indent="yes"/>
    <!-- Supprime les espaces non voulues-->
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="TEI">
        <TEI>
        <xsl:copy-of select="./teiHeader"/>
        <!-- On ignore l'élément facsimile -->
        <text>
            <xsl:copy-of select="descendant::front"/>
            <xsl:apply-templates select="descendant::body"/>
        </text>
        </TEI>
    </xsl:template>
    
    <xsl:template match="body">
        <xsl:copy>
            <xsl:for-each select="./child::div">
            <div type="chansonnier">
                <xsl:variable name="intitule" select="current()/@type"/>
                <head>
                    <xsl:value-of select="replace(replace($intitule, '_Thibaut_de_Champagne', ''), '_', ' ')"/>
                </head>
                <xsl:copy-of select="current()/descendant::*"/>
            </div>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    
    
</xsl:stylesheet>