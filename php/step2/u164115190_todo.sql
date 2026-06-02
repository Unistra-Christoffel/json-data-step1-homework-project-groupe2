-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 02 juin 2026 à 04:26
-- Version du serveur : 11.8.6-MariaDB-log
-- Version de PHP : 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `u164115190_todo`
--

-- --------------------------------------------------------

--
-- Structure de la table `CATEGORY`
--

CREATE TABLE `CATEGORY` (
  `idCategory` tinyint(4) NOT NULL,
  `category` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `CATEGORY`
--

INSERT INTO `CATEGORY` (`idCategory`, `category`) VALUES
(1, 'Perso'),
(2, 'Pro'),
(3, 'Étude');

-- --------------------------------------------------------

--
-- Structure de la table `PRIORITY`
--

CREATE TABLE `PRIORITY` (
  `idPriority` tinyint(4) NOT NULL,
  `priority` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `PRIORITY`
--

INSERT INTO `PRIORITY` (`idPriority`, `priority`) VALUES
(1, 'Très basse'),
(2, 'Basse'),
(3, 'Moyenne'),
(4, 'Haute'),
(5, 'Critique');

-- --------------------------------------------------------

--
-- Structure de la table `TAG`
--

CREATE TABLE `TAG` (
  `idTag` tinyint(4) NOT NULL,
  `tag` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `TAG`
--

INSERT INTO `TAG` (`idTag`, `tag`) VALUES
(1, 'En groupe'),
(2, 'sfsf'),
(3, 'sdfsd'),
(4, 'Seul');

-- --------------------------------------------------------

--
-- Structure de la table `TASK`
--

CREATE TABLE `TASK` (
  `idTask` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `dateFinished` date NOT NULL,
  `note` text DEFAULT NULL,
  `idStatus` tinyint(4) NOT NULL,
  `idPriority` tinyint(4) NOT NULL,
  `idCategory` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `TASK`
--

INSERT INTO `TASK` (`idTask`, `title`, `dateFinished`, `note`, `idStatus`, `idPriority`, `idCategory`) VALUES
(1, 'Faire étape 1 RS UE 6.1.1', '2026-05-18', NULL, 4, 5, 3),
(4, 'Faire étape 2 RS UE 6.1.1', '2026-06-05', '', 2, 5, 3);

-- --------------------------------------------------------

--
-- Structure de la table `TASK_STATUS`
--

CREATE TABLE `TASK_STATUS` (
  `idStatus` tinyint(4) NOT NULL,
  `status` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `TASK_STATUS`
--

INSERT INTO `TASK_STATUS` (`idStatus`, `status`) VALUES
(1, 'A faire'),
(2, 'En cours'),
(3, 'En attente'),
(4, 'Terminé'),
(5, 'Annulé'),
(6, 'Reporté');

-- --------------------------------------------------------

--
-- Structure de la table `TASK_TAG`
--

CREATE TABLE `TASK_TAG` (
  `idTask` int(11) NOT NULL,
  `idTag` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `TASK_TAG`
--

INSERT INTO `TASK_TAG` (`idTask`, `idTag`) VALUES
(1, 1),
(4, 4);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `CATEGORY`
--
ALTER TABLE `CATEGORY`
  ADD PRIMARY KEY (`idCategory`);

--
-- Index pour la table `PRIORITY`
--
ALTER TABLE `PRIORITY`
  ADD PRIMARY KEY (`idPriority`);

--
-- Index pour la table `TAG`
--
ALTER TABLE `TAG`
  ADD PRIMARY KEY (`idTag`);

--
-- Index pour la table `TASK`
--
ALTER TABLE `TASK`
  ADD PRIMARY KEY (`idTask`),
  ADD KEY `fk_task_status` (`idStatus`),
  ADD KEY `fk_task_priority` (`idPriority`),
  ADD KEY `fk_task_category` (`idCategory`);

--
-- Index pour la table `TASK_STATUS`
--
ALTER TABLE `TASK_STATUS`
  ADD PRIMARY KEY (`idStatus`);

--
-- Index pour la table `TASK_TAG`
--
ALTER TABLE `TASK_TAG`
  ADD PRIMARY KEY (`idTask`,`idTag`),
  ADD KEY `fk_tasktag_tag` (`idTag`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `CATEGORY`
--
ALTER TABLE `CATEGORY`
  MODIFY `idCategory` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `PRIORITY`
--
ALTER TABLE `PRIORITY`
  MODIFY `idPriority` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `TAG`
--
ALTER TABLE `TAG`
  MODIFY `idTag` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `TASK`
--
ALTER TABLE `TASK`
  MODIFY `idTask` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `TASK_STATUS`
--
ALTER TABLE `TASK_STATUS`
  MODIFY `idStatus` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `TASK`
--
ALTER TABLE `TASK`
  ADD CONSTRAINT `fk_task_category` FOREIGN KEY (`idCategory`) REFERENCES `CATEGORY` (`idCategory`),
  ADD CONSTRAINT `fk_task_priority` FOREIGN KEY (`idPriority`) REFERENCES `PRIORITY` (`idPriority`),
  ADD CONSTRAINT `fk_task_status` FOREIGN KEY (`idStatus`) REFERENCES `TASK_STATUS` (`idStatus`);

--
-- Contraintes pour la table `TASK_TAG`
--
ALTER TABLE `TASK_TAG`
  ADD CONSTRAINT `TASK_TAG_ibfk_1` FOREIGN KEY (`idTask`) REFERENCES `TASK` (`idTask`),
  ADD CONSTRAINT `fk_tasktag_tag` FOREIGN KEY (`idTag`) REFERENCES `TAG` (`idTag`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
