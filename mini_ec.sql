drop database mini_ec;



CREATE DATABASE  IF NOT EXISTS `mini_ec` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mini_ec`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mini_ec
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `carrinho_compras`
--

DROP TABLE IF EXISTS `carrinho_compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;

CREATE TABLE `carrinho_compras` (
  `sessao` varchar(32) NOT NULL,
  `id_produto` int NOT NULL,
  `qtd` int NOT NULL,
  `val_unit` decimal(10,2) NOT NULL,
  `desconto` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `data_hora_sessa` datetime NOT NULL,
  KEY `id_produto` (`id_produto`),
  KEY `ix_cc_1` (`sessao`),
  CONSTRAINT `carrinho_compras_ibfk_1` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrinho_compras`
--

LOCK TABLES `carrinho_compras` WRITE;
/*!40000 ALTER TABLE `carrinho_compras` DISABLE KEYS */;
/*!40000 ALTER TABLE `carrinho_compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'JOGOS'),(2,'ELETRÔNICOS'),(3,'SOM'),(4,'ELETRODOMÉSTICOS'),(5,'JOGOS'),(6,'ELETRÔNICOS'),(7,'SOM'),(8,'ELETRODOMÉSTICOS'),(9,'JOGOS'),(10,'ELETRÔNICOS'),(11,'SOM'),(12,'ELETRODOMÉSTICOS');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cidades`
--

DROP TABLE IF EXISTS `cidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cidades` (
  `id_cidade` int NOT NULL AUTO_INCREMENT,
  `nome_cidade` varchar(70) NOT NULL,
  `cod_mun` char(7) NOT NULL,
  `cod_uf` tinyint NOT NULL,
  PRIMARY KEY (`id_cidade`),
  KEY `fk_cid_1` (`cod_uf`),
  CONSTRAINT `fk_cid_1` FOREIGN KEY (`cod_uf`) REFERENCES `unidade_federal` (`cod_uf`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cidades`
--

LOCK TABLES `cidades` WRITE;
/*!40000 ALTER TABLE `cidades` DISABLE KEYS */;
INSERT INTO `cidades` VALUES (1,'','',0);
/*!40000 ALTER TABLE `cidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente_endereco`
--

DROP TABLE IF EXISTS `cliente_endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente_endereco` (
  `id_endereco` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `tipo` enum('P','A') NOT NULL,
  `endereco` varchar(60) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `bairro` varchar(30) NOT NULL,
  `cep` varchar(8) NOT NULL,
  `id_cidade` int NOT NULL,
  PRIMARY KEY (`id_endereco`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_cidade` (`id_cidade`),
  CONSTRAINT `cliente_endereco_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `cliente_endereco_ibfk_2` FOREIGN KEY (`id_cidade`) REFERENCES `cidades` (`id_cidade`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_endereco`
--

LOCK TABLES `cliente_endereco` WRITE;
/*!40000 ALTER TABLE `cliente_endereco` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente_endereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(32) NOT NULL,
  `sobrenome` varchar(32) NOT NULL,
  `email` varchar(60) NOT NULL,
  `senha` varchar(32) NOT NULL,
  `data_nasc` date NOT NULL,
  `data_cadastro` datetime NOT NULL,
  `ult_acesso` datetime DEFAULT NULL,
  `ult_compra` datetime DEFAULT NULL,
  `situacao` enum('A','B') NOT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cond_pagto`
--

DROP TABLE IF EXISTS `cond_pagto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cond_pagto` (
  `id_pagto` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  `tipo` enum('C','D','B') NOT NULL,
  PRIMARY KEY (`id_pagto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cond_pagto`
--

LOCK TABLES `cond_pagto` WRITE;
/*!40000 ALTER TABLE `cond_pagto` DISABLE KEYS */;
INSERT INTO `cond_pagto` VALUES (1,'3 X','C'),(2,'3 X','C');
/*!40000 ALTER TABLE `cond_pagto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cond_pagto_det`
--

DROP TABLE IF EXISTS `cond_pagto_det`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cond_pagto_det` (
  `id_pagto` int NOT NULL,
  `parcela` int NOT NULL,
  `percentual` decimal(10,2) NOT NULL,
  `dias` int NOT NULL,
  KEY `id_pagto` (`id_pagto`),
  CONSTRAINT `cond_pagto_det_ibfk_1` FOREIGN KEY (`id_pagto`) REFERENCES `cond_pagto` (`id_pagto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cond_pagto_det`
--

LOCK TABLES `cond_pagto_det` WRITE;
/*!40000 ALTER TABLE `cond_pagto_det` DISABLE KEYS */;
INSERT INTO `cond_pagto_det` VALUES (1,1,100.00,1),(1,1,100.00,1),(2,1,100.00,1);
/*!40000 ALTER TABLE `cond_pagto_det` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estoque`
--

DROP TABLE IF EXISTS `estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estoque` (
  `id_produto` int NOT NULL,
  `estoque_total` int NOT NULL,
  `estoque_livre` int DEFAULT NULL,
  `estoque_reservado` int DEFAULT NULL,
  KEY `id_produto` (`id_produto`),
  CONSTRAINT `estoque_ibfk_1` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoque`
--

LOCK TABLES `estoque` WRITE;
/*!40000 ALTER TABLE `estoque` DISABLE KEYS */;
INSERT INTO `estoque` VALUES (1,100,100,0),(2,100,100,0),(3,100,100,0),(4,100,100,0),(5,100,100,0),(6,100,100,0),(7,100,100,0),(8,100,100,0),(9,100,100,0),(10,100,100,0),(11,100,100,0),(12,100,100,0),(1,100,100,0),(2,100,100,0),(3,100,100,0),(4,100,100,0),(5,100,100,0),(6,100,100,0),(7,100,100,0),(8,100,100,0),(9,100,100,0),(10,100,100,0),(11,100,100,0),(12,100,100,0);
/*!40000 ALTER TABLE `estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fabricantes`
--

DROP TABLE IF EXISTS `fabricantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fabricantes` (
  `id_fabricante` int NOT NULL AUTO_INCREMENT,
  `nome_fabricante` varchar(50) NOT NULL,
  PRIMARY KEY (`id_fabricante`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fabricantes`
--

LOCK TABLES `fabricantes` WRITE;
/*!40000 ALTER TABLE `fabricantes` DISABLE KEYS */;
INSERT INTO `fabricantes` VALUES (1,'FABR JOGOS'),(2,'FABR ELETR.'),(3,'FABR. SOM'),(4,'FABR ELE.DOMES'),(5,'FABR JOGOS'),(6,'FABR ELETR.'),(7,'FABR. SOM'),(8,'FABR ELE.DOMES'),(9,'FABR JOGOS'),(10,'FABR ELETR.'),(11,'FABR. SOM'),(12,'FABR ELE.DOMES'),(13,'FABR JOGOS'),(14,'FABR ELETR.'),(15,'FABR. SOM'),(16,'FABR ELE.DOMES');
/*!40000 ALTER TABLE `fabricantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nf_itens`
--

DROP TABLE IF EXISTS `nf_itens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nf_itens` (
  `num_nota` int NOT NULL,
  `id_produto` int NOT NULL,
  `qtd` int NOT NULL,
  `val_unit` decimal(10,2) NOT NULL,
  `desconto` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  KEY `num_nota` (`num_nota`),
  KEY `id_produto` (`id_produto`),
  CONSTRAINT `nf_itens_ibfk_1` FOREIGN KEY (`num_nota`) REFERENCES `nota_fiscal` (`num_nota`),
  CONSTRAINT `nf_itens_ibfk_2` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nf_itens`
--

LOCK TABLES `nf_itens` WRITE;
/*!40000 ALTER TABLE `nf_itens` DISABLE KEYS */;
/*!40000 ALTER TABLE `nf_itens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nf_obs`
--

DROP TABLE IF EXISTS `nf_obs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nf_obs` (
  `num_nota` int NOT NULL,
  `obs` varchar(255) NOT NULL,
  KEY `num_nota` (`num_nota`),
  CONSTRAINT `nf_obs_ibfk_1` FOREIGN KEY (`num_nota`) REFERENCES `nota_fiscal` (`num_nota`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nf_obs`
--

LOCK TABLES `nf_obs` WRITE;
/*!40000 ALTER TABLE `nf_obs` DISABLE KEYS */;
/*!40000 ALTER TABLE `nf_obs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nota_fiscal`
--

DROP TABLE IF EXISTS `nota_fiscal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nota_fiscal` (
  `num_nota` int NOT NULL AUTO_INCREMENT,
  `num_ped_ref` int NOT NULL,
  `id_cliente` int NOT NULL,
  `id_endereco` int NOT NULL,
  `id_pagto` int NOT NULL,
  `total_prod` decimal(10,2) DEFAULT NULL,
  `total_frete` decimal(10,2) DEFAULT NULL,
  `total_desc` decimal(10,2) DEFAULT NULL,
  `total_nf` decimal(10,2) DEFAULT NULL,
  `data_nf` datetime NOT NULL,
  `status_nf` enum('N','C','D') DEFAULT NULL,
  `id_user` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`num_nota`),
  KEY `num_ped_ref` (`num_ped_ref`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_endereco` (`id_endereco`),
  KEY `id_pagto` (`id_pagto`),
  CONSTRAINT `nota_fiscal_ibfk_1` FOREIGN KEY (`num_ped_ref`) REFERENCES `pedidos` (`num_pedido`),
  CONSTRAINT `nota_fiscal_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `nota_fiscal_ibfk_3` FOREIGN KEY (`id_endereco`) REFERENCES `cliente_endereco` (`id_endereco`),
  CONSTRAINT `nota_fiscal_ibfk_4` FOREIGN KEY (`id_pagto`) REFERENCES `cond_pagto_det` (`id_pagto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nota_fiscal`
--

LOCK TABLES `nota_fiscal` WRITE;
/*!40000 ALTER TABLE `nota_fiscal` DISABLE KEYS */;
/*!40000 ALTER TABLE `nota_fiscal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_itens`
--

DROP TABLE IF EXISTS `pedido_itens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido_itens` (
  `num_pedido` int NOT NULL,
  `id_produto` int NOT NULL,
  `qtd` int NOT NULL,
  `val_unit` decimal(10,2) NOT NULL,
  `desconto` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  KEY `num_pedido` (`num_pedido`),
  KEY `id_produto` (`id_produto`),
  CONSTRAINT `pedido_itens_ibfk_1` FOREIGN KEY (`num_pedido`) REFERENCES `pedidos` (`num_pedido`),
  CONSTRAINT `pedido_itens_ibfk_2` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_itens`
--

LOCK TABLES `pedido_itens` WRITE;
/*!40000 ALTER TABLE `pedido_itens` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido_itens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_obs`
--

DROP TABLE IF EXISTS `pedido_obs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido_obs` (
  `num_pedido` int NOT NULL,
  `obs` varchar(255) NOT NULL,
  KEY `num_pedido` (`num_pedido`),
  CONSTRAINT `pedido_obs_ibfk_1` FOREIGN KEY (`num_pedido`) REFERENCES `pedidos` (`num_pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_obs`
--

LOCK TABLES `pedido_obs` WRITE;
/*!40000 ALTER TABLE `pedido_obs` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido_obs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `num_pedido` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `id_endereco` int NOT NULL,
  `id_pagto` int NOT NULL,
  `total_prod` decimal(10,2) DEFAULT NULL,
  `total_frete` decimal(10,2) DEFAULT NULL,
  `total_desc` decimal(10,2) DEFAULT NULL,
  `total_pedido` decimal(10,2) DEFAULT NULL,
  `data_pedido` datetime NOT NULL,
  `previsao_entrega` date DEFAULT NULL,
  `efetiva_entrega` date DEFAULT NULL,
  `status_ped` enum('A','S','F','T','E') DEFAULT NULL,
  PRIMARY KEY (`num_pedido`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_endereco` (`id_endereco`),
  KEY `id_pagto` (`id_pagto`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`id_endereco`) REFERENCES `cliente_endereco` (`id_endereco`),
  CONSTRAINT `pedidos_ibfk_3` FOREIGN KEY (`id_pagto`) REFERENCES `cond_pagto` (`id_pagto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `id_produto` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  `id_categoria` int NOT NULL,
  `id_fabricante` int NOT NULL,
  `preco_custo` decimal(10,2) DEFAULT NULL,
  `preco_venda` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_produto`),
  KEY `id_categoria` (`id_categoria`),
  KEY `id_fabricante` (`id_fabricante`),
  CONSTRAINT `produto_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`),
  CONSTRAINT `produto_ibfk_2` FOREIGN KEY (`id_fabricante`) REFERENCES `fabricantes` (`id_fabricante`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,'Jogo Infantil',1,1,50.00,200.00),(2,'Jogo Acao',1,1,50.00,200.00),(3,'Jogo Estrategia',1,1,50.00,200.00),(4,'Smart Tv 42',2,2,1300.00,2000.00),(5,'Notebook 15',2,2,2200.00,3000.00),(6,'SmartPhone',2,2,550.00,1200.00),(7,'Caixa de Som BOOM',3,3,750.00,1500.00),(8,'Som automotivo',3,3,250.00,500.00),(9,'Sound MIX',3,3,750.00,1200.00),(10,'Geladeira',4,4,780.00,1580.00),(11,'Batedeira',4,4,200.00,450.00),(12,'Aspirador de Pó',4,4,200.00,4500.00),(13,'Jogo Infantil',1,1,50.00,200.00),(14,'Jogo Acao',1,1,50.00,200.00),(15,'Jogo Estrategia',1,1,50.00,200.00),(16,'Smart Tv 42',2,2,1300.00,2000.00),(17,'Notebook 15',2,2,2200.00,3000.00),(18,'SmartPhone',2,2,550.00,1200.00);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto_caracter`
--

DROP TABLE IF EXISTS `produto_caracter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto_caracter` (
  `id_produto` int NOT NULL,
  `caracteristica` varchar(50) NOT NULL,
  `valor` varchar(50) NOT NULL,
  KEY `id_produto` (`id_produto`),
  CONSTRAINT `produto_caracter_ibfk_1` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto_caracter`
--

LOCK TABLES `produto_caracter` WRITE;
/*!40000 ALTER TABLE `produto_caracter` DISABLE KEYS */;
/*!40000 ALTER TABLE `produto_caracter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rastreabilidade`
--

DROP TABLE IF EXISTS `rastreabilidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rastreabilidade` (
  `num_pedido` int NOT NULL,
  `status_ped` char(1) NOT NULL,
  `data_hora` datetime NOT NULL,
  `id_user` varchar(50) DEFAULT NULL,
  KEY `num_pedido` (`num_pedido`),
  CONSTRAINT `rastreabilidade_ibfk_1` FOREIGN KEY (`num_pedido`) REFERENCES `pedidos` (`num_pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rastreabilidade`
--

LOCK TABLES `rastreabilidade` WRITE;
/*!40000 ALTER TABLE `rastreabilidade` DISABLE KEYS */;
/*!40000 ALTER TABLE `rastreabilidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidade_federal`
--

DROP TABLE IF EXISTS `unidade_federal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidade_federal` (
  `cod_uf` tinyint NOT NULL,
  `uf` char(2) NOT NULL,
  `nome_uf` varchar(50) NOT NULL,
  PRIMARY KEY (`cod_uf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidade_federal`
--

LOCK TABLES `unidade_federal` WRITE;
/*!40000 ALTER TABLE `unidade_federal` DISABLE KEYS */;
INSERT INTO `unidade_federal` VALUES (0,'','');
/*!40000 ALTER TABLE `unidade_federal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `nome_user` varchar(50) NOT NULL,
  `email_user` varchar(60) NOT NULL,
  `senha` varchar(32) NOT NULL,
  `data_cadastro` datetime NOT NULL,
  `status` enum('A','B') DEFAULT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `ix_usr_1` (`email_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_financeiro`
--

DROP TABLE IF EXISTS `v_financeiro`;
/*!50001 DROP VIEW IF EXISTS `v_financeiro`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_financeiro` AS SELECT 
 1 AS `num_nota`,
 1 AS `id_cliente`,
 1 AS `nome`,
 1 AS `id_pagto`,
 1 AS `descricao`,
 1 AS `tipo`,
 1 AS `total_nf`,
 1 AS `data_nf`,
 1 AS `parcela`,
 1 AS `percentual`,
 1 AS `dias`,
 1 AS `valor_parcela`,
 1 AS `vencimento`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_financeiro`
--

/*!50001 DROP VIEW IF EXISTS `v_financeiro`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_financeiro` AS select `a`.`num_nota` AS `num_nota`,`a`.`id_cliente` AS `id_cliente`,`d`.`nome` AS `nome`,`a`.`id_pagto` AS `id_pagto`,`b`.`descricao` AS `descricao`,`b`.`tipo` AS `tipo`,`a`.`total_nf` AS `total_nf`,`a`.`data_nf` AS `data_nf`,`c`.`parcela` AS `parcela`,`c`.`percentual` AS `percentual`,`c`.`dias` AS `dias`,cast(((`a`.`total_nf` / 100) * `c`.`percentual`) as decimal(10,2)) AS `valor_parcela`,cast((`a`.`data_nf` + interval `c`.`dias` day) as date) AS `vencimento` from (((`nota_fiscal` `a` join `cond_pagto` `b` on((`a`.`id_pagto` = `b`.`id_pagto`))) join `cond_pagto_det` `c` on(((`a`.`id_pagto` = `b`.`id_pagto`) and (`a`.`id_pagto` = `c`.`id_pagto`)))) join `clientes` `d` on((`a`.`id_cliente` = `d`.`id_cliente`))) where (`a`.`status_nf` = 'N') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-25 21:39:28

use mini_ec;


-- TESTANDO PROCEDURE (PROC_CARGA_CARRINHO) --
CALL PROC_CARGA_CARRINHO(5, 40, 3000.00);
CALL PROC_CARGA_CARRINHO(9, 2, 1200.00);

-- TESTANDO PROCEDURE (PROC_FECHA_CARRINHO) --
CALL PROC_FECHA_CARRINHO(10,1,1);

-- TESTANDO PROCEDURE (PROC_FAT_PEDIDO)--
CALL PROC_FAT_PEDIDO(1);
SELECT @mensagem;


-- CHAMANDO A VIEW --
SELECT * FROM v_financeiro;

-- MOSTRANDO OS PROCEDURE --
SHOW PROCEDURE STATUS;





