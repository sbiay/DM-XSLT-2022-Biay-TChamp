<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- Cette feuille effectue des transformations du fichier source vers une sortie TEI afin de préparer la transformation XML vers HTML -->
    
    <xsl:output method="xml" indent="yes" xmlns="http://www.tei-c.org/ns/1.0"/>
    <!-- Supprime les espaces non voulues-->
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="TEI">
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="./teiHeader"/>
            <!-- On ignore l'élément facsimile -->
            <text>
                <xsl:copy-of select="descendant::front"/>
                <xsl:apply-templates select="descendant::body"/>
                <xsl:copy-of select="descendant::back"/>
            </text>
        </TEI>
    </xsl:template>
    
    <xsl:template match="body">
        <xsl:copy>    
            <xsl:apply-templates select="child::div"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="body/div">
        <div xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">
                <xsl:text>chansonnier</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="n">
                <xsl:number count="." level="single"></xsl:number>
            </xsl:attribute>
            <head>
                <xsl:value-of select="replace(replace(./@type, '_Thibaut_de_Champagne', ''), '_', ' ')"/>
            </head>
            <xsl:apply-templates select="./div[@type='lyrical_text']"/>
        </div>
    </xsl:template>
    
    <!-- Pièce -->
    <xsl:template match="div[@type='lyrical_text']">
        <xsl:copy>
            <xsl:attribute name="type">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:copy-of select="note"/>
            <xsl:apply-templates select="child::lg"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Chanson -->
    <xsl:template match="div/lg">
        <xsl:copy>
            <xsl:attribute name="type">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:attribute name="rhyme">
                <xsl:value-of select="@rhyme"/>
            </xsl:attribute>
            <xsl:copy-of select="note"/>
            <xsl:copy-of select="head"/>
            <xsl:apply-templates select="child::lg"/>
        </xsl:copy>
    </xsl:template>
    
    <!--Strophes-->
    <xsl:template match="lg/lg">
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:attribute name="type">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:apply-templates select="child::l"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Vers -->
    <xsl:template match="l">
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:number count="l" level="any" format="1" from="div"/>
            </xsl:attribute>
            <xsl:copy-of select="./child::*"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>