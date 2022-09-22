-- 1. Get all songs by author
set
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
    left join song_commercial on song.id = song_id
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
    left join song_commercial on id = song_id
ORDER BY
    id;

-- 3. Get all songs from album
set
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
    left join song_commercial on id = song_id
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
set
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
where
    label_id in (
        select
            id
        from
            label
        where
            name = @label_name
    );

-- 5. get song by genre
set
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
    left join song_commercial on id = song_id
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
set
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
    left join song_commercial on song.id = song_id
where
    id in (
        select
            song_id
        from
            songs_saved_by_user
        where
            user_id = @user_id
    )
union
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
    left join song_commercial on id = song_id
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
set
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
where
    id in (
        select
            album_id
        from
            albums_saved_by_user
        where
            user_id = @user_id
    );

-- 8. Get users playlists by user
select
    id,
    playlist.name,
    (
        select
            name
        from
            user
        where
            id = user_id
    ) as 'user name',
    user_id
from
    user_playlist_info as playlist;

-- 9. Get all songs by playlist
set
    @playlist_id = 2;

select
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
from
    song
    left join song_commercial on song.id = song_id
where
    id in (
        select
            song_id
        from
            playlist_has_song
        where
            user_playlist_info_id = @playlist_id
    );

-- 10. Get all songs by user genres
set
    @user_id = 1;

select
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
from
    song
    left join song_commercial on song.id = song_id
where
    genre_id in (
        select
            genre_id
        from
            user_prefer_genre
        where
            user_id = @user_id
    );