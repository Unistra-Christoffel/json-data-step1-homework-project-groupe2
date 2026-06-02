-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 17 mai 2026 à 12:44
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
  `idCategory` int(11) NOT NULL,
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
  `idPriority` int(11) NOT NULL,
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
  `idTag` int(11) NOT NULL,
  `tag` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `TAG`
--

INSERT INTO `TAG` (`idTag`, `tag`) VALUES
(1, 'En groupe');

-- --------------------------------------------------------

--
-- Structure de la table `TASK`
--

CREATE TABLE `TASK` (
  `idTask` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `dateFinished` date NOT NULL,
  `note` text DEFAULT NULL,
  `idStatus` int(11) NOT NULL,
  `idPriority` int(11) NOT NULL,
  `idCategory` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `TASK`
--

INSERT INTO `TASK` (`idTask`, `title`, `dateFinished`, `note`, `idStatus`, `idPriority`, `idCategory`) VALUES
(1, 'Faire étape 1 RS UE 6.1.1', '2026-05-18', NULL, 4, 5, 3);

-- --------------------------------------------------------

--
-- Structure de la table `TASK_STATUS`
--

CREATE TABLE `TASK_STATUS` (
  `idStatus` int(11) NOT NULL,
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
  `idTag` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `TASK_TAG`
--

INSERT INTO `TASK_TAG` (`idTask`, `idTag`) VALUES
(1, 1);

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
  ADD KEY `idStatus` (`idStatus`),
  ADD KEY `idPriority` (`idPriority`),
  ADD KEY `idCategory` (`idCategory`);

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
  ADD KEY `idTag` (`idTag`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `CATEGORY`
--
ALTER TABLE `CATEGORY`
  MODIFY `idCategory` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `PRIORITY`
--
ALTER TABLE `PRIORITY`
  MODIFY `idPriority` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `TAG`
--
ALTER TABLE `TAG`
  MODIFY `idTag` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `TASK`
--
ALTER TABLE `TASK`
  MODIFY `idTask` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `TASK_STATUS`
--
ALTER TABLE `TASK_STATUS`
  MODIFY `idStatus` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `TASK`
--
ALTER TABLE `TASK`
  ADD CONSTRAINT `TASK_ibfk_1` FOREIGN KEY (`idStatus`) REFERENCES `TASK_STATUS` (`idStatus`),
  ADD CONSTRAINT `TASK_ibfk_2` FOREIGN KEY (`idPriority`) REFERENCES `PRIORITY` (`idPriority`),
  ADD CONSTRAINT `TASK_ibfk_3` FOREIGN KEY (`idCategory`) REFERENCES `CATEGORY` (`idCategory`);

--
-- Contraintes pour la table `TASK_TAG`
--
ALTER TABLE `TASK_TAG`
  ADD CONSTRAINT `TASK_TAG_ibfk_1` FOREIGN KEY (`idTask`) REFERENCES `TASK` (`idTask`),
  ADD CONSTRAINT `TASK_TAG_ibfk_2` FOREIGN KEY (`idTag`) REFERENCES `TAG` (`idTag`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
