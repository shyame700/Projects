select * from social_media_engagement

-- 1. Average engagement rate by platform

SELECT platform, AVG(engagement_rate) AS avg_engagement
FROM social_media_engagement
GROUP BY platform;

-- 2. Top 5 most liked posts

SELECT top 5 post_id, likes_count
FROM social_media_engagement
ORDER BY likes_count DESC

-- 3. Daily post distribution

SELECT day_of_week, COUNT(*) AS post_count
FROM social_media_engagement
GROUP BY day_of_week
ORDER BY post_count;

-- 4. Sentiment distribution by campaign

with cte as (
SELECT campaign_name, sentiment_label, COUNT(*) AS total
FROM social_media_engagement
GROUP BY campaign_name,sentiment_label

)
SELECT campaign_name,sentiment_label,total
FROM cte 
ORDER BY campaign_name,total DESC;

---5.How does user sentiment and engagement vary across different social media platforms and campaign phases
SELECT 
    platform,
    campaign_phase,
    AVG(engagement_rate) AS avg_engagement,
    AVG(sentiment_score) AS avg_sentiment,
    AVG(toxicity_score) AS avg_toxicity
FROM social_media_engagement
GROUP BY platform, campaign_phase
ORDER BY avg_engagement DESC;


--Engagement & Reach Insights

---- Most engaging post types (based on engagement rate)

SELECT topic_category, AVG(engagement_rate) AS avg_engagement
FROM social_media_engagement
GROUP BY topic_category
ORDER BY avg_engagement DESC;

-- Engagement rate by day of the week

SELECT day_of_week, AVG(engagement_rate) AS avg_engagement
FROM social_media_engagement
GROUP BY day_of_week
ORDER BY day(day_of_week);

--Sentiment & Emotion Analysis

-- Distribution of sentiment labels

SELECT sentiment_label, COUNT(*) AS count
FROM social_media_engagement
GROUP BY sentiment_label;

-- Top 5 emotions that correlate with high engagement
SELECT emotion_type, AVG(engagement_rate) AS avg_engagement
FROM social_media_engagement
GROUP BY emotion_type
ORDER BY avg_engagement DESC;


-- Toxicity Monitoring

-- Average toxicity score by platform

SELECT platform, AVG(toxicity_score) AS avg_toxicity
FROM social_media_engagement
GROUP BY platform
ORDER BY avg_toxicity DESC;

-- Posts with high toxicity (alert for moderation)

SELECT post_id, toxicity_score, text_content
FROM social_media_engagement
WHERE toxicity_score > 0.8
ORDER BY toxicity_score DESC;


--Campaign & Brand Performance

-- Best performing campaigns (based on average engagement)

SELECT campaign_name, AVG(engagement_rate) AS avg_engagement
FROM social_media_engagement
GROUP BY campaign_name
ORDER BY avg_engagement DESC;

-- Brand with highest average user growth
SELECT brand_name, AVG(user_engagement_growth) AS avg_growth
FROM social_media_engagement
GROUP BY brand_name
ORDER BY avg_growth DESC;


--Influencer & User Behavior
-- Users with highest past sentiment average

SELECT top 10 platform,user_id, AVG(user_past_sentiment_avg) AS avg_sentiment
FROM social_media_engagement
GROUP BY user_id,platform
ORDER BY avg_sentiment DESC;

-- Users with the highest engagement growth

SELECT top 10	platform,user_id, MAX(user_engagement_growth) AS max_growth
FROM social_media_engagement
GROUP BY user_id,platform
ORDER BY max_growth DESC;


-- Top posts with highest buzz change rate

SELECT top 10 platform,post_id, buzz_change_rate, text_content
FROM social_media_engagement
ORDER BY buzz_change_rate DESC;

