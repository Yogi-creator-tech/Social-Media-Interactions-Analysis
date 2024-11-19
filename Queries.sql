-- 1) The Location of User 
SELECT * FROM post
WHERE location IN ('agra' ,'maharashtra','west bengal');


-- 2) Determine the most Followed Hashtag
SELECT 
	hashtag_name AS 'Hashtags', COUNT(hashtag_follow.hashtag_id) AS 'Total Number of Follows' 
FROM hashtag_follow, hashtags 
WHERE hashtags.hashtag_id = hashtag_follow.hashtag_id
GROUP BY hashtag_follow.hashtag_id
ORDER BY COUNT(hashtag_follow.hashtag_id) DESC LIMIT 10;

-- 3) The Most Used Hashtags on this social media platform
SELECT 
	hashtag_name AS 'Trending Hashtags right now', 
    COUNT(post_tags.hashtag_id) AS ' Number of times '
FROM hashtags,post_tags
WHERE hashtags.hashtag_id = post_tags.hashtag_id
GROUP BY post_tags.hashtag_id
ORDER BY COUNT(post_tags.hashtag_id) DESC LIMIT 10;


-- 4) Most Inactive User
SELECT user_id, username AS ' The most Inactive User'
FROM users
WHERE user_id NOT IN (SELECT user_id FROM post);

 
-- 5) The post having most Likes 

SELECT post_likes.user_id, post_likes.post_id, COUNT(post_likes.post_id) 
FROM post_likes, post
WHERE post.post_id = post_likes.post_id 
GROUP BY post_likes.post_id
ORDER BY COUNT(post_likes.post_id) DESC ;

-- 6) Average post per user on this platform
SELECT 
    ROUND(COUNT(post_id) / COUNT(DISTINCT user_id), 2) AS 'Average Posts per User'
FROM post;

-- 7) Number of login by per user
SELECT user_id, email, username, login.login_id AS login_no
FROM users 
NATURAL JOIN login;


-- 8) User who liked every single post (CHECK FOR BOT)
SELECT u.username, COUNT(*) AS num_likes
FROM users u
INNER JOIN post_likes pl ON u.user_id = pl.user_id
GROUP BY u.user_id
HAVING COUNT(*) = (SELECT COUNT(*) FROM post);


-- 9) User that Never Commented 
SELECT user_id, username AS 'User Never Comment'
FROM users
WHERE user_id NOT IN (SELECT user_id FROM comments);

-- 10) User who has commented on every post 
SELECT username, Count(*) AS number_comment 
FROM users 
INNER JOIN comments ON users.user_id = comments.user_id 
GROUP  BY comments.user_id 
HAVING num_comment = (SELECT Count(*) FROM comments); 


-- 11) User Not Followed by anyone
SELECT user_id, username AS 'User Not Followed by anyone'
FROM users
WHERE user_id NOT IN (SELECT followee_id FROM follows);

-- 12) User Not Following Anyone
SELECT user_id, username AS 'User Not Following Anyone'
FROM users
WHERE user_id NOT IN (SELECT follower_id FROM follows);

-- 13) Posted more than 5 times
SELECT user_id, COUNT(user_id) AS post_count FROM post
GROUP BY user_id
HAVING post_count > 5
ORDER BY COUNT(user_id) DESC;


-- 14) Followers having > 40
SELECT followee_id, COUNT(follower_id) AS follower_count FROM follows
GROUP BY followee_id
HAVING follower_count > 40
ORDER BY COUNT(follower_id) DESC;


-- 15) Any specific word in comment
SELECT * FROM comments
WHERE comment_text REGEXP'good|beautiful';


-- 16) Longest captions in post
SELECT user_id, caption, 
LENGTH(post.caption) AS caption_length FROM post
ORDER BY caption_length DESC LIMIT 5;