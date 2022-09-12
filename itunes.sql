-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema itunes
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `itunes` ;

-- -----------------------------------------------------
-- Schema itunes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `itunes` ;
USE `itunes` ;

-- -----------------------------------------------------
-- Table `itunes`.`label`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itunes`.`label` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itunes`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itunes`.`album` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `year_of_publishing` INT NULL,
  `price` DECIMAL(2) NOT NULL,
  `label_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_album_label1_idx` (`label_id` ASC) VISIBLE,
  CONSTRAINT `fk_album_label1`
    FOREIGN KEY (`label_id`)
    REFERENCES `itunes`.`label` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itunes`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itunes`.`genre` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itunes`.`song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itunes`.`song` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `length` INT NOT NULL,
  `album_id` INT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_song_album1_idx` (`album_id` ASC) VISIBLE,
  INDEX `fk_song_genre1_idx` (`genre_id` ASC) VISIBLE,
  CONSTRAINT `fk_song_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `itunes`.`album` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_song_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `itunes`.`genre` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itunes`.`author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itunes`.`author` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itunes`.`related_genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itunes`.`related_genres` (
  `genre_id` INT NOT NULL,
  `releted_genre_id` INT NOT NULL,
  PRIMARY KEY (`genre_id`, `releted_genre_id`),
  INDEX `fk_genre_has_genre_genre1_idx` (`releted_genre_id` ASC) VISIBLE,
  INDEX `fk_genre_has_genre_genre_idx` (`genre_id` ASC) VISIBLE,
  CONSTRAINT `fk_genre_has_genre_genre`
    FOREIGN KEY (`genre_id`)
    REFERENCES `itunes`.`genre` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_genre_has_genre_genre1`
    FOREIGN KEY (`releted_genre_id`)
    REFERENCES `itunes`.`genre` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itunes`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itunes`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itunes`.`user's_playlist_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itunes`.`user's_playlist_info` (
  `id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user's_playlist_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user's_playlist_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `itunes`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itunes`.`songs_saved_by_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itunes`.`songs_saved_by_user` (
  `song_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`song_id`, `user_id`),
  INDEX `fk_song_has_user_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_song_has_user_song1_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `fk_song_has_user_song1`
    FOREIGN KEY (`song_id`)
    REFERENCES `itunes`.`song` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_song_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `itunes`.`user` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itunes`.`albums_saved_by_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itunes`.`albums_saved_by_user` (
  `album_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`album_id`, `user_id`),
  INDEX `fk_album_has_user_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_album_has_user_album1_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `fk_album_has_user_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `itunes`.`album` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_album_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `itunes`.`user` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itunes`.`user_prefer_genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itunes`.`user_prefer_genre` (
  `user_id` INT NOT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `genre_id`),
  INDEX `fk_user_has_genre_genre1_idx` (`genre_id` ASC) VISIBLE,
  INDEX `fk_user_has_genre_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_genre_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `itunes`.`user` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_has_genre_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `itunes`.`genre` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itunes`.`_playlist_has_song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itunes`.`_playlist_has_song` (
  `user's_playlist_info_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  PRIMARY KEY (`user's_playlist_info_id`, `song_id`),
  INDEX `fk_user's_playlist_info_has_song_song1_idx` (`song_id` ASC) VISIBLE,
  INDEX `fk_user's_playlist_info_has_song_user's_playlist_info1_idx` (`user's_playlist_info_id` ASC) VISIBLE,
  CONSTRAINT `fk_user's_playlist_info_has_song_user's_playlist_info1`
    FOREIGN KEY (`user's_playlist_info_id`)
    REFERENCES `itunes`.`user's_playlist_info` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user's_playlist_info_has_song_song1`
    FOREIGN KEY (`song_id`)
    REFERENCES `itunes`.`song` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itunes`.`song_commercial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itunes`.`song_commercial` (
  `song_id` INT NOT NULL,
  `price` DECIMAL(2) NOT NULL,
  `num_of_downloads` INT NOT NULL,
  PRIMARY KEY (`song_id`),
  CONSTRAINT `fk_song_commercial_song1`
    FOREIGN KEY (`song_id`)
    REFERENCES `itunes`.`song` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itunes`.`user_credential`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itunes`.`user_credential` (
  `user_id` INT NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user_credential_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `itunes`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itunes`.`song_has_author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itunes`.`song_has_author` (
  `song_id` INT NOT NULL,
  `author_id` INT NOT NULL,
  PRIMARY KEY (`song_id`, `author_id`),
  INDEX `fk_song_has_author_author1_idx` (`author_id` ASC) VISIBLE,
  INDEX `fk_song_has_author_song1_idx` (`song_id` ASC) VISIBLE,
  CONSTRAINT `fk_song_has_author_song1`
    FOREIGN KEY (`song_id`)
    REFERENCES `itunes`.`song` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_song_has_author_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `itunes`.`author` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itunes`.`album_has_author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itunes`.`album_has_author` (
  `album_id` INT NOT NULL,
  `author_id` INT NOT NULL,
  PRIMARY KEY (`album_id`, `author_id`),
  INDEX `fk_album_has_author_author1_idx` (`author_id` ASC) VISIBLE,
  INDEX `fk_album_has_author_album1_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `fk_album_has_author_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `itunes`.`album` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_album_has_author_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `itunes`.`author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `itunes`.`label`
-- -----------------------------------------------------
START TRANSACTION;
USE `itunes`;
INSERT INTO `itunes`.`label` (`id`, `name`) VALUES (1, 'Columbia Records');
INSERT INTO `itunes`.`label` (`id`, `name`) VALUES (2, 'L-M Records');
INSERT INTO `itunes`.`label` (`id`, `name`) VALUES (3, 'Nice Life');
INSERT INTO `itunes`.`label` (`id`, `name`) VALUES (4, 'EMI American Records');
INSERT INTO `itunes`.`label` (`id`, `name`) VALUES (5, 'Republic Records');
INSERT INTO `itunes`.`label` (`id`, `name`) VALUES (6, 'Parkwood Entertainment');
INSERT INTO `itunes`.`label` (`id`, `name`) VALUES (7, 'Epic');
INSERT INTO `itunes`.`label` (`id`, `name`) VALUES (8, 'Rimas Entertainment');
INSERT INTO `itunes`.`label` (`id`, `name`) VALUES (9, 'Paramount Pictures');
INSERT INTO `itunes`.`label` (`id`, `name`) VALUES (10, 'River House Artists');

COMMIT;


-- -----------------------------------------------------
-- Data for table `itunes`.`album`
-- -----------------------------------------------------
START TRANSACTION;
USE `itunes`;
INSERT INTO `itunes`.`album` (`id`, `name`, `year_of_publishing`, `price`, `label_id`) VALUES (1, 'Harry\'s House', 2022, 5.00, 1);
INSERT INTO `itunes`.`album` (`id`, `name`, `year_of_publishing`, `price`, `label_id`) VALUES (2, 'Gemini Rights', 2022, 6.00, 2);
INSERT INTO `itunes`.`album` (`id`, `name`, `year_of_publishing`, `price`, `label_id`) VALUES (3, 'Special', 2022, 4.50, 3);
INSERT INTO `itunes`.`album` (`id`, `name`, `year_of_publishing`, `price`, `label_id`) VALUES (4, 'Hounds of Love', 1985, 1.50, 4);
INSERT INTO `itunes`.`album` (`id`, `name`, `year_of_publishing`, `price`, `label_id`) VALUES (5, 'Queen Radio: Volume 1', 2022, 6.00, 5);
INSERT INTO `itunes`.`album` (`id`, `name`, `year_of_publishing`, `price`, `label_id`) VALUES (6, 'Twelve Carat Toothpaste', 2022, 5.50, 5);
INSERT INTO `itunes`.`album` (`id`, `name`, `year_of_publishing`, `price`, `label_id`) VALUES (7, 'Renaissance', 2022, 5.00, 6);
INSERT INTO `itunes`.`album` (`id`, `name`, `year_of_publishing`, `price`, `label_id`) VALUES (8, 'I Never Liked You', 2022, 4.50, 7);
INSERT INTO `itunes`.`album` (`id`, `name`, `year_of_publishing`, `price`, `label_id`) VALUES (9, 'Un Verano Sin Ti', 2022, 3.50, 8);
INSERT INTO `itunes`.`album` (`id`, `name`, `year_of_publishing`, `price`, `label_id`) VALUES (10, 'Top Gun: Maverick', 2022, 4.50, 9);
INSERT INTO `itunes`.`album` (`id`, `name`, `year_of_publishing`, `price`, `label_id`) VALUES (11, 'Growin\' Up', 2022, 4.00, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `itunes`.`genre`
-- -----------------------------------------------------
START TRANSACTION;
USE `itunes`;
INSERT INTO `itunes`.`genre` (`id`, `name`) VALUES (1, 'Hip-Hop');
INSERT INTO `itunes`.`genre` (`id`, `name`) VALUES (2, 'Pop rock');
INSERT INTO `itunes`.`genre` (`id`, `name`) VALUES (3, 'R&B');
INSERT INTO `itunes`.`genre` (`id`, `name`) VALUES (4, 'Reggaeton');
INSERT INTO `itunes`.`genre` (`id`, `name`) VALUES (5, 'Country');
INSERT INTO `itunes`.`genre` (`id`, `name`) VALUES (6, 'Rock');

COMMIT;


-- -----------------------------------------------------
-- Data for table `itunes`.`song`
-- -----------------------------------------------------
START TRANSACTION;
USE `itunes`;
INSERT INTO `itunes`.`song` (`id`, `name`, `length`, `album_id`, `genre_id`) VALUES (1, 'As It Was', 166, 1, 2);
INSERT INTO `itunes`.`song` (`id`, `name`, `length`, `album_id`, `genre_id`) VALUES (2, 'Bad Habit', 233, 2, 3);
INSERT INTO `itunes`.`song` (`id`, `name`, `length`, `album_id`, `genre_id`) VALUES (3, 'About Damn Time', 191, 3, 1);
INSERT INTO `itunes`.`song` (`id`, `name`, `length`, `album_id`, `genre_id`) VALUES (4, 'Running Up That Hill', 294, 4, 1);
INSERT INTO `itunes`.`song` (`id`, `name`, `length`, `album_id`, `genre_id`) VALUES (5, 'Sunroof', 163, NULL, 1);
INSERT INTO `itunes`.`song` (`id`, `name`, `length`, `album_id`, `genre_id`) VALUES (6, 'Hold Me Closer', 203, NULL, 1);
INSERT INTO `itunes`.`song` (`id`, `name`, `length`, `album_id`, `genre_id`) VALUES (7, 'Super Freaky Girl', 173, 5, 3);
INSERT INTO `itunes`.`song` (`id`, `name`, `length`, `album_id`, `genre_id`) VALUES (8, 'I Like You', 193, 6, 1);
INSERT INTO `itunes`.`song` (`id`, `name`, `length`, `album_id`, `genre_id`) VALUES (9, 'Break My Soul', 240, 7, 1);
INSERT INTO `itunes`.`song` (`id`, `name`, `length`, `album_id`, `genre_id`) VALUES (10, 'Wait For U', 190, 8, 3);
INSERT INTO `itunes`.`song` (`id`, `name`, `length`, `album_id`, `genre_id`) VALUES (11, 'Me Porto Bonito', 179, 9, 4);
INSERT INTO `itunes`.`song` (`id`, `name`, `length`, `album_id`, `genre_id`) VALUES (12, 'Late Night Talking', 178, 1, 2);
INSERT INTO `itunes`.`song` (`id`, `name`, `length`, `album_id`, `genre_id`) VALUES (13, 'You Proof', 158, NULL, 5);
INSERT INTO `itunes`.`song` (`id`, `name`, `length`, `album_id`, `genre_id`) VALUES (14, 'I Ain\'t Worried', 147, 10, 2);
INSERT INTO `itunes`.`song` (`id`, `name`, `length`, `album_id`, `genre_id`) VALUES (15, 'The Kind Of Love We Make', 225, 11, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `itunes`.`author`
-- -----------------------------------------------------
START TRANSACTION;
USE `itunes`;
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (1, 'Harry Styles');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (2, 'Steve Lacy');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (3, 'Lizzo');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (4, 'Kate Bush');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (5, 'Nicky Youre');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (6, 'dazy');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (7, 'Elton John');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (8, 'Britney Spears');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (9, 'Nicki Minaj');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (10, 'Post Malone');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (11, 'Doja Cat');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (12, 'Beyonce');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (13, 'Future');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (14, 'Tems');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (15, 'Bad Bunny');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (16, 'Chencho Corleone');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (17, 'Morgan Wallen');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (18, 'OneRepublic');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (19, 'Luke Combs');
INSERT INTO `itunes`.`author` (`id`, `name`) VALUES (20, 'Drake');

COMMIT;


-- -----------------------------------------------------
-- Data for table `itunes`.`related_genres`
-- -----------------------------------------------------
START TRANSACTION;
USE `itunes`;
INSERT INTO `itunes`.`related_genres` (`genre_id`, `releted_genre_id`) VALUES (1, 4);
INSERT INTO `itunes`.`related_genres` (`genre_id`, `releted_genre_id`) VALUES (2, 1);
INSERT INTO `itunes`.`related_genres` (`genre_id`, `releted_genre_id`) VALUES (2, 6);
INSERT INTO `itunes`.`related_genres` (`genre_id`, `releted_genre_id`) VALUES (3, 1);
INSERT INTO `itunes`.`related_genres` (`genre_id`, `releted_genre_id`) VALUES (3, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `itunes`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `itunes`;
INSERT INTO `itunes`.`user` (`id`, `name`, `email`) VALUES (1, 'Вілков Ігор', 'emeal1@gmailc.om');
INSERT INTO `itunes`.`user` (`id`, `name`, `email`) VALUES (2, 'Завадка Богдан', 'emeal@gmailc.om');
INSERT INTO `itunes`.`user` (`id`, `name`, `email`) VALUES (3, 'Шийка	Остап', 'emeal3@gmailc.om');
INSERT INTO `itunes`.`user` (`id`, `name`, `email`) VALUES (4, 'Гринишин	Анна', 'emeal4@gmailc.om');
INSERT INTO `itunes`.`user` (`id`, `name`, `email`) VALUES (5, 'Іжик Денис', 'emeal5@gmailc.om');
INSERT INTO `itunes`.`user` (`id`, `name`, `email`) VALUES (6, 'Мальчик Володимир', 'emeal6@gmailc.om');
INSERT INTO `itunes`.`user` (`id`, `name`, `email`) VALUES (7, 'Рущак Володимир', 'emeal7@gmailc.om');
INSERT INTO `itunes`.`user` (`id`, `name`, `email`) VALUES (8, 'Ямінський Марко', 'emeal8@gmailc.om');
INSERT INTO `itunes`.`user` (`id`, `name`, `email`) VALUES (9, 'Севастьянов Віталій', 'emeal9@gmailc.om');
INSERT INTO `itunes`.`user` (`id`, `name`, `email`) VALUES (10, 'Мороченець Максим', 'emeal10@gmailc.om');
INSERT INTO `itunes`.`user` (`id`, `name`, `email`) VALUES (11, 'Бондаренко	Ксенія', 'emeal11@gmailc.om');
INSERT INTO `itunes`.`user` (`id`, `name`, `email`) VALUES (12, 'Мамедова	Софія', 'emeal12@gmailc.om');
INSERT INTO `itunes`.`user` (`id`, `name`, `email`) VALUES (13, 'Лукачович	Павло', 'emeal13@gmailc.om');
INSERT INTO `itunes`.`user` (`id`, `name`, `email`) VALUES (14, 'Соколов Микита', 'emeal14@gmailc.om');
INSERT INTO `itunes`.`user` (`id`, `name`, `email`) VALUES (15, 'Пліш	Олег', 'emeal15@gmailc.om');

COMMIT;


-- -----------------------------------------------------
-- Data for table `itunes`.`user's_playlist_info`
-- -----------------------------------------------------
START TRANSACTION;
USE `itunes`;
INSERT INTO `itunes`.`user's_playlist_info` (`id`, `user_id`, `name`) VALUES (1, 2, 'Super muzlo');
INSERT INTO `itunes`.`user's_playlist_info` (`id`, `user_id`, `name`) VALUES (2, 5, 'Puper muzlo');
INSERT INTO `itunes`.`user's_playlist_info` (`id`, `user_id`, `name`) VALUES (3, 6, 'Super puper muzlo');

COMMIT;


-- -----------------------------------------------------
-- Data for table `itunes`.`songs_saved_by_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `itunes`;
INSERT INTO `itunes`.`songs_saved_by_user` (`song_id`, `user_id`) VALUES (1, 1);
INSERT INTO `itunes`.`songs_saved_by_user` (`song_id`, `user_id`) VALUES (4, 1);
INSERT INTO `itunes`.`songs_saved_by_user` (`song_id`, `user_id`) VALUES (8, 4);
INSERT INTO `itunes`.`songs_saved_by_user` (`song_id`, `user_id`) VALUES (1, 4);
INSERT INTO `itunes`.`songs_saved_by_user` (`song_id`, `user_id`) VALUES (4, 4);
INSERT INTO `itunes`.`songs_saved_by_user` (`song_id`, `user_id`) VALUES (5, 4);
INSERT INTO `itunes`.`songs_saved_by_user` (`song_id`, `user_id`) VALUES (2, 5);
INSERT INTO `itunes`.`songs_saved_by_user` (`song_id`, `user_id`) VALUES (1, 5);
INSERT INTO `itunes`.`songs_saved_by_user` (`song_id`, `user_id`) VALUES (4, 6);
INSERT INTO `itunes`.`songs_saved_by_user` (`song_id`, `user_id`) VALUES (2, 8);
INSERT INTO `itunes`.`songs_saved_by_user` (`song_id`, `user_id`) VALUES (5, 8);
INSERT INTO `itunes`.`songs_saved_by_user` (`song_id`, `user_id`) VALUES (1, 9);
INSERT INTO `itunes`.`songs_saved_by_user` (`song_id`, `user_id`) VALUES (2, 11);
INSERT INTO `itunes`.`songs_saved_by_user` (`song_id`, `user_id`) VALUES (9, 14);
INSERT INTO `itunes`.`songs_saved_by_user` (`song_id`, `user_id`) VALUES (5, 14);
INSERT INTO `itunes`.`songs_saved_by_user` (`song_id`, `user_id`) VALUES (1, 14);

COMMIT;


-- -----------------------------------------------------
-- Data for table `itunes`.`albums_saved_by_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `itunes`;
INSERT INTO `itunes`.`albums_saved_by_user` (`album_id`, `user_id`) VALUES (1, 1);
INSERT INTO `itunes`.`albums_saved_by_user` (`album_id`, `user_id`) VALUES (3, 2);
INSERT INTO `itunes`.`albums_saved_by_user` (`album_id`, `user_id`) VALUES (3, 3);
INSERT INTO `itunes`.`albums_saved_by_user` (`album_id`, `user_id`) VALUES (5, 4);
INSERT INTO `itunes`.`albums_saved_by_user` (`album_id`, `user_id`) VALUES (8, 5);
INSERT INTO `itunes`.`albums_saved_by_user` (`album_id`, `user_id`) VALUES (11, 6);
INSERT INTO `itunes`.`albums_saved_by_user` (`album_id`, `user_id`) VALUES (11, 7);
INSERT INTO `itunes`.`albums_saved_by_user` (`album_id`, `user_id`) VALUES (11, 8);
INSERT INTO `itunes`.`albums_saved_by_user` (`album_id`, `user_id`) VALUES (10, 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `itunes`.`user_prefer_genre`
-- -----------------------------------------------------
START TRANSACTION;
USE `itunes`;
INSERT INTO `itunes`.`user_prefer_genre` (`user_id`, `genre_id`) VALUES (1, 1);
INSERT INTO `itunes`.`user_prefer_genre` (`user_id`, `genre_id`) VALUES (1, 2);
INSERT INTO `itunes`.`user_prefer_genre` (`user_id`, `genre_id`) VALUES (5, 3);
INSERT INTO `itunes`.`user_prefer_genre` (`user_id`, `genre_id`) VALUES (6, 2);
INSERT INTO `itunes`.`user_prefer_genre` (`user_id`, `genre_id`) VALUES (6, 1);
INSERT INTO `itunes`.`user_prefer_genre` (`user_id`, `genre_id`) VALUES (6, 3);
INSERT INTO `itunes`.`user_prefer_genre` (`user_id`, `genre_id`) VALUES (7, 5);
INSERT INTO `itunes`.`user_prefer_genre` (`user_id`, `genre_id`) VALUES (9, 2);
INSERT INTO `itunes`.`user_prefer_genre` (`user_id`, `genre_id`) VALUES (11, 5);
INSERT INTO `itunes`.`user_prefer_genre` (`user_id`, `genre_id`) VALUES (15, 5);
INSERT INTO `itunes`.`user_prefer_genre` (`user_id`, `genre_id`) VALUES (15, 2);
INSERT INTO `itunes`.`user_prefer_genre` (`user_id`, `genre_id`) VALUES (15, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `itunes`.`_playlist_has_song`
-- -----------------------------------------------------
START TRANSACTION;
USE `itunes`;
INSERT INTO `itunes`.`_playlist_has_song` (`user's_playlist_info_id`, `song_id`) VALUES (1, 1);
INSERT INTO `itunes`.`_playlist_has_song` (`user's_playlist_info_id`, `song_id`) VALUES (1, 2);
INSERT INTO `itunes`.`_playlist_has_song` (`user's_playlist_info_id`, `song_id`) VALUES (1, 3);
INSERT INTO `itunes`.`_playlist_has_song` (`user's_playlist_info_id`, `song_id`) VALUES (1, 5);
INSERT INTO `itunes`.`_playlist_has_song` (`user's_playlist_info_id`, `song_id`) VALUES (2, 5);
INSERT INTO `itunes`.`_playlist_has_song` (`user's_playlist_info_id`, `song_id`) VALUES (2, 9);
INSERT INTO `itunes`.`_playlist_has_song` (`user's_playlist_info_id`, `song_id`) VALUES (2, 8);
INSERT INTO `itunes`.`_playlist_has_song` (`user's_playlist_info_id`, `song_id`) VALUES (2, 4);
INSERT INTO `itunes`.`_playlist_has_song` (`user's_playlist_info_id`, `song_id`) VALUES (2, 3);
INSERT INTO `itunes`.`_playlist_has_song` (`user's_playlist_info_id`, `song_id`) VALUES (3, 9);
INSERT INTO `itunes`.`_playlist_has_song` (`user's_playlist_info_id`, `song_id`) VALUES (3, 11);
INSERT INTO `itunes`.`_playlist_has_song` (`user's_playlist_info_id`, `song_id`) VALUES (3, 12);
INSERT INTO `itunes`.`_playlist_has_song` (`user's_playlist_info_id`, `song_id`) VALUES (3, 15);

COMMIT;


-- -----------------------------------------------------
-- Data for table `itunes`.`song_commercial`
-- -----------------------------------------------------
START TRANSACTION;
USE `itunes`;
INSERT INTO `itunes`.`song_commercial` (`song_id`, `price`, `num_of_downloads`) VALUES (1, 1.00, 13303);
INSERT INTO `itunes`.`song_commercial` (`song_id`, `price`, `num_of_downloads`) VALUES (2, 1.50, 42424);
INSERT INTO `itunes`.`song_commercial` (`song_id`, `price`, `num_of_downloads`) VALUES (3, 2.00, 41564);
INSERT INTO `itunes`.`song_commercial` (`song_id`, `price`, `num_of_downloads`) VALUES (4, 1.00, 56213);
INSERT INTO `itunes`.`song_commercial` (`song_id`, `price`, `num_of_downloads`) VALUES (5, 2.00, 42612);
INSERT INTO `itunes`.`song_commercial` (`song_id`, `price`, `num_of_downloads`) VALUES (6, 0.50, 121213);
INSERT INTO `itunes`.`song_commercial` (`song_id`, `price`, `num_of_downloads`) VALUES (7, 0.80, 42162);
INSERT INTO `itunes`.`song_commercial` (`song_id`, `price`, `num_of_downloads`) VALUES (8, 0.25, 43641242);
INSERT INTO `itunes`.`song_commercial` (`song_id`, `price`, `num_of_downloads`) VALUES (9, 0.50, 424132);
INSERT INTO `itunes`.`song_commercial` (`song_id`, `price`, `num_of_downloads`) VALUES (10, 0.35, 124661);
INSERT INTO `itunes`.`song_commercial` (`song_id`, `price`, `num_of_downloads`) VALUES (11, 0.40, 4212343);
INSERT INTO `itunes`.`song_commercial` (`song_id`, `price`, `num_of_downloads`) VALUES (12, 0.21, 213411);
INSERT INTO `itunes`.`song_commercial` (`song_id`, `price`, `num_of_downloads`) VALUES (13, 0.55, 4214631);
INSERT INTO `itunes`.`song_commercial` (`song_id`, `price`, `num_of_downloads`) VALUES (14, 0.80, 21466);
INSERT INTO `itunes`.`song_commercial` (`song_id`, `price`, `num_of_downloads`) VALUES (15, 0.74, 465216);

COMMIT;


-- -----------------------------------------------------
-- Data for table `itunes`.`user_credential`
-- -----------------------------------------------------
START TRANSACTION;
USE `itunes`;
INSERT INTO `itunes`.`user_credential` (`user_id`, `password`) VALUES (1, 'password');
INSERT INTO `itunes`.`user_credential` (`user_id`, `password`) VALUES (2, 'password');
INSERT INTO `itunes`.`user_credential` (`user_id`, `password`) VALUES (3, 'password');
INSERT INTO `itunes`.`user_credential` (`user_id`, `password`) VALUES (4, 'password');
INSERT INTO `itunes`.`user_credential` (`user_id`, `password`) VALUES (5, 'password');
INSERT INTO `itunes`.`user_credential` (`user_id`, `password`) VALUES (6, 'password');
INSERT INTO `itunes`.`user_credential` (`user_id`, `password`) VALUES (7, 'password');
INSERT INTO `itunes`.`user_credential` (`user_id`, `password`) VALUES (8, 'password');
INSERT INTO `itunes`.`user_credential` (`user_id`, `password`) VALUES (9, 'password');
INSERT INTO `itunes`.`user_credential` (`user_id`, `password`) VALUES (10, 'password');
INSERT INTO `itunes`.`user_credential` (`user_id`, `password`) VALUES (11, 'password');
INSERT INTO `itunes`.`user_credential` (`user_id`, `password`) VALUES (12, 'password');
INSERT INTO `itunes`.`user_credential` (`user_id`, `password`) VALUES (13, 'password');
INSERT INTO `itunes`.`user_credential` (`user_id`, `password`) VALUES (14, 'password');
INSERT INTO `itunes`.`user_credential` (`user_id`, `password`) VALUES (15, 'password');

COMMIT;


-- -----------------------------------------------------
-- Data for table `itunes`.`song_has_author`
-- -----------------------------------------------------
START TRANSACTION;
USE `itunes`;
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (1, 1);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (2, 2);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (3, 3);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (4, 4);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (5, 5);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (5, 6);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (6, 7);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (6, 8);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (7, 9);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (8, 10);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (8, 11);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (9, 12);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (10, 13);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (10, 14);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (11, 15);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (11, 16);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (12, 1);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (13, 17);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (14, 18);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (15, 19);
INSERT INTO `itunes`.`song_has_author` (`song_id`, `author_id`) VALUES (10, 20);

COMMIT;


-- -----------------------------------------------------
-- Data for table `itunes`.`album_has_author`
-- -----------------------------------------------------
START TRANSACTION;
USE `itunes`;
INSERT INTO `itunes`.`album_has_author` (`album_id`, `author_id`) VALUES (1, 1);
INSERT INTO `itunes`.`album_has_author` (`album_id`, `author_id`) VALUES (2, 2);
INSERT INTO `itunes`.`album_has_author` (`album_id`, `author_id`) VALUES (3, 3);
INSERT INTO `itunes`.`album_has_author` (`album_id`, `author_id`) VALUES (4, 4);
INSERT INTO `itunes`.`album_has_author` (`album_id`, `author_id`) VALUES (5, 9);
INSERT INTO `itunes`.`album_has_author` (`album_id`, `author_id`) VALUES (6, 10);
INSERT INTO `itunes`.`album_has_author` (`album_id`, `author_id`) VALUES (7, 12);
INSERT INTO `itunes`.`album_has_author` (`album_id`, `author_id`) VALUES (8, 13);
INSERT INTO `itunes`.`album_has_author` (`album_id`, `author_id`) VALUES (9, 15);
INSERT INTO `itunes`.`album_has_author` (`album_id`, `author_id`) VALUES (11, 19);

COMMIT;

