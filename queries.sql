-- 1. Get all songs by author
SET
    @author_name = 'Harry Styles';

SELECT
    id,
    name,
    length,
    album_id,
    (
        SELECT
            name
        FROM
            album
        WHERE
            id = song.album_id
        LIMIT
            1
    ) AS album,
    (
        SELECT
            GROUP_CONCAT(name)
        FROM
            author
        WHERE
            EXISTS(
                SELECT
                    *
                FROM
                    song_has_author
                WHERE
                    song_id = song.id
                    AND author_id = author.id
            )
    ) AS authors,
    genre_id,
    (
        SELECT
            name
        FROM
            genre
        WHERE
            genre_id = id
    ) AS genre,
    price,
    num_of_downloads
FROM
    song
    LEFT JOIN song_commercial ON song.id = song_id
WHERE
    EXISTS(
        SELECT
            *
        FROM
            song_has_author
        WHERE
            author_id = (
                SELECT
                    id
                FROM
                    author
                WHERE
                    @author_name = name
                LIMIT
                    1
            )
            AND song_id = id
    );

-- 2. Get all songs normalized
SELECT
    id,
    name,
    length,
    album_id,
    (
        SELECT
            name
        FROM
            album
        WHERE
            id = song.album_id
        LIMIT
            1
    ) AS album,
    (
        SELECT
            GROUP_CONCAT(name)
        FROM
            author
        WHERE
            EXISTS(
                SELECT
                    *
                FROM
                    song_has_author
                WHERE
                    song_id = song.id
                    AND author_id = author.id
            )
    ) AS authors,
    genre_id,
    (
        SELECT
            name
        FROM
            genre
        WHERE
            genre_id = id
    ) AS genre,
    price,
    num_of_downloads
FROM
    song
    LEFT JOIN song_commercial ON id = song_id
ORDER BY
    id;

-- 3. Get all songs from album
SET
    @album_name = 'Special';

SELECT
    id,
    name,
    length,
    album_id,
    (
        SELECT
            name
        FROM
            album
        WHERE
            id = song.album_id
        LIMIT
            1
    ) AS album,
    (
        SELECT
            GROUP_CONCAT(name)
        FROM
            author
        WHERE
            EXISTS(
                SELECT
                    *
                FROM
                    song_has_author
                WHERE
                    song_id = song.id
                    AND author_id = author.id
            )
    ) AS authors,
    genre_id,
    (
        SELECT
            name
        FROM
            genre
        WHERE
            genre_id = id
    ) AS genre,
    price,
    num_of_downloads
FROM
    song
    LEFT JOIN song_commercial ON id = song_id
WHERE
    album_id IN (
        SELECT
            id
        FROM
            album
        WHERE
            name = @album_name
    );

-- 4. Get albums by label
SET
    @label_name = 'Columbia Records';

SELECT
    id,
    name,
    (
        SELECT
            GROUP_CONCAT(name)
        FROM
            author
        WHERE
            EXISTS(
                SELECT
                    *
                FROM
                    album_has_author
                WHERE
                    album_id = album.id
                    AND author_id = author.id
            )
    ) AS authors,
    year_of_publishing,
    price,
    label_id,
    num_of_downloads
FROM
    album
    LEFT JOIN album_commercial ON id = album_id
WHERE
    label_id IN (
        SELECT
            id
        FROM
            label
        WHERE
            name = @label_name
    );

-- 5. get song by genre
SET
    @genre = 'Hip-Hop';

SELECT
    id,
    name,
    length,
    album_id,
    (
        SELECT
            name
        FROM
            album
        WHERE
            id = song.album_id
        LIMIT
            1
    ) AS album,
    (
        SELECT
            GROUP_CONCAT(name)
        FROM
            author
        WHERE
            EXISTS(
                SELECT
                    *
                FROM
                    song_has_author
                WHERE
                    song_id = song.id
                    AND author_id = author.id
            )
    ) AS authors,
    genre_id,
    price,
    num_of_downloads
FROM
    song
    LEFT JOIN song_commercial ON id = song_id
WHERE
    genre_id IN (
        SELECT
            id
        FROM
            genre
        WHERE
            name = @genre
    );

-- 6. Get all songs by user
SET
    @user_id = 1;

SELECT
    id,
    name,
    length,
    album_id,
    (
        SELECT
            GROUP_CONCAT(name)
        FROM
            author
        WHERE
            EXISTS(
                SELECT
                    *
                FROM
                    song_has_author
                WHERE
                    song_id = song.id
                    AND author_id = author.id
            )
    ) AS authors,
    genre_id,
    (
        SELECT
            name
        FROM
            genre
        WHERE
            genre_id = id
    ) AS genre,
    price,
    num_of_downloads
FROM
    song
    LEFT JOIN song_commercial ON song.id = song_id
WHERE
    id IN (
        SELECT
            song_id
        FROM
            songs_saved_by_user
        WHERE
            user_id = @user_id
    )
UNION
SELECT
    id,
    name,
    length,
    album_id,
    (
        SELECT
            GROUP_CONCAT(name)
        FROM
            author
        WHERE
            EXISTS(
                SELECT
                    *
                FROM
                    song_has_author
                WHERE
                    song_id = song.id
                    AND author_id = author.id
            )
    ) AS authors,
    genre_id,
    (
        SELECT
            name
        FROM
            genre
        WHERE
            genre_id = id
    ) AS genre,
    price,
    num_of_downloads
FROM
    song
    LEFT JOIN song_commercial ON id = song_id
WHERE
    album_id IN (
        SELECT
            album_id
        FROM
            albums_saved_by_user
        WHERE
            user_id = @user_id
    );

-- 7. Get all albums by user
SET
    @user_id = 1;

SELECT
    id,
    name,
    (
        SELECT
            GROUP_CONCAT(name)
        FROM
            author
        WHERE
            EXISTS(
                SELECT
                    *
                FROM
                    album_has_author
                WHERE
                    album_id = album.id
                    AND author_id = author.id
            )
    ) AS authors,
    year_of_publishing,
    price,
    label_id,
    num_of_downloads
FROM
    album
    LEFT JOIN album_commercial ON id = album_id
WHERE
    id IN (
        SELECT
            album_id
        FROM
            albums_saved_by_user
        WHERE
            user_id = @user_id
    );

-- 8. Get users playlists by user
SELECT
    id,
    playlist.name,
    (
        SELECT
            name
        FROM
            user
        WHERE
            id = user_id
    ) AS 'user name',
    user_id
FROM
    user_playlist_info AS playlist;

-- 9. Get all songs by playlist
SET
    @playlist_id = 2;

SELECT
    id,
    name,
    length,
    album_id,
    (
        SELECT
            name
        FROM
            album
        WHERE
            id = song.album_id
        LIMIT
            1
    ) AS album,
    (
        SELECT
            GROUP_CONCAT(name)
        FROM
            author
        WHERE
            EXISTS(
                SELECT
                    *
                FROM
                    song_has_author
                WHERE
                    song_id = song.id
                    AND author_id = author.id
            )
    ) AS authors,
    genre_id,
    (
        SELECT
            name
        FROM
            genre
        WHERE
            genre_id = id
    ) AS genre,
    price,
    num_of_downloads
FROM
    song
    LEFT JOIN song_commercial ON song.id = song_id
WHERE
    id IN (
        SELECT
            song_id
        FROM
            playlist_has_song
        WHERE
            user_playlist_info_id = @playlist_id
    );

-- 10. Get all songs by user genres
SET
    @user_id = 1;

SELECT
    id,
    name,
    length,
    album_id,
    (
        SELECT
            name
        FROM
            album
        WHERE
            id = song.album_id
        LIMIT
            1
    ) AS album,
    (
        SELECT
            GROUP_CONCAT(name)
        FROM
            author
        WHERE
            EXISTS(
                SELECT
                    *
                FROM
                    song_has_author
                WHERE
                    song_id = song.id
                    AND author_id = author.id
            )
    ) AS authors,
    genre_id,
    (
        SELECT
            name
        FROM
            genre
        WHERE
            genre_id = id
    ) AS genre,
    price,
    num_of_downloads
FROM
    song
    LEFT JOIN song_commercial ON song.id = song_id
WHERE
    genre_id IN (
        SELECT
            genre_id
        FROM
            user_prefer_genre
        WHERE
            user_id = @user_id
    );